From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Feb 2016 15:37:10 -0800
Subject: [PATCH v2 1/6] dt-bindings: arm/marvell: add DT bindings for
 AP806 DFX Server
In-Reply-To: <1456326866-30854-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456326866-30854-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160225233710.GJ28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24, Thomas Petazzoni wrote:
> +Marvell AP806 DFX Server
> +------------------------
> +
> +The Marvell AP806 HW block (which is a core component of the Marvell
> +Armada 7K and 8K SOCs) has a set of registers called "DFX
> +Server". This set of registers contains miscellaneous registers, most
> +of them being used for silicon fine-tuning and manufacturing testing,
> +and as such are not publicly documented. However, this DFX server
> +register range also contains a few documented and useful registers,
> +for example for clock control.
> +
> +This Device Tree binding allows to represent the entire DFX server
> +register space as one single DT node.
> +
> +Required properties:
> +- compatible: the first and second values must be:
> +	"simple-mfd", "syscon"
> +- reg: address and length of following register sets for the DFX
> +  server

Example?

I would think the binding would be done in a way that we don't
have to describe every little register in this misc register
block. Instead, dfx server has a compatible:

 node at f00 {
 	reg = <0xf00 0x100>;
	compatible = "marvell,dfx-ap806";
	#clock-cells = <1>;
 };

And then a driver that probes this compatible string and
registers a handful of clks. If we ever get into a situation
where we want to expose non-clk functionality from this device
node, we would make some sort of mfd driver that probes based on
the same compatible string and creates platform devices in
software to register the clk device component and whatever other
device type is used. In that situation, we could assign a regmap
to the mfd device and the clk device would be a child of the mfd
and get a regmap through the dev->parent pointer.

TL;DR I'm still lost why we have to describe each clk in DT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
