From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Feb 2015 10:17:55 +0000
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
In-Reply-To: <54E7AC90.40209@codeaurora.org>
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org>
 <20150213105447.GB3508@e104818-lin.cambridge.arm.com>
 <loom.20150213T124417-857@post.gmane.org>
 <20150213141425.GA4713@localhost>
 <loom.20150213T153239-809@post.gmane.org>
 <20150213153253.GA23801@e104818-lin.cambridge.arm.com>
 <loom.20150218T122348-60@post.gmane.org>
 <54E7AC90.40209@codeaurora.org>
Message-ID: <20150224101754.GA27420@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 04:52:16PM -0500, Christopher Covington wrote:
> On 02/18/2015 07:12 AM, Venkappa Mala wrote:
> > Catalin Marinas <catalin.marinas <at> arm.com> writes:
> >> IIRC there were some discussions about Linux booting in secure mode on
> >> ARMv7 with no firmware to initialise the Hyp registers. If that's the
> >> case for you, we could restart that discussion and try to initialise
> >> CNTVOFF in the kernel running in _secure_ mode (possibly with some CPU
> >> notifiers in the generic timer code).
> > 
> > My test environment is like CNTVOFF initialization is not taken care in 
> > the firmware, HYP mode is disabled and kernel is booted with Secure SVC 
> > PL1 mode. As you have mentioned about restarting the thread, perhaps, it 
> > will be good to have a discussion in the following  thread rather than 
> > restarting the thread.
> > arm: Handle starting up in secure mode
> > https://lkml.org/lkml/2014/9/16/552
> > 
> > May I know your opinion about this one?
> 
> Catalin pointed out that accesses to NSACR may trap. I have not yet found a
> reason why trying to write to CNTFRQ wouldn't work.

Writing CNTFRQ from non-secure mode would trap as well. For whatever
reason, the architecture doesn't allow you to easily detect whether the
code runs in secure or non-secure mode (unless it is EL2/Hyp which is
always non-secure). The detection mechanism would have to involve
trapping of an undefined instruction but it doesn't need to be done
early during boot.

Otherwise, I think in the arch timer code we could do something like:

	if (!is_hyp_mode_available() && !arch_timer_user_virtual &&
	    arch_timer_ppi[PHYS_SECURE_PPI]) {
		/*
		 * Assume the kernel is running in secure mode. Program
		 * the CNVOFF and CNTFRQ registers.
		 */
		...
	}

-- 
Catalin
