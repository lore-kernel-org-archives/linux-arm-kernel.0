From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 15 Sep 2012 05:32:59 +0000 (UTC)
Subject: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
In-Reply-To: <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1209150527080.3370@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2012, Paul Walmsley wrote:

> The kernel built with omap2plus_defconfig was then booted on several 
> OMAP2+ boards.  Here's what was found:

[ ... ]

> - The 2420 N800 seems to have some kind of MMC-related problem
>   that prevents it from booting.  Still looking into this:
> 
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/2420n800/2420n800_log.txt

This has been resolved.  The APLL clocks have been missing rate 
recalculation functions for a long time.  This wasn't a problem in the 
past because these were considered fixed rate clocks (at the locked 
frequency).  But in the CCF conversion, the fixed rate was dropped.  This 
caused the MMC functional clock to be set incorrectly to the sys_clk rate.  
This in turn caused the MMC driver's timing calculation code to return the 
wrong value, preventing meaningful MMC/SD access.

The problem was resolved by creating recalc_rate function pointers for the 
APLLs that return sys_ck if the APLL is bypassed, or the APLL rate if it's 
locked, for both 2420 and 2430.


- Paul
