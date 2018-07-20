From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 20 Jul 2018 11:12:50 +0800
Subject: [RFC] ARM: imx6q: add ENET_CLK_SEL mux option
In-Reply-To: <1532029693-22764-1-git-send-email-jacopo@jmondi.org>
References: <1532029693-22764-1-git-send-email-jacopo@jmondi.org>
Message-ID: <20180720031249.GB4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 09:48:13PM +0200, Jacopo Mondi wrote:
> This is just an attempt to set IOMUX_GPR1[21] bit...
> 
> Not-Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> ---
> Hello imx people (recipients list comes from get_maintainer script)
> 
>    I'm very new to this platform, so pardon me if I'm asking a question here,
> more than sending an actual patch.
> 
> Context: I have a board that needs bit 21 of register IOMUX_GPR1 set.
> This basically tells the SoC to use an internally generated clock as clock
> reference for the external PHY chip.

I think this has been handled as the default setup by function
imx6q_1588_init() in arch/arm/mach-imx/mach-imx6q.c.  Basically, it
checks 'ptp' clock setting in FEC node.  If it's the internal clock
'enet_ref', the function will set IOMUX_GPR1[21] bit.  For those board
designs using external OSC, they should overwrite the FEC node clocks
setting in their board level DTS to get 'ptp' clock point to the
external OSC.  The imx6qdl-icore.dtsi is such an example.

Shawn
