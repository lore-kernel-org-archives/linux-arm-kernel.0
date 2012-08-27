From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 27 Aug 2012 11:44:03 +0200
Subject: [PATCH] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <CA+E=qVfV1DL1ikjVnLd7qTeCx9C8Z7dGvhh_9NSgxPYrOCJ=0g@mail.gmail.com>
References: <201208252353.59345.heiko@sntech.de>
 <201208271001.05026.heiko@sntech.de>
 <CA+E=qVfV1DL1ikjVnLd7qTeCx9C8Z7dGvhh_9NSgxPYrOCJ=0g@mail.gmail.com>
Message-ID: <201208271144.03681.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

Am Montag, 27. August 2012, 10:57:04 schrieb Vasily Khoruzhick:
> Hi,
> 
> On Mon, Aug 27, 2012 at 11:01 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi Thomas,
> > 
> > thanks for your review:
> > 
> > Hmmm, but the logic to drive the gpio controller is the same for all
> > arches. The only difference is the number to use for the different pull
> > up/down settings. So I think the "samsung,s3c24xx-gpio" is ok but the
> > documentation should simply reflect the different pull settings.
> 
> Also s3c2410 and s3c2440 has different count of GPIOs. And that could
> be a problem on machines
> with GPIO-expanders (h1940 machine)

I'm not sure I follow :-) . 

The compatible property here only sets the mechanism on how to handle the 
gpios defined in the devicetree - here to use the s3c24xx-style. As you can 
see in gpio-samsung.c the handling is already unified for all the s3c24xx 
architectures.

The definition of what gpio banks exist is then done in the respective 
devicetree file for the individual SoC. And of course here one would have 
individual definitions, depending on the banks present.

For reference my quite empty s3c2416.dtsi file currently looks like:

/include/ "skeleton.dtsi"

/ {
	compatible = "samsung,s3c2416";

	cpus {
		cpu at 0 {
			compatible = "arm,arm926ejs";
		};
	};

	gpio-controllers {
		#address-cells = <1>;
		#size-cells = <1>;
		gpio-controller;
		ranges;

		gpa: gpio-controller at 56000000 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000000 0x10>;
			#gpio-cells = <3>;
		};

		gpb: gpio-controller at 56000010 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000010 0x10>;
			#gpio-cells = <3>;
		};

		gpc: gpio-controller at 56000020 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000020 0x10>;
			#gpio-cells = <3>;
		};

		gpd: gpio-controller at 56000030 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000030 0x10>;
			#gpio-cells = <3>;
		};

		gpe: gpio-controller at 56000040 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000040 0x10>;
			#gpio-cells = <3>;
		};

		gpf: gpio-controller at 56000050 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000050 0x10>;
			#gpio-cells = <3>;
		};

		gpg: gpio-controller at 56000060 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000060 0x10>;
			#gpio-cells = <3>;
		};

		gph: gpio-controller at 56000070 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000070 0x10>;
			#gpio-cells = <3>;
		};

		/* s3c2443 and later */
		gpj: gpio-controller at 560000D0 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x560000D0 0x10>;
			#gpio-cells = <3>;
		};

		gpk: gpio-controller at 560000E0 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x560000E0 0x10>;
			#gpio-cells = <3>;
		};

		gpl: gpio-controller at 560000F0 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x560000F0 0x10>;
			#gpio-cells = <3>;
		};

		gpm: gpio-controller at 56000100 {
			compatible = "samsung,s3c24xx-gpio";
			reg = <0x56000100 0x10>;
			#gpio-cells = <3>;
		};
	};
};

Other s3c24xx SoCs would of course need to define their own.

> >> It would be informative to add information about the 'mux function'
> >> cell here as well. Specifically, on how to handle the banks that have
> >> an extended GPxSEL register that allow additional pin function
> >> selection.
> > 
> > Will add a mux function description.
> > 
> > Until now I've never realised the existence of the GPxSEL registers, so
> > thanks for the pointer :-).
> > 
> > But is this used in the driver at all? All the setcfg/getcfg functions in
> > gpio-samsung.c only handle the GPxCON registers - I haven't found code to
> > handle the GPxSEL registers at all. So my guess is that this was never
> > implemented - or that I'm blind ;-) .
> 
> There're no GPxSEL registers on s3c2410/s3c2440/s3c2442. Is it
> something s3c2412/sec2416 specific?

s3c2412 also does not have it ... it seems entirely specific to 
s3c2416/s3c2450 and as written also seems to be unused.
So I would tend to ignore it for now :-) .


Heiko
