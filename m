From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 07:51:42 -0800
Subject: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
In-Reply-To: <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151130155142.GZ2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151130 05:49]:
> 
> For each dmaengine driver an array of DMA device, slave and the parameter
> for the filter function needs to be added:
> 
> static struct dma_filter_map da830_edma_map[] = {
> 	DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
> 	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
> 	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
> 	DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
> 	DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
> 	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
> 	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> };

FYI, if the EDMA_CTRL_CHAN above is just the evtmux registers, those
can be handled with the pinctrl framework. It seems that would allow
leaving out some of the built-in look up data, and have the mux parts
handled by a proper device driver. Below is a sample from the dm81xx
platform for reference.

SoC dtsi file:

evtmux: pinmux at f90 {
	compatible = "pinctrl-single";
	reg = <0xf90 0x40>;
	#address-cells = <1>;
	#size-cells = <0>;
	pinctrl-single,register-width = <8>;
	pinctrl-single,function-mask = <0x1f>;
};

Board specific dts file:

&evtmux {
	sd2_edma_pins: pinmux_sd2_edma_pins {
	pinctrl-single,pins = <
		8 1     /* use SDTXEVT1 for EDMA instead of MCASP0TX */
		9 2     /* use SDRXEVT1 for EDMA instead of MCASP0RX */
		>;
	};
};

Dynamic muxing of these channels can be done too using the pinctrl
framework named modes, but probably is not a good idea in the case of
SD card and MaASP in case something goes wrong :)

Regards,

Tony
