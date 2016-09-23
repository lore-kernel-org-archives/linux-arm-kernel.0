From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 23 Sep 2016 15:24:12 +0100
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <VI1PR0401MB26384246128D6043B93E6E9F8DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <f4195baa-907d-2c00-eb62-d4452ed749c8@arm.com>
 <VI1PR0401MB2638049F479731B3CC903B248DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <c6697a9c-013b-9880-e52f-8de2f0a5b7ae@arm.com>
 <VI1PR0401MB26384246128D6043B93E6E9F8DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Message-ID: <15d69a29-6997-6af8-f121-ff253388626c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/16 15:01, Stuart Yoder wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy at arm.com]
>> Sent: Friday, September 23, 2016 8:19 AM
>> To: Stuart Yoder <stuart.yoder@nxp.com>; Alison Wang <b18965@freescale.com>; shawnguo at kernel.org;
>> kernel at pengutronix.de; Fabio Estevam Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk; linux-arm-
>> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Scott Wood <scott.wood@nxp.com>; Leo Li
>> <leoyang.li@nxp.com>
>> Cc: Jason Jin <jason.jin@nxp.com>
>> Subject: Re: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape platforms
>>
>> On 23/09/16 14:13, Stuart Yoder wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Robin Murphy [mailto:robin.murphy at arm.com]
>>>> Sent: Friday, September 23, 2016 7:17 AM
>>>> To: Alison Wang <b18965@freescale.com>; shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
>>>> Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk; linux-arm-kernel at lists.infradead.org; linux-
>>>> kernel at vger.kernel.org; Scott Wood <scott.wood@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Leo Li
>>>> <leoyang.li@nxp.com>
>>>> Cc: Jason Jin <jason.jin@nxp.com>
>>>> Subject: Re: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape platforms
>>>>
>>>> Hi Alison,
>>>>
>>>> On 23/09/16 03:19, Alison Wang wrote:
>>>>> The ARMv8 architecture supports:
>>>>> 1. 64-bit execution state, AArch64.
>>>>> 2. 32-bit execution state, AArch32, that is compatible with previous
>>>>> versions of the ARM architecture.
>>>>>
>>>>> LayerScape platforms are compliant with ARMv8 architecture. This patch
>>>>> is to support running 32-bit Linux kernel for LayerScape platforms.
>>>>>
>>>>> Verified on LayerScape LS1043ARDB, LS1012ARDB, LS1046ARDB boards.
>>>>>
>>>>> Signed-off-by: Ebony Zhu <ebony.zhu@nxp.com>
>>>>> Signed-off-by: Alison Wang <alison.wang@nxp.com>
>>>>> ---
>>>>>  arch/arm/Kconfig                    |  9 +++++++++
>>>>>  arch/arm/mach-imx/Kconfig           | 14 ++++++++++++++
>>>>>  arch/arm/mach-imx/Makefile          |  4 +++-
>>>>>  arch/arm/mach-imx/mach-layerscape.c | 23 +++++++++++++++++++++++
>>>>>  4 files changed, 49 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 arch/arm/mach-imx/mach-layerscape.c
>>>>>
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index f0c8068..e8d470e 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -294,6 +294,15 @@ config PGTABLE_LEVELS
>>>>>  	default 3 if ARM_LPAE
>>>>>  	default 2
>>>>>
>>>>> +config ARCH_AARCH32_ES_SUPPORT
>>>>> +	def_bool n
>>>>> +	help
>>>>> +	 The ARMv8 architecture supports 64-bit execution state, AArch64
>>>>> +	 and 32-bit execution state, AArch32, that is compatible with
>>>>> +	 previous versions of the ARM architecture.
>>>>> +
>>>>> +	 Enable AArch32 execution state support for ARMv8 architecture.
>>>>
>>>> What's this supposed to do, exactly? I've been running 32-bit kernels on
>>>> my Juno with very little issue (beyond a couple of DT tweaks, and some
>>>> firmware hacks with a corresponding bit of A64 assembly tacked on the
>>>> front of the zImage to switch into AArch32 state).
>>>
>>> Which arch/arm/mach-* platform are you using for Juno?
>>
>> I don't even know! :) I just start with a multi_v7_defconfig plus a few
>> extra bits (LPAE, KVM, sil24, sky2, etc.) and it works. I guess it's the
>> combination of mach-vexpress and mach-virt.
> 
> Thanks.  A question about the switch into aarch32 state... our assumption
> was that the kernel starts at EL2.  In this proof of concept we're doing the
> switch to aarch32/EL2 in firmware.  And what I'm being told is that the
> firmware aarch64 EL2 code cannot switch to aarch32 EL2 without some 
> assistance from EL3 firmware.  This is leading us to invent a new
> SMC call to do this.
> 
> Did you face this?

Yes, the only way to enter in Hyp is to have the firmware twiddle
SCR_EL3.RW (I simply stuck a disgusting hack directly in ATF's exception
handler, which my dodgy 64-bit header then calls). Otherwise you can
always simply run your own shim at EL2 to drive an AArch32 EL1 (it'll
need to trap and translate subsequent SMC calls for e.g. PSCI).

> If there is such a requirement, it's something begging for standardization.
> Doesn't make sense for multiple divergent approaches for switching from
> aarch64/EL2 to aarch32/EL2.

Perhaps - I did briefly look into how hard it would be to write a proper
SMC service handler to do this (since ATF does have a framework for such
things), but concluded it would be more than 10 minutes' work and just
cheated instead. It's certainly something which could be raised with the
firmware folks.

Robin.

> 
> Thanks,
> Stuart
> 
