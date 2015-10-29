From: amittomer25@gmail.com (Amit Tomer)
Date: Thu, 29 Oct 2015 19:17:31 +0530
Subject: [PATCH v1] Ftrace: arm/arm64: Define a new arm/arm64 trace clock
 source based on CNTPCT/CNTPCT_EL0 register.
In-Reply-To: <20151029113849.GC28221@leverpostej>
References: <1445854558-16253-1-git-send-email-amittomer25@gmail.com>
 <20151028124726.GD25451@leverpostej>
 <CABHD4K-KugtaLvc98wEMWm0iN_3v=d2UYkSmpSMCX91s-EAnhg@mail.gmail.com>
 <20151029113849.GC28221@leverpostej>
Message-ID: <CABHD4K_DXCNpOS9esA9yEANaYocNMG3fcQ4_uRTKQHF-8JiQvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Regardless of the host, you cannot know whether it is safe to access
> in a guest. It could bring down the system.
>
> The host kernel could safely access the physical counter were it booted
> at EL2, because it could grant itself access.

May be I am totally wrong here but it doesn't look to be good . if
Linux image does not boot at hyp mode,
there is no way to use arch timers, Not true?

But I could see even if Linux image booted in EL1 has the access to
Physical timer/counters that is
been allowed by firmware it self.

ENTRY(armv8_switch_to_el1)
        switch_el x0, 0f, 1f, 0f
0:      ret
1:
        /* Initialize Generic Timers */
        mrs     x0, cnthctl_el2
        orr     x0, x0, #0x3            /* Enable EL1 access to timers */
        msr     cnthctl_el2, x0
        msr     cntvoff_el2, x0
        mrs     x0, cntkctl_el1
        orr     x0, x0, #0x3            /* Enable EL0 access to timers */
        msr     cntkctl_el1, x0

Sorry, if it's just all stupid.

Thanks,
Amit.
