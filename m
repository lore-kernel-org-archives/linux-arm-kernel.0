From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Apr 2012 00:35:57 +0530
Subject: [PATCH v2] arm: da850: change ASYNC/PLL0_SYSCLK3 clock rate with
 DVFS
In-Reply-To: <1333617232-27967-1-git-send-email-prakash.pm@ti.com>
References: <1333617232-27967-1-git-send-email-prakash.pm@ti.com>
Message-ID: <4F833315.1050109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prakash,

On 4/5/2012 2:43 PM, Manjunathappa, Prakash wrote:
> Clock for EMIF is derived from ASYNC clock domain(PLL0_SYSCLK3) and was
> configured with fixed divider as there was no significant performance
> degradation with existing NAND/NOR EMIF devices if it is not
> reconfigured accordingly at different OPPs.

This is not correct AFAICT. The divider is not fixed in current code.
There is an attempt to adjust the async1 (PLL0 SYSCLK3 rate) and keep it
constant at 100MHz by adjusting the divider at each OPP transition (see
the call to clock_set_rate() on async clock in cpufreq.c). This was
based on an earlier understanding that PLL0_SYSCLK3 can support 100MHz
at all OPPs and all AEMIF modes. Looking at the datasheet now, it is
clear that that assumption is not true.

> 
> On systems where devices other than NAND/NOR are interfaced through
> EMIF, such performance degradation may not be desirable. So change the
> PLL0_SYSCLK3 output frequency for different OPPs by re-configuring
> the divider value.

This again is not the point. The issue is that depending on what mode
you have AEMIF running in *and* depending on what OPP you are at, a
particular value of ASYNC1 clock is required to get maximum performance
out of AEMIF.

> 
> Also add Kconfig option to support platforms requiring fixed EMIF clock
> rate.

This breaks single image support for all DA850 boards. Kconfig in this
case is not an option.

Why not make the OPP table board specific while maintain a sane (and
safe) default in SoC file so there is something to fall back upon in
case a board does not need to define its own? This should also address
Christian's concern in the other e-mail thread about board specific OPP
values being hardcoded in SoC file with no way to override them.

Thanks,
Sekhar
