From: timur@tabi.org (Timur Tabi)
Date: Sun, 14 Apr 2013 08:37:21 -0500
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <20130414103819.GA27394@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
Message-ID: <516AB111.3000007@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> I do not think it is possible. For example imx27 ssi does support
> DMA but for specific boards we have to use fiq instead (phycore-ac97).
> So I would prefer to define the DMA in the chip dtsi file and choose
> fiq, if necessary, in the board dts.

I'm not completely familiar with the way i.MX SSI bindings work, but isn't 
there some property that says, "this SSI needs to use this DMA channel"? 
So if that property is missing, then it means that there's no link between 
the SSI and a DMA channel, and so you need to use FIQ.

For example, for PowerPC bindings, we have this:

		ssi at 16000 {
			compatible = "fsl,mpc8610-ssi";
			cell-index = <0>;
			reg = <0x16000 0x100>;
			interrupt-parent = <&mpic>;
			interrupts = <62 2>;
			fsl,mode = "i2s-slave";
			codec-handle = <&cs4270>;
-->			fsl,playback-dma = <&dma00>;
-->			fsl,capture-dma = <&dma01>;

So on PowerPC, if these two properties are missing, then we would use 
interrupt mode.


-- 
Timur Tabi
