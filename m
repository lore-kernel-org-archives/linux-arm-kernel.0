From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Apr 2016 15:15:25 +0200
Subject: [PATCH] arm64: KVM: unregister notifiers in hyp mode teardown path
In-Reply-To: <57050A82.7030905@arm.com>
References: <1459777611-22592-1-git-send-email-sudeep.holla@arm.com>
 <20160406115250.GC16355@cbox> <57050A82.7030905@arm.com>
Message-ID: <20160406131525.GD16355@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 02:09:22PM +0100, Sudeep Holla wrote:
> Hi Christoffer,
> 
> On 06/04/16 12:52, Christoffer Dall wrote:
> >Hi Sudeep,
> >
> >
> >On Mon, Apr 04, 2016 at 02:46:51PM +0100, Sudeep Holla wrote:
> >>Commit 1e947bad0b63 ("arm64: KVM: Skip HYP setup when already running
> >>in HYP") re-organized the hyp init code and ended up leaving the CPU
> >>hotplug and PM notifier even if hyp mode initialization fails.
> >>
> >>Since KVM is not yet supported with ACPI, the above mentioned commit
> >>breaks CPU hotplug in ACPI boot.
> >>
> >>This patch fixes teardown_hyp_mode to properly unregister both CPU
> >>hotplug and PM notifiers in the teardown path.
> >>
> >>Fixes: 1e947bad0b63 ("arm64: KVM: Skip HYP setup when already running in HYP")
> >>Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> >I fixed up your patch to apply after James' patch:
> >5f5560b (arm64: KVM: Register CPU notifiers when the kernel runs at HYP, 2016-03-30)
> >
> 
> Thanks for that, sorry I didn't realize it would conflict with that change.
> 
> >My only concern with this approach is that we're not checking the return
> >values from the cpu_pm_register_notifier calls, and we're potentially
> >calling unregister_cpu_notifier even if the original registration
> >failed.
> >
> 
> I agree with your concern and I had the same when I first wrote the
> patch. But considering the return values makes it unnecessarily ugly, so
> I dropped it and kept it simple.
> 
> >I know this can't happen given current implementations, but if any of
> >these functions ever start returning error values, then we're silently
> >ignoring them.  What is our policy on these things?
> >
> 
> I am fine to handle that, but as you mentioned it's not really needed.
> May be we can add some error message if that's really required.
> 

Hopefully we're not the only ones taking a slight shortcut here, so
anyone modifying those functions will notice it when doing so...

> >Let me know if the following revised version of your patch looks ok to
> >you (against kvmarm/master):
> >
> 
> Looks fine and tested kvmarm/master with this patch on top.
> 

Thanks, will queue it then.

-Christoffer
