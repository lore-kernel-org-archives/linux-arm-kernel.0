From: sre@debian.org (Sebastian Reichel)
Date: Fri, 22 Nov 2013 00:17:52 +0100
Subject: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
In-Reply-To: <1385059866-10646-4-git-send-email-tony@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
 <1385059866-10646-4-git-send-email-tony@atomide.com>
Message-ID: <20131121231751.GA9772@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Nov 21, 2013 at 10:51:06AM -0800, Tony Lindgren wrote:
> Looks like we need to configure the regulators and use the pdata
> quirk to make eMMC work with device tree.
> 
> It seems that mostly vmmc2 is used, and only some earlier revisions
> like the macro board used vaux3.
> 
> Note that we can add support for the macro board later as needed
> by including the common n900 .dts file and configuring the vaux3
> instead of vmmc2, and adding support for the smc91x Ethernet.
>
> ---
> 
> Can you guys please test this on production n900 devices?
> 
> I've tested it with my old macro board where I had to patch in vaux3
> instead of vmmc2. I think there's some confusion in the legacy code
> comments, or else I'm confused. In any case, vaux3 works for the macro
> board, and I suspect that the production versions have vmmc2.
> 
> If this does not work and vaux3 as regulator works, please also dump
> out the system_rev from your board.

The good news is, that I got eMMC working :) The bad news is, that it
did not work with your patch :( I included my DTS nodes below. The
phone is HW/System revision 0x2101.

I have a second N900, which has HW revision 0x2204. I did not yet test
the patch with this phone, but legacy code also seems to use vaux3 for
it. Seems like we need two n900.dts files?

--- DTS nodes working on the 0x2101 board ---

&omap3_pmx_core {
	mmc2_pins: pinmux_mmc2_pins {
		pinctrl-single,pins = <
			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk */
			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd */
			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc2_dat0 */
			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1 */
			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2 */
			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3 */
			0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat4 */
			0x136 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat5 */
			0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat6 */
			0x13a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat7 */
		>;
	};
};

&mmc2 {
    pinctrl-names = "default";
    pinctrl-0 = <&mmc2_pins>;

    vmmc-supply = <&vaux3>;
    vmmc_aux-supply = <&vsim>;
    bus-width = <8>;
    non-removable;
};

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/9b244e1d/attachment.sig>
