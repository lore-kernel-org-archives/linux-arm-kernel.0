From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Feb 2011 12:12:25 +0000
Subject: [RFC PATCH 3/3] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <1297373487-23902-4-git-send-email-ccross@android.com>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
	<1297373487-23902-4-git-send-email-ccross@android.com>
Message-ID: <1297426345.17584.99.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

On Thu, 2011-02-10 at 21:31 +0000, Colin Cross wrote:
> +static int vfp_idle_notifier(struct notifier_block *self, unsigned long cmd,
> +       void *v)
> +{
> +       u32 fpexc = fmrx(FPEXC);
> +       unsigned int cpu = smp_processor_id();
> +
> +       if (cmd != CPU_PM_ENTER)
> +               return NOTIFY_OK;
> +
> +       /* The VFP may be reset in idle, save the state */
> +       if ((fpexc & FPEXC_EN) && last_VFP_context[cpu]) {
> +               vfp_save_state(last_VFP_context[cpu], fpexc);
> +               last_VFP_context[cpu]->hard.cpu = cpu;
> +       }

Should we only handle the case where the VFP is enabled? At context
switch we disable the VFP and re-enable it when an application tries to
use it but it will remain disabled even the application hasn't used the
VFP. So switching to the idle thread would cause the VFP to be disabled
but the state not necessarily saved.

On SMP systems, we save the VFP at every context switch to deal with the
thread migration (though I have a plan to make this lazily on SMP as
well). On UP however, we don't save the VFP registers at context switch,
we just disable it and save it lazily if used later in a different task

Something like below (untested):

	if (last_VFP_context[cpu]) {
		vfp_save_state(last_VFP_context[cpu], fpexc);
		/* force a reload when coming back from idle */
		last_VFP_context[cpu] = NULL;
		fmxr(FPEXC, fpexc & ~FPEXC_EN);
	}

The last line (disabling) may not be necessary if we know that it comes
back from idle as disabled.

I wonder whether the current vfp_pm_suspend() function needs fixing for
UP systems as well. It is find if the hardware preserves the VFP
registers (which may not be the case).

-- 
Catalin
