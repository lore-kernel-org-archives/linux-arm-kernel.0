From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Jul 2011 15:10:54 -0600
Subject: [RFC/RFT 1/2] gpio/basic_mmio: add support for enable register
In-Reply-To: <4E12AC10.9020206@gmail.com>
References: <cover.1309840042.git.nsekhar@ti.com>
	<83915224c24e43224272b1bf570cddb9545279a6.1309840042.git.nsekhar@ti.com>
	<4E12AC10.9020206@gmail.com>
Message-ID: <20110706211054.GE5371@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 04:15:44PM +1000, Ryan Mallon wrote:
> On 05/07/11 15:10, Sekhar Nori wrote:
> >Some GPIO controllers have an enable register
> >which needs to be written to before a GPIO
> >can be used.
> >
> >Add support for enabling the GPIO. At this
> >time inverted logic for enabling the GPIO
> >is not supported. This can be done by adding
> >a disable register as and when a controller
> >with this comes along.
> >
> >Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> >---
> >
> <snip>
> 
> >static int bgpio_setup_io(struct bgpio_chip *bgc,
> >  			  void __iomem *dat,
> >@@ -369,6 +401,7 @@ int __devinit bgpio_init(struct bgpio_chip *bgc,
> >  			 void __iomem *clr,
> >  			 void __iomem *dirout,
> >  			 void __iomem *dirin,
> >+			 void __iomem *en,
> >  			 bool big_endian)
> 
> The arguments to this function are getting a bit unwieldy :-). Maybe
> we need to introduce something like:
> 
> struct bgpio_chip_info {
>     struct device *dev;
>     unsigned long sz;
>     void __iomem *dat;
>     void __iomem *set;
>     void __iomem *clr;
>     void __iomem *dirout;
>     void __iomem *dirin;
>     void __iomem *en;
>     bool big_endian;
> };
> 
> and pass that to bgpio_init instead. It would have the added
> benefits of making the drivers more readable and that
> bgpio_chip_info structs in the drivers can probably be marked
> __initdata also.

Or, what may be better is to make callers directly update the
bgpio_chip structure.
