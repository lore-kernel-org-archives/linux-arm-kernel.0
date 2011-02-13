From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Feb 2011 22:12:28 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <1297465616.18578.8.camel@gnutoo-laptop>
References: <20110211081050.GD27982@pengutronix.de>
	<1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
	<1297458816.18578.5.camel@gnutoo-laptop>
	<20110211213954.GK27982@pengutronix.de>
	<1297465616.18578.8.camel@gnutoo-laptop>
Message-ID: <20110213211228.GB13279@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Sat, Feb 12, 2011 at 12:06:56AM +0100, Denis 'GNUtoo' Carikli wrote:
> On Fri, 2011-02-11 at 22:39 +0100, Uwe Kleine-K?nig wrote:
> > On Fri, Feb 11, 2011 at 10:13:36PM +0100, Denis 'GNUtoo' Carikli wrote:
> > > > diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
> > > > index e634d6c..b45f534 100644
> > > > --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> > > > +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> > > > @@ -62,6 +62,7 @@ static inline void flush(void)
> > > >  #define MX2X_UART1_BASE_ADDR	0x1000a000
> > > >  #define MX3X_UART1_BASE_ADDR	0x43F90000
> > > >  #define MX3X_UART2_BASE_ADDR	0x43F94000
> > > > +#define MX3X_UART5_BASE_ADDR	0x43FB4000
> > > >  #define MX51_UART1_BASE_ADDR	0x73fbc000
> > > >  #define MX50_UART1_BASE_ADDR	0x53fbc000
> > > >  #define MX53_UART1_BASE_ADDR	0x53fbc000
> > > > @@ -102,6 +103,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
> > > >  	case MACH_TYPE_MAGX_ZN5:
> > > >  		uart_base = MX3X_UART2_BASE_ADDR;
> > > >  		break;
> > > > +	case MACH_TYPE_BUG:
> > > > +		uart_base = MX3X_UART5_BASE_ADDR;
> > > > +		break;
> > > >  	case MACH_TYPE_MX51_BABBAGE:
> > > >  	case MACH_TYPE_EUKREA_CPUIMX51SD:
> > > >  	case MACH_TYPE_MX51_3DS:
> > > That seem not to crash, but I wonder if it's really useful:
> > > Basically I see u-boot loading the kernel, then I have
> > > > Uncompressing Linux... 
> > > Then I wait some seconds
> > > Then I see that line beeing complretted with:
> > > > done, booting the kernel.
> > > Then the rest of the messages are displayed very fast,
> > > along with initramfs loading messages and I finally get a shell.
> > That means you'd prefer no output? 
> I should have misunderstood something, but I believed that that
> uncompress.h was for early printk.
> And so I expected printk to be printed on serial console immediately,
> not waiting for the serial port to be initialized again(as it is already
> initialized by the u-boot bootloader).
There is nothing reinitialized, in fact the code in
arch/arm/plat-mxc/include/mach/uncompress.h assumes the UART is already
initialized by the boot loader.  The only difference this hunk above
results in is that the messages "Uncompressing Linux..." and "done,
booting the kernel." are printed on your UART.  And if you skip them you
still have that some seconds pause, and you only save the time the
characters need to pass your UART.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
