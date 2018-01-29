From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Jan 2018 15:55:41 -0800
Subject: [PATCH 4/4] drm/pl111: Support multiple endpoints on the CLCD
In-Reply-To: <20180126132033.19744-4-linus.walleij@linaro.org>
References: <20180126132033.19744-1-linus.walleij@linaro.org>
 <20180126132033.19744-4-linus.walleij@linaro.org>
Message-ID: <87wp00w77m.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The Versatile PL110 implementations use multiple endpoints:
> from the PL111 port, the lines are routed through a PLD,
> and from there forked so the same lines go to a VGA DAC and
> an external TFT panel connector. This is discrete wireing
> so there is no way to turn of one output, i.e. this is
> really two endpoints, not two ports.
>
> We model this with multiple endpoints, so we need to loop
> over the available endpoints, check for panel or bridge on
> each and accumulate the result before continuing.
>
> The code already will give the panel preference over the
> bridge, if present, so the output will be sent to the panel
> if both a panel and a bridge is present on two endpoints
> of the same port.
>
> If they all return -EPROBE_DEFER we return -EPROBE_DEFER
> as well.
>
> If just one endpoint is present on the port, the behaviour
> is the same as before.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Huh, from the binding I would have thought that we were describing
things to the point of the pins coming out of the PLD, not past whatever
splitting comes after that.

I'm also confused how this would work.  You're talking about the DT
looking like:

	clcd at 10020000 {
		compatible = "arm,pl111", "arm,primecell";
		reg = <0x10020000 0x1000>;
		interrupt-names = "combined";
		interrupts = <0 44 4>;
		clocks = <&oscclk1>, <&oscclk2>;
		clock-names = "clcdclk", "apb_pclk";
		max-memory-bandwidth = <94371840>; /* Bps, 1024x768 at 60 16bpp */

		port {
			dac_pads: endpoint1 {
				remote-endpoint = <&vgadac>;
				arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
			};
			tft_pads: endpoint2 {
				remote-endpoint = <&tftpanel>;
				arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
			};
		};

	};


Are you anticipating that a DT would actually connect up to two
endpoints on the CLCD?  How should we resolve the pads property, in that
case?  Is there much point in supporting this, if we don't actually
support panels or bridges on both of the endpoints at once (since we
pick only one to do panel/bridge setup/teardown on)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/bc00e80f/attachment.sig>
