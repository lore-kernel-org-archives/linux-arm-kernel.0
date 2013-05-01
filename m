From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 May 2013 18:09:09 +0900
Subject: [PATCH v3 4/5] ARM: shmobile: BOCK-W: add VIN and ML86V7667
 support
In-Reply-To: <517B06FA.3000303@cogentembedded.com>
References: <201304232118.43686.sergei.shtylyov@cogentembedded.com>
 <201304232132.52741.sergei.shtylyov@cogentembedded.com>
 <517B06FA.3000303@cogentembedded.com>
Message-ID: <20130501090909.GA2562@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 27, 2013 at 03:00:10AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/23/2013 09:32 PM, Sergei Shtylyov wrote:
> 
> >From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >
> >Add ML86V7667 platform devices on BOCK-W board, configure VIN0/1 pins, and
> >register VIN0/1 devices with the ML86V7667 specific platform data.
> >
> >Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >[Sergei: some macro/comment cleanup; updated the copyrights, removed duplicate
> >#include, annotated all platform data as '__initdata'.]
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> >---
> >Changes since version 2:
> >- removed duplicate #include <linux/pinctrl/machine.h>;
> >- annotated all platform data as '__initdata' since they're kmemdup()'ed while
> >   registering the platform devices anyway;
> >- resolved rejects, refreshed the patch.
> >
> >  arch/arm/mach-shmobile/board-bockw.c |   39 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> >Index: renesas/arch/arm/mach-shmobile/board-bockw.c
> >===================================================================
> >--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
> >+++ renesas/arch/arm/mach-shmobile/board-bockw.c
> 
> [...]
> 
> >@@ -80,6 +101,16 @@ static const struct pinctrl_map bockw_pi
> >  				  "sdhi0_data4", "sdhi0"),
> >  	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
> >  				  "sdhi0_wp", "sdhi0"),
> >+	/* VIN0 */
> >+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_vin.0", "pfc-r8a7778",
> >+				  "vin0_clk", "vin0"),
> >+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_vin.0", "pfc-r8a7778",
> >+				  "vin0_data8", "vin0"),
> >+	/* VIN1 */
> >+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_vin.1", "pfc-r8a7778",
> >+				  "vin1_clk", "vin1"),
> >+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_vin.1", "pfc-r8a7778",
> >+				  "vin1_data8", "vin1"),
> >  };
> 
>     It turned out that VIN1 signal VI1_CLK conflicts with Ether
> signal ETH_REF_CLK.
> So I'm a bit at a loss here: whether I should totally remove VIN1
> device if I'm going
> to add Ether device, or add a BOCK-W specific submenu to Kconfig, or
> add driver
> specific #ifdef's in the code to disable VIN1 if sh_eth driver is
> enabled?...

My preference, in order is:

* Remove VIN1 (is it used?)
* Kconfig-foo
* #ifdef nastiness
