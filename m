From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 19:20:46 +0100
Subject: [PATCH] ARM: fix PTRACE_SETVFPREGS on SMP systems
In-Reply-To: <E1b7oBz-0005wE-1t@rmk-PC.armlinux.org.uk>
References: <E1b7oBz-0005wE-1t@rmk-PC.armlinux.org.uk>
Message-ID: <20160531182045.GZ24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 07:15:03PM +0100, Russell King wrote:
> PTRACE_SETVFPREGS fails to properly mark the VFP register set to be
> reloaded, because it undoes one of the effects of vfp_flush_hwstate().
> 
> Specifically vfp_flush_hwstate() sets thread->vfpstate.hard.cpu to
> an invalid CPU number, but vfp_set() overwrites this with the original
> CPU number, thereby rendering the hardware state as apparently "valid",
> even though the software state is more recent.
> 
> Fix this by reverting the previous change.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8130b9d7b9d8 ("ARM: 7308/1: vfp: flush thread hwstate before copying ptrace registers")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Will, please ack this.

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> 
>  arch/arm/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
