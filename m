From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 05 Feb 2014 13:05:14 +0100
Subject: [PATCH v7 2/7] dt-bindings: sram: describe option to reserve
 parts of the memory
In-Reply-To: <20140205111247.476B7C40A89@trevor.secretlab.ca>
References: <4970034.fqvMoHdOyd@phil> <1782709.QdZpsrsctf@phil>
 <20140205111247.476B7C40A89@trevor.secretlab.ca>
Message-ID: <1816961.2dvm7Iumeh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. Februar 2014, 11:12:47 schrieb Grant Likely:
> On Mon, 20 Jan 2014 16:42:58 +0100, Heiko St??bner <heiko@sntech.de> wrote:
> > Some SoCs need parts of their sram for special purposes. So while being
> > part of the peripheral, it should not be part of the genpool controlling
> > the sram.
> > 
> > Therefore add an option mmio-sram-reserved to keep arbitrary portions of
> > the sram from general usage.
> > 
> > Suggested-by: Rob Herring <robherring2@gmail.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > 
> >  Documentation/devicetree/bindings/misc/sram.txt |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/sram.txt
> > b/Documentation/devicetree/bindings/misc/sram.txt index 4d0a00e..09ee7a3
> > 100644
> > --- a/Documentation/devicetree/bindings/misc/sram.txt
> > +++ b/Documentation/devicetree/bindings/misc/sram.txt
> > 
> > @@ -8,9 +8,17 @@ Required properties:
> >  - reg : SRAM iomem address range
> > 
> > +Optional properties:
> > +
> > +- mmio-sram-reserved: ordered list of reserved chunks inside the sram
> > that
> > +  should not be used by the operating system.
> > +  Format is <base size>, <base size>, ...; with base being relative to
> > the
> > +  reg property base.
> > +
> 
> We've now got a draft binding for reserved memory. Can you use the format
> here? Basically each reserved region is a sub node with either a reg
> property or a size property.
> 
> This is specifically for sram, so I won't make a big deal about it, but
> it would be good to have some commonality.

I guess you're talking about "[PATCH v2 0/5] reserved-memory regions/CMA in 
devicetree, again", right?

In general I'm all for commonality :-). So I guess you mean it to look 
something like the following:

	sram: sram at 10080000 {
		compatible = "rockchip,rk3066-sram", "mmio-sram";
		reg = <0x10080000 0x8000>;

		reserved-memory {
			#address-cells = <1>;
			#size-cells = <1>;

			smp at 200 {
				/* hmm, relative or absolute, aka 0x200 or 0x10080200? */
				reg = <0x200 0x50>;
			};
		};
	};

As it looks like only a slight modification of my "parsing" code this should be 
doable. Do you suggest more changes to the example above?


Heiko
