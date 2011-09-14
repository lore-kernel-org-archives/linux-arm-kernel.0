From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Sep 2011 20:23:12 +0900
Subject: [PATCH] ARM: EXYNOS4: Enable double linefill in PL310 Prefetch
	Control Register
In-Reply-To: <CACY+gR2oRqEA80Ura9Wp5cDW7b-Cjo+KVnfuA-PBHbFZKfRpwQ@mail.gmail.com>
References: <1315894031-9579-1-git-send-email-siarhei.siamashka@gmail.com>
	<CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
	<CACY+gR2TX35XaVLiN7s_PkY4r=G1i3LMhHzSJJiaAOSoYDGwfg@mail.gmail.com>
	<CAH9JG2Ww9J8h34Nub=gz=xR5767T7X=S+gk58o4HU809mdB52Q@mail.gmail.com>
	<CACY+gR2oRqEA80Ura9Wp5cDW7b-Cjo+KVnfuA-PBHbFZKfRpwQ@mail.gmail.com>
Message-ID: <007501cc72d0$b0778a50$11669ef0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Siarhei Siamashka wrote:
> 
> On Wed, Sep 14, 2011 at 10:57 AM, Kyungmin Park <kmpark@infradead.org>
> wrote:
> > On Wed, Sep 14, 2011 at 4:43 PM, Siarhei Siamashka
> > <siarhei.siamashka@gmail.com> wrote:
> >> On Wed, Sep 14, 2011 at 9:08 AM, Kyungmin Park <kmpark@infradead.org>
> wrote:
> >>> Hi Siarhei,
> >>>
> >>> Interesting feature, and it's not samsung soc issue, so add the arm
> >>> mailing list.
> >>> It checked and the see the read performance improvement from 868MiB/s
> >>> to 981MiB/s with lmbench.
> >>
> >> Maybe lmbench does not try very hard to get the best out of the
> >> hardware? On my origenboard, I'm getting ~1.15GB/s performance for the
> >> standard LDM/STM based memcpy from libc-ports, which is ~2.3GB/s
> >> memory bandwidth if both reads and writes are accounted separately.
> >>
> >>> It's helpful to test other SoC., e.g., OMAP4, STE and so on.
> >>
> >> The current (?) state of the support for this feature in OMAP4 is
> >> explained here by Richard Woodruff:
> >>    http://groups.google.com/group/pandaboard/msg/dfd2d2e1336d435b
> >>
> >>> BTW, why do you set the 27-bit? In my PL310 Spec., it's reserved bit
> >>> and should be zero (SBZ).
> >>
> >> This PL310 thing seems to have been renamed to "CoreLink Level 2 Cache
> >> Controller L2C-310" in later revisions, and its Prefetch Control
> >> Register is described here:
> >>    http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246f/CHDHIECI.html
> > Thanks for link. it has 27-bit description. but does it correct bit
> > description for exynos4 PL310?
> > I mean I received the PL310 TRM with exynos4 chip used. there's no
> > 27-bit description. it's just reserved bit.
> > Can it enable the 27-bit at exynos4210? or can be used for exynos4212 or later?
> 
> That's a good point. I think it is exynos4210 that is used in
> origenboard. And according to the value in Cache ID Register
> (0x4100c4c5), it has r3p0 revision of L2C-310. Which means that the
> Prefetch Control Register is actually described at:
>     http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246d/CHDHIECI.html
> And bit 27 is indeed reserved. However flipping it seems to have some
> measurable impact on performance (unless I screwed up the benchmarks),
> so maybe it does something but is undocumented? In any case, I agree
> that it's better not to mess up with this bit.
> 
Hi all,

Please adding me in Cc for Samsung stuff...

> By the way, does anybody have L2C-310 errata list? Is double linefill
> actually safe to use in r3p0?
> 
No. it is _not_ safe on EXYNOS4210.

Since L2C-310 ERRTA, current EXYNOS4210 cannot enable double linefill feature and as Siarhei said, need to check its version of L2C-310 in Cache ID register before enabling it. As a note, it's possible to enable it on EXYNOS4212 SoC and in opposite of Siarhei's patch, enabling WRAP read is better on it. Actually my colleague, Boojin Kim is testing it so that can submit it soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
