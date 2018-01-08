From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Jan 2018 09:24:35 -0800
Subject: [PATCH 0/3] ARM branch predictor hardening
In-Reply-To: <0d7ac442-1112-33e9-1f1f-cd600c3e326d@arm.com>
References: <20180106120907.26701-1-marc.zyngier@arm.com>
 <20180108165425.GR3875@atomide.com>
 <0d7ac442-1112-33e9-1f1f-cd600c3e326d@arm.com>
Message-ID: <20180108172435.GS3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [180108 17:05]:
> Hi Tony,
> 
> On 08/01/18 16:54, Tony Lindgren wrote:
> > * Marc Zyngier <marc.zyngier@arm.com> [180106 04:14]:
> >> This small series implements some basic BP hardening by invalidating
> >> the BTB on CPUs that are known to be susceptible to aliasing attacks.
> >>
> >> These patches are closely modelled against what we do on arm64,
> >> although simpler as we can rely on an architected instruction to
> >> perform the invalidation.
> >>
> >> The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
> >> generalises it to be used on all affected CPUs. The second perform the
> >> same invalidation on fatal signal delivery. The last one nukes it on
> >> guest exit, and results in some major surgery (kudos to Dimitris
> >> Papastamos who came up with the magic vector decoding sequence).
> > 
> > So if a Cortex-A8 has bootloder set the IBE bit, and kernel has
> > ARM_ERRATA_430973 enabled, is Cortex-A8 already hardened then?
> 
> Almost. See the extra BTB invalidation in fault.c.

OK thanks. So for Cortex-A8, only patch "[PATCH 2/3] arm: Invalidate
BTB on fatal signal for Cortex A8, A9, A12, A15 and A17" is needed
if I read that right.

Regards,

Tony
