From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 07 Dec 2013 10:34:17 -0300
Subject: [linux-sunxi] Re: [PATCH 04/10] net: stmmac: sunxi platfrom
 extensions for GMAC in Allwinner A20 SoC's
In-Reply-To: <1455361.VIrFSPex2v@flatron>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <2030454.PFLhh6xOPI@flatron> <20131207114616.GM24519@lukather>
 <1455361.VIrFSPex2v@flatron>
Message-ID: <52A323D9.5080806@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 07/12/13 09:50, Tomasz Figa escribi?:
> On Saturday 07 of December 2013 12:46:16 Maxime Ripard wrote:
>> On Sat, Dec 07, 2013 at 12:12:26PM +0100, Tomasz Figa wrote:
>>> On Saturday 07 of December 2013 11:27:10 Maxime Ripard wrote:
>>>> Chen-Yu, Mike,
>>>>
>>>> On Sat, Dec 07, 2013 at 01:29:37AM +0800, Chen-Yu Tsai wrote:
>>>>> The Allwinner A20 has an ethernet controller that seems to be
>>>>> an early version of Synopsys DesignWare MAC 10/100/1000 Universal,
>>>>> which is supported by the stmmac driver.
>>>>>
>>>>> Allwinner's GMAC requires setting additional registers in the SoC's
>>>>> clock control unit.
>>>>>
>>>>> The exact version of the DWMAC IP that Allwinner uses is unknown,
>>>>> thus the exact feature set is unknown.
>>>>>
>>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>>> ---
>>>>>   .../bindings/net/allwinner,sun7i-gmac.txt          | 22 +++++++
>>>>>   drivers/net/ethernet/stmicro/stmmac/Kconfig        | 12 ++++
>>>>>   drivers/net/ethernet/stmicro/stmmac/Makefile       |  1 +
>>>>>   drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  | 76 ++++++++++++++++++++++
>>>>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  3 +
>>>>>   .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  3 +
>>>>>   6 files changed, 117 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun7i-gmac.txt b/Documentation/devicetree/bindings/net/allwinner,sun7i-gmac.txt
>>>>> new file mode 100644
>>>>> index 0000000..271554a
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/net/allwinner,sun7i-gmac.txt
>>>>> @@ -0,0 +1,22 @@
>>>>> +* Allwinner GMAC ethernet controller
>>>>> +
>>>>> +This device is a platform glue layer for stmmac.
>>>>> +Please see stmmac.txt for the other unchanged properties.
>>>>> +
>>>>> +Required properties:
>>>>> + - compatible:  Should be "allwinner,sun7i-gmac"
>>>>
>>>> Please use sun7i-a20-gmac here.
>>>>
>>>>> + - reg: Address and length of register set for the device and corresponding
>>>>> +   clock control
>>>>>
>>>>> +Examples:
>>>>> +
>>>>> +	gmac: ethernet at 01c50000 {
>>>>> +		compatible = "allwinner,sun7i-gmac";
>>>>> +		reg = <0x01c50000 0x10000>,
>>>>> +		      <0x01c20164 0x4>;
>>>>
>>>> This is actually a clock, and should probably be registered in the
>>>> common clock framework.
>>>>
>>>> Mike: This small register actually is a regular muxer/divider, except
>>>> that it has some bits that are of interest to the ethernet controller
>>>> (for example to set wether it's using GMII or RGMII to communicate
>>>> with the phy), that, as far as I'm aware of, aren't really fitting
>>>> into the CCF.
>>>>
>>>> Do you have some recommendation on how to proceed?
>>>>
>>>> Maybe make a thin "real" clock driver in this hardware glue, that
>>>> provides !exported function to set this *GMII thing.
>>>
>>> Is this register part of a bigger IP block that manages clocks for other
>>> IP blocks than stmmac as well? If not, I don't see a point of exporting
>>> a clock from inside of the GMAC "domain" just to feed it back into it
>>> as the only user.
>>
>> This register is actually part of the SoC clock controller. So it sits
>> right beside the other clocks registers controlling the clocks of the
>> other devices, and is not part of the GMAC IP itself.
>
> Is there any description for GMAC_IF_TYPE_RGMII and GMAC_TX_CLK fields?
>
> Name of the latter sounds like a normal clock mux, but the former is
> just a mystery (especially why it is a part of the clock controller).

You can find the register documented on page 89, table 1.5.4.65 of

http://dl.linux-sunxi.org/A20/A20%20User%20Manual%202013-03-22.pdf
