From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Sep 2015 14:57:53 +0100
Subject: [PATCH 2/2] arm64/apm: add dts for Gigabyte MP30-AR0 board
In-Reply-To: <20150902075936.GR17056@jannau.net>
References: <1440948270-1991-1-git-send-email-j@jannau.net>
 <1440948270-1991-3-git-send-email-j@jannau.net>
 <20150901105510.GB15900@leverpostej>
 <20150902075936.GR17056@jannau.net>
Message-ID: <20150902135753.GA15051@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +};
> > > diff --git a/arch/arm64/boot/dts/apm/mp30ar0.dts b/arch/arm64/boot/dts/apm/mp30ar0.dts
> > > new file mode 100644
> > > index 0000000..f7a9dae5
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/apm/mp30ar0.dts
> 
> [...]
> 
> > > +	memory {
> > > +		#address-cells = <0x2>;
> > > +		#size-cells = <0x2>;
> > 
> > I don't see why these properties should be here.
> 
> removed
> 
> > > +		device_type = "memory";
> > > +		reg = <0x0 0x0 0x0 0x2000000>;
> > 
> > Is this overriden by the bootloader? It seems a tad small...
> 
> yes, it is overriden by the bootloader. It requires a memory node in the 
> dts but will overwrite the contents. I'll set size to zero and add a 
> comment that it is updated by the bootloader. I could set start to 0x40 
> 0x00 or leave it at zero.

I think all zeroes is preferable. The comment is definitely worthwhile.

> > > +	};
> > > +
> > > +	poweroff_mbox: poweroff_mbox at 10548000 {
> > > +		compatible = "syscon";
> > > +		reg = <0x0 0x10548000 0x0 0x100>;
> > > +	};
> > > +
> > > +	poweroff at 10548010 {
> > > +		compatible = "syscon-poweroff";
> > > +		regmap = <&poweroff_mbox>;
> > > +		offset = <0x10>;
> > > +		mask = <0x1>;
> > > +	};
> > > +
> > > +	chosen {
> > > +		linux,stdout-path = "/soc/serial at 1c020000";
> > 
> > Please use stdout-path rather than linux,stdout-path.
> > 
> > No rate configuration?
> > 
> > This would look nicer with an alias.
> 
> I can change that but the bootloader will add a 'linux,stdout-path' and 
> the stdout-path will override it. OTOH the bootloader seems to always 
> add this exact string so it will be fine to "override" it from the dts.
> The alternative would to remove it.

I guess it doesn't fill in the rate, which is somewhat unfortunate.

Does it override an existing linux,stdout-path? If not, we could add the
rate.

I think we should have a comment about the bootlaoder filling in
linux,stdout-path, but other than that I'm not really sure what the best
option is.

Thanks,
Mark.
