From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 30 Oct 2014 15:02:41 +0100
Subject: [RFT v3 06/14] regulator: max77802: Remove support for board files
In-Reply-To: <1414673587.23399.13.camel@AMDC1943>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-7-git-send-email-k.kozlowski@samsung.com>
 <54522615.7040002@collabora.co.uk> <1414671037.23399.2.camel@AMDC1943>
 <54522D2C.9050002@collabora.co.uk> <1414672235.23399.7.camel@AMDC1943>
 <54523224.3010407@collabora.co.uk> <1414673587.23399.13.camel@AMDC1943>
Message-ID: <54524501.8030604@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/30/2014 01:53 PM, Krzysztof Kozlowski wrote:
> 
> To me a intuitive structure would be:
> MFD device
>   |
>   - clock device
>      |
>      - clock1
>      - clock2
>   - regulator device
>      |
>      - LDO1
>      - LDO2
> etc.
> 
> This also maps to structure in DTS. dev_err* messages and any
> allocations should be done on behalf of regulator device, not parent.
>
> Various drivers do this differently... The wm8* drivers set it mostly to
> parent (MFD)...
>
> I do not insists, especially because using parent's device would make
> this driver simpler.
>

Another reason to set it to the parent is to lookup the regulator input supply
node. The regulator_register() function does:

	if (supply) {
		struct regulator_dev *r;

		r = regulator_dev_lookup(dev, supply, &ret);

where dev = config->dev so that will determine on which device node your
input supplies have to be defined. For example on the Peach Pit DTS has this:

	max77802: max77802-pmic at 9 {
		...
		inb1-supply = <&tps65090_dcdc2>;
		...
		inb10-supply = <&tps65090_dcdc1>;

		inl1-supply = <&buck5_reg>;
		...
		inl10-supply = <&buck7_reg>;
		...

		regulators {
		...
		};
	};

which is how most (all?) DTS define the input supplies. If you instead
do config.dev = &pdev->dev, then the input supplies have to be in the
"regulators" node which is not the standard AFAICT.

This is not a problem for max77686 because I see that DTS don't define
the input supplies but I guess that is because the power scheme is not
completely modeled.
 
> Mark, maybe you could shed light on it?
> 
> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
Javier
