From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 9 Feb 2015 18:54:37 +0530
Subject: [PATCH] ARM: dra7xx: hwmod: drop .modulemode from pcie1/2 hwmods
In-Reply-To: <54D88BB3.4060104@linaro.org>
References: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org>
 <54D874E9.1040302@ti.com> <54D88BB3.4060104@linaro.org>
Message-ID: <54D8B515.201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 09 February 2015 03:58 PM, Grygorii.Strashko at linaro.org wrote:
> Hi Kishon,
> On 02/09/2015 04:50 PM, Kishon Vijay Abraham I wrote:
>> On Tuesday 03 February 2015 09:21 PM, grygorii.strashko at linaro.org wrote:
>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>
>>> Now DRA7xx pcie1/2 hwmods define PRCM configuration as following:
>>>    .clkctrl_offs = DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
>>>    .rstctrl_offs = DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
>>>    .modulemode   = MODULEMODE_SWCTRL,
>>> which is completely wrong because DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET
>>> is clockdomain ctrl register and NOT module ctrl register.
>>> And they have diffrent allowed values for bits[0,1]:
>>> CLKTRCTRL?????????MODULEMODE??????????????????????????????????
>>> 0x0:?NO_SLEEP?????0x0:?Module?is?disabled?by?SW.??????????????
>>> 0x1:?SW_SLEEP?????0x1:?Module?is?managed?automatically?by?HW??
>>> 0x2:?SW_WKUP??????0x2:?Module?is?explicitly?enabled.??????????
>>> 0x3:?HW_AUTO??????0x3:?Reserved??
>>>
>>> As result, following message can be seen during suspend:
>>>    "omap_hwmod: pcie1: _wait_target_disable failed"
>>>
>>> Fix it by removing .modulemode from pcie1/2 hwmods and, in that
>>> way, prevent clockdomain ctrl register writing from HWMOD core.
>>
>> Looks correct except for one change.
>>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>> ---
>>>
>>> More over, it looks like pcie1/2 hwmods are fake and have to be dropped at all.
>>> The real HWMODs are PCIESS1/2.
>>
>> Not sure I get this. You mean "dra7xx_pcie1_hwmod" should be replaced with
>> "dra7xx_pciess1_hwmod"? Or you mean an entire new hwmod is missing?
>>
>> Please note we still have to enable the clock domain and main clock. We've also
>> purposefully omitted sysconfig from hwmod data since pcie reset
>> (RM_PCIESS_RSTCTRL) should be done before accessing the syconfig register and
>> the infrastructure for that is currently not present.
> 
> What I'm trying to say is that now PM control data mixed between "pcieX" and "pcieX-phy" hwmods.
> After this patch "pcieX" hwmods will actually do nothing (I assume that "pciex-phy" will be 
> enabled before "pcieX"), and probably can be removed if "pcie_clkdm" could be attached to "pcieX-phy" hwmod
> instead.
> 
> More over, now, "pcie_clkdm" is connected to "pcieX" hwmod while MODULEMODE register is controlled
> by "pciex-phy" hwmod, so when pciess is going to be enabled the "l3init_clkdm" will be waken-up by
> hwmode core and not "pcie_clkdm" - as I can remember this is not good (we should alway wake-up clockdomain
>  and keep it in SWSUP mode while changing MODULEMODE and SYSC registers).
> 
> static struct omap_hwmod dra7xx_pcie1_hwmod = {
> 	.name		= "pcie1",
> 	.class		= &dra7xx_pcie_hwmod_class,
> 	.clkdm_name	= "pcie_clkdm",
> 	.main_clk	= "l4_root_clk_div",
> 
> static struct omap_hwmod dra7xx_pcie1_phy_hwmod = {
> 	.name		= "pcie1-phy",
> 	.class		= &dra7xx_pcie_phy_hwmod_class,
> 	.clkdm_name	= "l3init_clkdm",
> 	.main_clk	= "l4_root_clk_div",
> 
> So, in my opinion, some rework may be needed here. 
> Am I right?

you are right. We should have a single hwmod like dra7xx_pciess1_hwmod whose
clkdm should be "pcie_clkdm" and whose clkctrl_offs should be
DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET (for controlling MODULEMODE). PCIE PHY
shouldn't have a hwmod entry at all.

Thanks
Kishon
