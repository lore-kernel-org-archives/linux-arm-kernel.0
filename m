From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 22:08:30 +0900
Subject: [PATCH v3 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and
 SSDK-GH7 board
In-Reply-To: <20140321114710.GO23372@e106331-lin.cambridge.arm.com>
References: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
 <1395094477-8921-2-git-send-email-kgene.kim@samsung.com>
 <20140321114710.GO23372@e106331-lin.cambridge.arm.com>
Message-ID: <01e901cf4506$a7c1a5c0$f744f140$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:
> 
> Hi,
> 
Hi Mark,

[...]

> > +/memreserve/ 0xFEC00000 0x1400000;	/* EL3 monitor, secure intepreter */
> 
> As I've mentioned, I'm concerned that this is even in the non-secure
> address space that the kernel can access. Why is this not hidden from
> the kernel entirely? Why is it expected to be mapped in and reserved?
> 
OK, I will make kernel cannot access the memory area with hiding.

> Additionally, the memory the used by the spin-table (0x0 0x8000fff8) has
> not been reserved, and thus the kernel is free to clobber it.
> 
Oops, I missed. OK I will add following instead of above.

+/memreserve/ 0x80000000 0x00010000;

> [...]
> 
> > +	gic: interrupt-controller at 1C000000 {
> > +		compatible = "arm,cortex-a15-gic";
> 
> For targeting any future workarounds I would very much prefer a more
> specific string.
> 
If any workarounds are required later, will add specific string then.

> [...]
> 
> > +	pmu {
> > +		compatible = "samsung,gh7-pmu", "armv8-pmuv3";
> > +		interrupts = <0 294 0>,
> > +			     <0 295 0>,
> > +			     <0 296 0>,
> > +			     <0 297 0>,
> > +			     <0 298 0>,
> > +			     <0 299 0>,
> > +			     <0 300 0>,
> > +			     <0 301 0>;
> > +	};
> 
> These are all missing a trigger type (thus making them unusable), and as
> "GH7" is the SoC name rather than the CPU name, the compatible string is
> somewhat bad.
> 
Oops, it should be 8.

And yes, as I've mentioned "GH7" is SoC name not CPU name.

I'm still thinking _really_ I need to use CPU specific name for GH7 SoC because
we don't need to handle for the specific CPU implementation in kernel even we
didn't name it.

> > +
> > +	amba {
> > +		compatible = "arm,amba-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		serial at 12c00000 {
> > +			compatible = "arm,pl011", "arm,primecell";
> > +			reg = <0 0x12c00000 0 0x10000>;
> > +			interrupts = <0 418 0>;
> > +		};
> > +
> > +		serial at 12c20000 {
> > +			compatible = "arm,pl011", "arm,primecell";
> > +			reg = <0 0x12c20000 0 0x10000>;
> > +			interrupts = <0 420 0>;
> > +		};
> 
> While the primecell bindings and PL011 bindings state that clocks are
> optional, the primecell bus code requires a clock named apb_pclk, and
> the pl011 driver requires a clock (which it expects to be UARTCLK) to
> acquire the frequency from. As neither are provided I do not see how
> this DT could possibly be used to boot a usable system.
> 
> Additionally the interrupt trigger types are missing.
> 
> Given that these are the only IO devices described in the dtsi/dts
> combination, and they do not appear to be usable, what is the point in
> merging this?
> 
Definitely, it is meaningful because we can enhance everything more based on
this for the mass product.

Thanks for your time.

- Kukjin
