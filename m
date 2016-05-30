From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 May 2016 23:40:28 +0100
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
In-Reply-To: <20160530213529.GS19428@n2100.arm.linux.org.uk>
References: <574C7CDB.7050103@ericsson.com>
 <20160530213529.GS19428@n2100.arm.linux.org.uk>
Message-ID: <20160530224028.GT19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:35:29PM +0100, Russell King - ARM Linux wrote:
> With that, on a single CPU, it seems to work correctly every time, but
> if I bring up a secondary CPU I start seeing the same problems you've
> reported - which seems to need the following patch to solve.  Please can
> you check whether this resolves your problem?

More background behind this patch... I think that commit 8130b9d7b9d8
("ARM: 7308/1: vfp: flush thread hwstate before copying ptrace registers")
was wrong.

Let's look at what's happening.  The above commit had the following effect:

	vfp_sync_hwstate();
	new_vfp = thread->vfpstate.hard;
	modify new_vfp (but not new_vfp.cpu)
+	vfp_flush_hwstate(thread);
	thread->vfpstate.hard = new_vfp;
-	vfp_flush_hwstate(thread);

Now, the commit above claims that a context switch mid-copy of new_vfp
into thread->vfpstate.hard may result in corrupted state.

I'm not quite sure how we could get to that point: the only thread which
is allowed to touch the traced child's state is the ptracing parent, and
the ptracing parent can't do anything until after vfp_set() has returned.
Even if the traced child gets a fatal signal, the point at which the
signal is delivered to the child is when returning to userspace, which
means the child must be runnable.  That in turn means that we are not
in the middle of changing the register state.

So, I'm not sure where Will got the idea that the partially copied state
would be visible: it shouldn't ever be visible.  If it is visible, then
we've got problems even with Will's patch applied, because a partial
copy whenever it happens would be visible.

In any case, the above change is wrong: vfp_flush_hwstate() sets
thread->vfpstate.hard.cpu to an invalid CPU number.  Switching the order
as Will has done _undoes_ the effect of vfp_flush_hwstate(), which leads
to the bug you are seeing.

So, I think the correct approach is to revert it.

If the partially copied state _is_ visible somehow, that needs to be
better documented - the original commit fails to indicate how the
partially copied state becomes visible as a result of a context switch.

> 
> Thanks.
> 
>  arch/arm/kernel/ptrace.c | 2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ef9119f7462e..4d9375814b53 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -733,8 +733,8 @@ static int vfp_set(struct task_struct *target,
>  	if (ret)
>  		return ret;
>  
> -	vfp_flush_hwstate(thread);
>  	thread->vfpstate.hard = new_vfp;
> +	vfp_flush_hwstate(thread);
>  
>  	return 0;
>  }
> 
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
