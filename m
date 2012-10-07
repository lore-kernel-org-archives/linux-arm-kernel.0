From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 8 Oct 2012 01:14:41 +0200
Subject: [PATCH 6/6] ARM: bcm476x: Instantiate console UART
In-Reply-To: <20121007200300.GH12801@game.jcrosoft.org>
References: <20121007015300.828366635@gmail.com>
 <20121007015407.840781689@gmail.com>
 <20121007200300.GH12801@game.jcrosoft.org>
Message-ID: <20121007231441.GB29996@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 10:03:00PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 03:53 Sun 07 Oct     , Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > The BCM476x sports standard PL011 UARTs which are fully described and
> > put to use with these few changes.
> > 
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > ---
> >  arch/arm/Kconfig.debug         |   16 ++++++++++++++++
> >  arch/arm/boot/dts/bcm476x.dtsi |   23 ++++++++++++++++++++++-
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> > 
> > Index: b/arch/arm/boot/dts/bcm476x.dtsi
> > ===================================================================
> > --- a/arch/arm/boot/dts/bcm476x.dtsi
> > +++ b/arch/arm/boot/dts/bcm476x.dtsi
> > @@ -5,7 +5,7 @@
> >  	model = "Broadcom BCM476x";
> >  
> >  	chosen {
> > -		bootargs = "earlyprintk";
> > +		bootargs = "console=ttyAMA1";
> >  	};
> >  
> >  	amba {
> > @@ -41,5 +41,26 @@
> >  			interrupt-controller;
> >  			#interrupt-cells = <1>;
> >  		};
> > +
> > +		uart0 at c0000 {
> > +			compatible = "brcm,bcm476x-pl011", "arm,pl011", "arm,primecell";
> why brcm specific compatible did broadcom customised the IP?

yes, there are some peculiarities here but do not prevent the normal pl011
driver to work.

> > +			reg = <0xc0000 0x1000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <14>;
> > +		};
> > +
> > +		uart1 at c1000 {
> > +			compatible = "brcm,bcm476x-pl011", "arm,pl011", "arm,primecell";
> > +			reg = <0xc1000 0x1000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <15>;
> > +		};
> > +
> > +		uart2 at b2000 {
> > +			compatible = "brcm,bcm476x-pl011", "arm,pl011", "arm,primecell";
> > +			reg = <0xb2000 0x1000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <16>;
> > +		};
> >  	};
> >  };
> > Index: b/arch/arm/Kconfig.debug
> > ===================================================================
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> this should come with the debug patch

ok

> > @@ -89,6 +89,18 @@ choice
> >  		bool "Kernel low-level debugging on 9263 and 9g45"
> >  		depends on HAVE_AT91_DBGU1
> >  
> > +	config DEBUG_BCM476X_UART0
> > +		depends on ARCH_BCM476X
> > +		bool "Kernel low-level debugging on BCM476x UART 0"
> > +
> > +	config DEBUG_BCM476X_UART1
> > +		depends on ARCH_BCM476X
> > +		bool "Kernel low-level debugging on BCM476x UART 1"
> > +
> > +	config DEBUG_BCM476X_UART2
> > +		depends on ARCH_BCM476X
> > +		bool "Kernel low-level debugging on BCM476x UART 2"
> > +
> >  	config DEBUG_CLPS711X_UART1
> >  		bool "Kernel low-level debugging messages via UART1"
> >  		depends on ARCH_CLPS711X
> > @@ -404,6 +416,8 @@ endchoice
> >  
> >  config DEBUG_LL_INCLUDE
> >  	string
> > +	default "debug/bcm476x.S" if DEBUG_BCM476X_UART0 || \
> > +		DEBUG_BCM476X_UART1 || DEBUG_BCM476X_UART2
> >  	default "debug/icedcc.S" if DEBUG_ICEDCC
> >  	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
> >  	default "debug/mvebu.S" if DEBUG_MVEBU_UART
> > @@ -416,6 +430,8 @@ config DEBUG_LL_INCLUDE
> >  
> >  config UNCOMPRESS_INCLUDE
> >  	string
> > +	default "debug/bcm476x-uncompress.h" if DEBUG_BCM476X_UART0 || \
> > +		DEBUG_BCM476X_UART1 || DEBUG_BCM476X_UART2
> >  	default "debug/icedcc-uncompress.h" if DEBUG_ICEDCC
> >  	default "debug/mvebu-uncompress.h" if DEBUG_MVEBU_UART
> >  	default "debug/tegra-uncompress.h" if DEBUG_TEGRA_UART
> Best Regards,
> J.

Thank you.

Regards,
Domenico
