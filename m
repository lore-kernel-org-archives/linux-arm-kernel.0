From: stefan@agner.ch (Stefan Agner)
Date: Mon, 05 Jun 2017 22:16:07 -0700
Subject: [PATCH v3 0/2] ARM: dts: imx7: add NAND support
In-Reply-To: <1dd0abe0-81a3-d4ea-69c1-98fe354f91f4@nxp.com>
References: <20170601192044.6548-1-stefan@agner.ch>
 <3c086d95-96e5-71ec-b44f-12ed41903fcf@nxp.com>
 <e57ba49dc2b91b70b5848875e28b17ae@agner.ch>
 <1dd0abe0-81a3-d4ea-69c1-98fe354f91f4@nxp.com>
Message-ID: <09d82df6ce12a9f6df1f838df5eca9a6@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-02 13:09, Han Xu wrote:
> On 06/01/2017 08:48 PM, Stefan Agner wrote:
>> Hi Han,
>>
>> On 2017-06-01 14:14, Han Xu wrote:
>>> On 06/01/2017 02:20 PM, Stefan Agner wrote:
>>>> This are the missing device tree parts to add NAND support for i.MX 7.
>>>> See previous patchset:
>>>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2017%2F4%2F21%2F832&data=01%7C01%7Chan.xu%40nxp.com%7C3b9081a68c94476c4a2108d4a9235512%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=mQ2aq5rW%2B9uADY5mSzFxk8P6bAVq%2BosPJQAi0PL9SQg%3D&reserved=0
>>>>
>>>> The previous version also included driver changes, which are already
>>>> merged.
>>>>
>>>> --
>>>> Stefan
>>>>
>>>> Changes since v2:
>>>> - Only specify IMX7D_NAND_USDHC_BUS_ROOT_CLK which seems to be sufficent
>>> Hi Stefan, sorry I didn't reply your last patch. I was unable to fully
>>> test on i.MX7 since the work bandwidth, but the quick test shows DMA
>>> cannot work WITHOUT IMX7D_NAND_ROOT_CLK on my side, I will fully check
>>> it tomorrow morning and let you know the result.
>> How did you test that?
>>
>> Since DMA can only use NAND in i.MX 7, testing is somewhat hard.
>>
>> Fact is, I can access DMA registers using just NAND_USDHC_BUS_CLK_ROOT
>>
>> mw.l 0x30388980 0x11000000 # Enable NAND_USDHC_BUS_CLK_ROOT
>> mw.l 0x3038aa00 0x00000000 # Enable NAND_CLK_ROOT
> 
> NAND_ROOT_CLK offset is 0x4140 which control the CCGR20 to gate on/off 
> the rawnand module, including APBH/GPMI/BCH. Without enabling it, the 
> mxs-dma hangs during initialization. I guess this bit was enabled in 
> some early stage.

You are right, that clock gate was turned on, and it allowed access to
the APBH DMA.

However, while the gate was enabled, disabling the NAND_CLK_ROOT still
allowed to access APBH DMA, so the clock root itself is really not
required, but the gate is...

The clock which is required is NAND_USDHC_BUS_CLK_ROOT, but the gate is
part of NAND_CLK_ROOT. The clock tree is wrong: The gate is actually
shared, both clocks use the same gate.

In fact, assigning NAND_USDHC_BUS_CLK_ROOT directly to peripherals is
wrong since the gate is between the root clock and the peripherals (see
Figure 5-13 in RM). If we add the shared gate to NAND_USDHC_BUS_CLK_ROOT
directly, it will get enabled when using SDHC instances (since that root
clock is assigned to the sdhc instances, see
https://patchwork.kernel.org/patch/9674281/)

How about introducing NAND_USDHC_BUS_CLK_RAWNAND/NAND_CLK_RAWNAND which
has the shared gate in between?

--
Stefan

> 
>> md.l 0x33000100 0 # Access APBH_CH0_CURCMDAR
>>
>> This works for me.
>>
>> I can *boot* from a UBIFS using this driver and Linux 4.12-rc1 with my
>> patchset applied...
>>
>> Monitoring clocks in /sys/kernel/debug/clk/clk_summary show that
>> NAND_ROOT_CLK gets turned off and back on if NAND access happens, the
>> system seems stable.
>>
>> All that said, this patchset v3 actually does not remove the
>> NAND_ROOT_CLK as intended to. Will send a v4.
>>
>> --
>> Stefan
>>
>>>> - Dropped driver changes, alreay merged
>>>>
>>>> Changes since v1:
>>>> - Make clks_count const
>>>> - Introduce IS_IMX7D for i.MX 7 SoC's and make it part of GPMI_IS_MX6
>>>>
>>>> Stefan Agner (2):
>>>>     ARM: dts: imx7: add GPMI NAND
>>>>     ARM: dts: imx7-colibri: add NAND support
>>>>
>>>>    arch/arm/boot/dts/imx7-colibri.dtsi |  9 +++++++++
>>>>    arch/arm/boot/dts/imx7s.dtsi        | 31 +++++++++++++++++++++++++++++++
>>>>    2 files changed, 40 insertions(+)
>>>>
