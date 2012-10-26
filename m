From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 26 Oct 2012 16:05:32 +0200
Subject: [PATCH 2/2] ARM: mach-imx: CAN clock fix for i.MX53
In-Reply-To: <508A95B3.3010306@antcom.de>
References: <1351164400-27940-1-git-send-email-stigge@antcom.de>
 <1351164400-27940-2-git-send-email-stigge@antcom.de>
 <20121026085934.GA1641@pengutronix.de> <508A54E4.2060108@antcom.de>
 <508A665C.80107@pengutronix.de> <508A6E92.1000107@antcom.de>
 <508A95B3.3010306@antcom.de>
Message-ID: <508A98AC.1000000@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2012 03:52 PM, Roland Stigge wrote:
> On 10/26/2012 01:05 PM, Roland Stigge wrote:
>> On 10/26/2012 12:30 PM, Marc Kleine-Budde wrote:
>>>>>> +	clk[can1_serial_gate] = imx_clk_gate2("can1_serial_gate",
>>>>>> "can_sel", MXC_CCM_CCGR4, 6); +	clk[can1_ipg_gate] =
>>>>>> imx_clk_gate2("can1_ipg_gate", "ipg", MXC_CCM_CCGR4, 8); +
>>>>>> clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate",
>>>>>> "can_sel", MXC_CCM_CCGR4, 6); +	clk[can2_ipg_gate] =
>>>>>> imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 8);
>>>>>
>>>>> This doesn't.
>>>>
>>>> This may be right, but unfortunately, since the introduction of
>>>> your can1 + can2 clocking change, the first block stopped working
>>>> for me.
>>>
>>> You are effectively using can2's clock for can1. Are you sure you 
>>> haven't mixed up can1 and can2?
>>
>> Just using the above patch and patch 1/2 from this series (missing can
>> pinmuxing), doing like this in custom .dts:
>>
>> +                       can1: can at 53fc8000 {
>> +                               pinctrl-names = "default";
>> +                               pinctrl-0 = <&pinctrl_can1_1>;
>> +                               clock-frequency = <66500000>;
> 
> That was the problem, since in flexcan.c probe():
> 
> 
> 	if (pdev->dev.of_node)
> 		of_property_read_u32(pdev->dev.of_node,
> 						"clock-frequency", &clock_freq);
> 
> 	if (!clock_freq) {
> 		clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> 		if (IS_ERR(clk_ipg)) {
> 			dev_err(&pdev->dev, "no ipg clock defined\n");
> 			err = PTR_ERR(clk_ipg);
> 			goto failed_clock;
> 		}
> 		clock_freq = clk_get_rate(clk_ipg);
> 
> 		clk_per = devm_clk_get(&pdev->dev, "per");
> 		if (IS_ERR(clk_per)) {
> 			dev_err(&pdev->dev, "no per clock defined\n");
> 			err = PTR_ERR(clk_per);
> 			goto failed_clock;
> 		}
> 	}
> 
> Sorry for the noise.

We have the possibility to specify the clock frequency in the device
tree as the power pc has no support for generic clock yet.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121026/641db69d/attachment.sig>
