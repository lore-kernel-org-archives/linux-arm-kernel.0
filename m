From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 May 2011 09:47:33 +0100
Subject: [PATCH] ARM: fix mistaken dependency for CPU_HAS_PMU
In-Reply-To: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>
References: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <000001cc1538$3ae8a9e0$b0b9fda0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Ming Lei <tom.leiming@gmail.com>
> 
> Obviously it is mistake for CPU_HAS_PMU to depend on
> (!ARCH_OMAP3 || OMAP3_EMU).

It's not that obvious!
 
> No mattery it is omap3 or not, we can build pmu.o into
> kernel safely. In fact, arm-v7 of omap3 has pmu inside
> also.

Yes, but the PMU on Omap3 doesn't work unless you enable the emu clk, which
is done in kernel/etm.c. Rather than duplicate that code (which only seems
to be needed for Omap anyway) I decided to add a dependency on OMAP3_EMU so
the clock gets enabled in etb_probe.

> So fix it that we can build pmu into kernel to support perf
> for some valid config(such as enable both omap4 and omap3,
> but OMAP3_EMU).

No, I don't like this. The reason I don't like it is because it will lead to
lots of bug reports that perf doesn't work on Omap3 because they haven't got
the emu clock ticking. It was this scenario that led to the dependency being
introduced in the first place:

8954bb0d ("OMAP3: pmu: make CPU_HAS_PMU dependent on OMAP3_EMU")

Is there a problem building the etm support for Omap4?

Will
