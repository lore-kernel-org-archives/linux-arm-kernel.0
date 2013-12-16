From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Dec 2013 18:56:11 +0100
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1387198885.13062.154.camel@host5.omatika.ru>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312150355.27755.arnd@arndb.de>
 <1387198885.13062.154.camel@host5.omatika.ru>
Message-ID: <201312161856.11384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 December 2013, Sergei Ianovich wrote:
> PXA27x memory bus can have up to 10 devices: up to 6 slower
> flash/SRAM/variable-latency-IO selected by nCS<0> to <5>, and up to 4
> partions of SDRAM selected by nSDCS<0> to <3>.
> 
> It appears that the FPGA is directly connected to the memory bus and is
> selected by nCS<5>. According to MSC2 configuration (already in the
> mainstream U-Boot), the FPGA is configured as a synchronous SRAM with
> access cycle of 30x memory bus cycles. So I made it a top-level bus like
> pxabus.
> 
> Ethernet devices are also connected to the memory bus via some kind of
> gate array. This one is a bit faster -- 15x memory cycles, which is
> still a lot. It explains why network transfers are never faster than 15
> Mbit/s.

Ok, I see. This sounds like some of the other platforms we have with
external memory buses. If there is a chance that Linux ever has to
program the per-CS settings into the bus controller, I would suggest
to represent that as well as a separate node, like this

extbus {
	compatible = "simple-bus";

	#address-cells = <2>; /* first cell is nCS, second is address */
	#size-cells = <1>;

	ranges = <0 0 0 0x04000000>
		 <1 0 0x04000000 0x04000000>
		 <2 0 0x08000000 0x04000000>
		 <3 0 0x0c000000 0x04000000>
	  	 <4 0 0x10000000 0x04000000>
	  	 <5 0 0x14000000 0x04000000>;

	timings = ...;

	flash at 0 {
		reg = <0 0x0 0x02000000>;
		...
	};

	flash at 1 {
		reg = <1 0x0 0x02000000>;
		...
	};

	fpga at 5 {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 5 0x03000000 0x10000>;
		...
	};
};

In case there is a driver for the extbus node, I would not make it
"simple-bus" but instead add a separate compatible string to match
the driver, and let that driver call of_platform_populate
to probe the children after the bus is set up.

	Arnd
