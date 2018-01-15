From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Mon, 15 Jan 2018 02:19:39 +0000
Subject: [PATCH v3] PCI: imx6: Add PHY reference clock source support
In-Reply-To: <498e20c0-7b86-0f86-7555-64a012b85b9e@compulab.co.il>
References: <CAOMZO5AFC9dxhsQjmRrDA7Z3KMkEemryKOBmQhXm19NXKxHkKQ@mail.gmail.com>
 <1515073977-10153-1-git-send-email-ilya@compulab.co.il>
 <1515408232.12538.7.camel@pengutronix.de>
 <498e20c0-7b86-0f86-7555-64a012b85b9e@compulab.co.il>
Message-ID: <AM5PR0402MB2850EE5537495B0960501D178CEB0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Ilya Ledvich [mailto:ilya at compulab.co.il] 
Sent: 2018?1?10? 21:44
To: Lucas Stach <l.stach@pengutronix.de>; Richard Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; Rob Herring <robh+dt@kernel.org>; linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Add PHY reference clock source support

Hi Lucas,

On 01/08/2018 12:43 PM, Lucas Stach wrote:
> Am Donnerstag, den 04.01.2018, 15:52 +0200 schrieb Ilya Ledvich:
>> i.MX7D variant of the IP can use either Crystal Oscillator input or 
>> internal clock input as a Reference Clock input for PCIe PHY.
>> Add support for an optional property 'fsl,pcie-phy-refclk-internal'.
>> If present then an internal clock input is used as PCIe PHY reference 
>> clock source. By default an external oscillator input is still used.
>>
>> Verified on Compulab SBC-iMX7 Single Board Computer.
> 
> Sorry to get in late here, but I would rather have the external clock 
> input modeled as a real clock and only use the internal clock if that 
> isn't present.
> 

I tried to follow the logic described in the iMX7 TRM, where external oscillator is a default option. Additionally, the external clock input model you've suggested, requires additional changes in the iMX7 SabreSD board (and probably other boards which use an external input too) devicetree files.
[Richard] Maybe Lucas want to have the internal PLL clock mode as the iMX PCIE default reference clock. And mark the external OSC clock input mode explicitly, and documented in the DT binding document.

> Are you even sure that the i.MX7 clock you mention isn't the already 
> documented "pcie_bus" clock? This one is also allowed to be sourced 
> externally on the i.MX6.

To the best of my understanding it's not the pcie_bus clock, but I'm absolutely sure. Could anybody from the BSP team guys elaborate on this issue? Thanks a lot!
Best regards,
[Richard] iMX PCIE is integrated on the AXI bus in the SOC internally.
The "pcie_bus? clock marked as the clock provided by the RC, and used by the EP in the iMX6 platforms.
On iMX6 platforms, the internal PLL is output from LVDS1 N/P pad, and used by EP in the HW reference designs.
                        clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
                                 <&clks IMX6QDL_CLK_LVDS1_GATE>,
                                 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
                        clock-names = "pcie", "pcie_bus", "pcie_phy";

Ilya.

>> ---
>> changes since V2:
>> 	add a vendor prefix 'fsl' to a new property
>>
>>  ?Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
>>  ?drivers/pci/dwc/pci-imx6.c???????????????????????????????| 8
>> +++++++-
>>  ?2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> index 7b1e48b..1591a6a 100644
>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> @@ -50,6 +50,11 @@ Additional required properties for imx7d-pcie:
>>  ?	???????- "pciephy"
>>  ?	???????- "apps"
>>   
>> +Additional optional properties for imx7d-pcie:
>> +- fsl,pcie-phy-refclk-internal: If present then an internal PLL
>> input is used
>> +??as PCIe PHY reference clock source. By default an external
>> oscillator input
>> +??is used.
>> +
>>  ?Example:
>>   
>>  ?	pcie at 0x01000000 {
>> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c 
>> index b734835..36812d3 100644
>> --- a/drivers/pci/dwc/pci-imx6.c
>> +++ b/drivers/pci/dwc/pci-imx6.c
>> @@ -61,6 +61,7 @@ struct imx6_pcie {
>>  ?	u32			tx_swing_low;
>>  ?	int			link_gen;
>>  ?	struct regulator	*vpcie;
>> +	bool			pciephy_refclk_sel;
>>  ?};
>>   
>>  ?/* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */ 
>> @@ -474,7 +475,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie
>> *imx6_pcie)
>>  ?	switch (imx6_pcie->variant) {
>>  ?	case IMX7D:
>>  ?		regmap_update_bits(imx6_pcie->iomuxc_gpr,
>> IOMUXC_GPR12,
>> -				???IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>> 0);
>> +				???IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>> +				???imx6_pcie->pciephy_refclk_sel ?
>> +				???IMX7D_GPR12_PCIE_PHY_REFCLK_SEL :
>> 0);
>>  ?		break;
>>  ?	case IMX6SX:
>>  ?		regmap_update_bits(imx6_pcie->iomuxc_gpr,
>> IOMUXC_GPR12,
>> @@ -840,6 +843,9 @@ static int imx6_pcie_probe(struct platform_device
>> *pdev)
>>  ?		imx6_pcie->vpcie = NULL;
>>  ?	}
>>   
>> +	imx6_pcie->pciephy_refclk_sel =
>> +		of_property_read_bool(node, "fsl,pcie-phy-refclk-
>> internal");
>> +
>>  ?	platform_set_drvdata(pdev, imx6_pcie);
>>   
>>  ?	ret = imx6_add_pcie_port(imx6_pcie, pdev);
