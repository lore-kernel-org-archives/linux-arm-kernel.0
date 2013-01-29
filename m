From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 14:55:49 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <20130129142434.GW23505@n2100.arm.linux.org.uk>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291344.11066.arnd@arndb.de>
 <20130129142434.GW23505@n2100.arm.linux.org.uk>
Message-ID: <201301291455.49347.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Russell King - ARM Linux wrote:
> No, that's not what I mean.  I mean the situation we find on Versatile
> platforms:
> 
>             8     3                   >3
> PL080 DMA --/--+--/------> FPGA Mux --/--> {bunch of off-CPU peripherals}
>                |  5
>                `--/------> {On-CPU peripherals}
> 
> This is something that I've been raising _every time_ I've been involved
> with DMA engine discussions when it comes to the matching stuff, so this
> is nothing new, and it's not unknown about.

Ok, I see. I have not actually been involved with the DMA engine API
much, so for me it's the first time /I/ see this being explained.

>From the DT binding perspective, doing this should be no problem. I guess
you would model the MUX as a trivial dma engine device that forwards to
another one, just like we do for nested interrupt controllers:

	pl080: dma-engine at 10000000 {
		compatible ="arm,pl080", "arm,primecell";
		reg = <0x10000000 0x1000>;
		dma-requests = <8>;
		dma-channels = <4>;
		#dma-cells = <2>;
	};

	fpga {
		mux: dma-mux at f0008000 {
			reg = <0xf0008000 100>;
			compatible = "arm,versatile-fpga-dmamux";
			dma-requests = <7>;
			dma-channels = <3>;
			#dma-cells = <1>;
			dmas = <&pl080 5 0>, <&pl080 6 0> <&pl080 7 0>;
			dma-names = "mux5", "mux6", "mux7";
		};
		...

		some-device at f000a000 {
			compatible = "foo,using-muxed-dma";
			dmas = <&mux 3>, <&mux 4>;
			dma-names = "rx", "tx";
		};
	};

The driver for foo,using-muxed-dma just requests a slave channel for its
lines, which ends up calling the xlate function of the driver for the mux.
That driver still needs to get written, of course, but it should be able
to recursively call dma_request_slave_channel on the pl080 device.
The arm,versatile-fpga-dmamux driver would not be registered to the dmaengine
layer, but it would register as an of_dma_controller.

	Arnd
