From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Thu, 03 Oct 2013 20:30:55 +1300
Subject: [RFC PATCH 2/3] Enable BCM2835 mailbox support
In-Reply-To: <524BECCC.6030804@yahoo.com.au>
References: <5232F7C2.3070408@yahoo.com.au> <524B8D7A.6080204@wwwdotorg.org>
 <524BECCC.6030804@yahoo.com.au>
Message-ID: <524D1D2F.3020303@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 10:52 PM, Craig McGeachie wrote:
> mailbox {
>      compatible = "brcm,bcm2835-mbox";
>      reg = <0x7e00b880 0x40>;
>      interrupts = <0 1>;
>      #address-cells = <1>;
>      #size-cells = <0>;
>      power at 0 {
>          reg = <0>;
>      };
>      fb at 1 {
>          reg = <1>;
>      };
>      vchiq at 1 {
>          reg = <3>;
>      };
>      props_mbox: property at 8 {
>          reg = <8>;
>      };
> };
>
> thermal {
>      compatible = "brcm,bcm2835-thermal";
>      brcm,channel = <&props_mbox>;
> };
>

It's occurred to me that this might not be the best motivating example. 
  thermal has no register address and does not belong under soc really, 
even if it sort of works.  It does make more sense for it to live under 
mailbox, maybe.  DMA is the other example that might make more sense.

mailbox {
	compatible = "brcm,bcm2835-mbox";
	reg = <0x7e00b880 0x40>;
	interrupts = <0 1>;
	#address-cells = <1>;
	#size-cells = <0>;
	power at 0 {
		reg = <0>;
	};
	fb at 1 {
		reg = <1>;
	};
	vchiq at 1 {
		reg = <3>;
	};
	props_mbox: property at 8 {
		reg = <8>;
	};
};

dma {
	compatible = "brcm,bcm2835-dma";
	reg = <0x7e007000 0x1000>;
	channel = <&props_mbox>;
	interrupts =
		<1 16>, <1 17>, <1 18>, <1 19>, <1 20>, <1 21>,
		<1 22>, <1 23>, <1 24>, <1 25>, <1 26>, <1 27>,
		<1 28>;
	/* Maybe some other stuff. */
};

/* And thermal somewhere else, I don't know where. */

Access to the properties mailbox channel enables getting a bit mask of 
DMA channels that the ARM core is permitted to use.

Cheers,
Craig.
