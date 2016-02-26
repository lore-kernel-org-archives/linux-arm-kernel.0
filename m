From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Feb 2016 09:32:27 +0100
Subject: [PATCH v2 1/6] dt-bindings: arm/marvell: add DT bindings for
 AP806 DFX Server
In-Reply-To: <20160225233710.GJ28849@codeaurora.org>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456326866-30854-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160225233710.GJ28849@codeaurora.org>
Message-ID: <20160226093227.5d4dc1a7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

Thanks for your feedback!

On Thu, 25 Feb 2016 15:37:10 -0800, Stephen Boyd wrote:

> I would think the binding would be done in a way that we don't
> have to describe every little register in this misc register
> block. Instead, dfx server has a compatible:
> 
>  node at f00 {
>  	reg = <0xf00 0x100>;
> 	compatible = "marvell,dfx-ap806";
> 	#clock-cells = <1>;
>  };
> 
> And then a driver that probes this compatible string and
> registers a handful of clks. If we ever get into a situation
> where we want to expose non-clk functionality from this device
> node, we would make some sort of mfd driver that probes based on
> the same compatible string and creates platform devices in
> software to register the clk device component and whatever other
> device type is used. In that situation, we could assign a regmap
> to the mfd device and the clk device would be a child of the mfd
> and get a regmap through the dev->parent pointer.
> 
> TL;DR I'm still lost why we have to describe each clk in DT.

I would entirely agree with you if this DFX Server was some sort of
"system control" IP block that provided clocks, resets, and all sort of
other features.

But this DFX server thing is just a bunch of registers with absolutely
no relation to clocks. Due to this, it would be completely awkward to
have clock references like:

	serial {
		clocks = <&dfxserver 42>;
	};

One will wonder "why the heck this UART controller is using a clock
from this really odd dfxserver thing" ? Currently we have:

	serial {
		clocks = <&coreclk 4>;
	};

which makes a *lot* more sense.

Also, your idea of just hiding everything behind a MFD bothers me quite
a bit. If I push this idea further, then why shouldn't I replace my
entire DT with a single node, that covers the entire register space of
my SoC, and then handle *everything* as a huge MFD. In a way, it would
be quite useful for me, as it would resolve the on-going dispute over
DT binding stability with Rob and Mark.

For sure, I wouldn't have any DT backward compatibility issue, because
everything is hidden in my big MFD. But in terms of the DT as a
representation of the different HW blocks and the relations between
then, such a choice would be quite a failure.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
