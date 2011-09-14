From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Thu, 15 Sep 2011 00:22:15 +0300
Subject: [PATCH] ARM: EXYNOS4: Enable double linefill in PL310 Prefetch
	Control Register
In-Reply-To: <007501cc72d0$b0778a50$11669ef0$%kim@samsung.com>
References: <1315894031-9579-1-git-send-email-siarhei.siamashka@gmail.com>
	<CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
	<CACY+gR2TX35XaVLiN7s_PkY4r=G1i3LMhHzSJJiaAOSoYDGwfg@mail.gmail.com>
	<CAH9JG2Ww9J8h34Nub=gz=xR5767T7X=S+gk58o4HU809mdB52Q@mail.gmail.com>
	<CACY+gR2oRqEA80Ura9Wp5cDW7b-Cjo+KVnfuA-PBHbFZKfRpwQ@mail.gmail.com>
	<007501cc72d0$b0778a50$11669ef0$%kim@samsung.com>
Message-ID: <CACY+gR3E2meqSMnEsMDqQAYdGJwortAA+OB7fmY9709RhpZSQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 2:23 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Siarhei Siamashka wrote:
>> By the way, does anybody have L2C-310 errata list? Is double linefill
>> actually safe to use in r3p0?
>>
> No. it is _not_ safe on EXYNOS4210.
>
> Since L2C-310 ERRTA, current EXYNOS4210 cannot enable double linefill feature

Thanks for this information. It's a pity, because double linefill
could provide a really serious memory performance boost. Looks like we
have to wait for EXYNOS4212 and/or OMAP4460 to really see how
Cortex-A9 is actually supposed to perform on memory intensive tasks.

However I really appreciate that with EXYNOS4210 you are not shoving
some hardcoded configuration down our throats and not restricting
access to the relevant Cortex-A9 and L2C-310 configuration registers.
So it is still possible to temporarily enable double linefill and use
origenboard for benchmarking purposes to estimate how EXYNOS4212 is
going to perform when it becomes available.

> and as Siarhei said, need to check its version of L2C-310 in Cache ID register before enabling it.

If EXYNOS4212 has a bugfree double linefill support, then enabling it
based on checking L2C-310 revision looks like a good idea.

> As a note, it's possible to enable it on EXYNOS4212 SoC and in opposite of Siarhei's patch, enabling WRAP read is better on it. Actually my colleague, Boojin Kim is testing it so that can submit it soon.

If you have some benchmark results with all these options, they would
be very interesting for me.

As for the general memory performance tuning, there are more things to
try (carefully watching for possible errata):
- SCU Speculative linefills enable bit in SCU Control Register as
described in http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407f/BABEBFBH.html
(this seems to be a good tweak and it really reduces L2 access latency
a bit in my tests)
- Exclusive cache configuration (should increase effective L1/L2 cache
size, but seems to make L2 cache access latency worse in my tests)
- Tune L2C-310 Prefetch offset (without double linefill, the value 6
or even 5 seems to be a bit better than 7)
- 'Alloc in one way', 'Write full line of zeros mode' and maybe something else

Thank you for your replies and the interest in this subject.

-- 
Best regards,
Siarhei Siamashka
