From: rogerq@ti.com (Roger Quadros)
Date: Mon, 3 Nov 2014 11:30:27 +0200
Subject: [PATCH 01/10] ARM: dts: Fix bootloader version dependencies by
 muxing n900 smc91x pins
In-Reply-To: <20141030154952.GF2560@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-2-git-send-email-tony@atomide.com>
 <54522829.6060406@ti.com> <20141030154952.GF2560@atomide.com>
Message-ID: <54574B33.9050303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 05:49 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141030 05:01]:
>> On 10/30/2014 02:28 AM, Tony Lindgren wrote:
>>> +
>>> +			/*
>>> +			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
>>> +			 * according to TRM. REVISIT: why does nolo set input for gpmc_clk?
>>> +			 */
>>> +                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
>>> +                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
>>
>> Right about the comment. GPMC_CLK should feed the CLK input of the OneNAND.
>> This needs to be an OUTPUT pin.
>>
>> Does OneNAND work when this pin is configured as output?
> 
> Does not seem to work, it produces onenand_wait: ECC error = 0xffff.
> 
> It seems the clock needs to be copied to GPMC too in some cases.
> For MMC, there's the MMCSDIO2ADPCLKISEL option to copy the clock to
> account for level shifter latencies [1]. But in the OneNAND case I
> don't think there are any level shifters, and I don't think we have
> "copy clock" option for GPMC either in SCM so it somehow is automatic
> in GPMC.
> 
> Anyways, updated patch below with wrong guessing removed.
> 
> Regards,
> 
> Tony
> 
> [1] http://processors.wiki.ti.com/index.php/SD-MMC_Usage_Notes_on_OMAP35x_and_AM37x
> 
> 
> 8< --------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 29 Oct 2014 17:16:47 -0700
> Subject: [PATCH] ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins
> 
> Apparently some versions of nolo don't mux the all the necessary GPMC
> pins for the smc91x probe to work properly. Let's fix this issue
> by adding mux support for GPMC to the kernel.
> 
> Note that GPMC clk needs input enabled for OnenNAND to work.
> 
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
