From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Oct 2013 23:11:23 +0100
Subject: [PATCH] arm: vfp: always clear vfp_current_hw_state when
 forcing reload
In-Reply-To: <1380751187-11257-1-git-send-email-zyy@motorola.com>
References: <1380751187-11257-1-git-send-email-zyy@motorola.com>
Message-ID: <20131002221123.GC12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 04:59:47PM -0500, Yuanyuan Zhong wrote:
> The current thread trying to clear the held vfp state may not be
> the owner of hw state. For example,
> 	Core0			Core1
> 				Thread1 uses VFP.
> 				  Thread1 vfpstate.hard.cpu = 1.
> 				  vfp_current_hw_state[1] points to Thread1
> 				    vfpstate.
> 	Going to suspend.
> 	Freeze Thread1.
> 				Thread1 is switched out.
> 				VFP HW registers saved to Thread1 vfpstate.

Correct so far.  At this point:

				vfp_current_hw_state[1] = &thread1->vfpstate;
				thread1->vfpstate.hard.cpu = 1;

> 	Core0 disables Core1.
> 				Stopper thread calls vfp_force_reload().
> 				Stopper thread vfpstate.hard.cpu = NR_CPUS.

Correct, except there's another part to this.  vfp_state_in_hw() returns
true here, since thread1->vfpstate.hard.cpu is the dying CPU (CPU 1), and
vfp_current_hw_state[1] is &thread1->vfpstate.  So we also do this:

				clear FPEXC_EN
				vfp_current_hw_state[1] = NULL;

> 				...
> 				(No PM notifier for non-idle path. So
> 				  vfp_pm_suspend() is NOT called on Core1.)
> 				...
> 				Core1 is off and VFP HW registers are lost.
> 	...
> 	Core0 enables Core1.
> 	Core0 thaw Thread1.
> 	Thread1 migrate to Core1
> 	  before using VFP.
> 				Thread1 starts using VFP.
> 				Now we have vfp_current_hw_state[1] points
> 				  to Thread1 vfpstate. And Thread1 has
> 				  vfpstate.hard.cpu = 1.

No.  With my above correction:
				vfp_current_hw_state[1] = NULL

and that forces a reload of the saved context.
