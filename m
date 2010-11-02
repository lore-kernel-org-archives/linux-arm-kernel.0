From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Nov 2010 11:47:51 +0100
Subject: [patch v3 01/10] efikamx: read board id
In-Reply-To: <87iq0g6pbg.fsf@lechat.rtp-net.org>
References: <20101026200723.839428019@rtp-net.org>
	<20101026200953.996305184@rtp-net.org>
	<86A0E76937111F4C92FABEC0A20988510523CAD8@az33exm21>
	<87iq0g6pbg.fsf@lechat.rtp-net.org>
Message-ID: <20101102104751.GS31158@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 02, 2010 at 10:35:15AM +0100, Arnaud Patard wrote:
> Nguyen Dinh-R00091 <R00091@freescale.com> writes:
> 
> Hi,
> 
> > Hi,
> >
> >>-----Original Message-----
> >>From: linux-arm-kernel-bounces at lists.infradead.org
> > [mailto:linux-arm-kernel-
> >>bounces at lists.infradead.org] On Behalf Of Arnaud Patard
> >>Sent: Tuesday, October 26, 2010 3:07 PM
> >>To: linux-arm-kernel at lists.infradead.org
> >>Cc: matt at genesi-usa.com; Sascha Hauer; Arnaud Patard; Amit Kucheria
> >>Subject: [patch v3 01/10] efikamx: read board id
> >>
> >>read board id value from the GPIO3_16/17/11
> >>
> >>Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> >>Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
> >>===================================================================
> >>--- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c
> > 2010-10-21 08:29:23.000000000 +0200
> >>+++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
> > 2010-10-21 08:29:46.000000000 +0200
> >>@@ -39,12 +39,26 @@
> >>
> >> #define	MX51_USB_PLL_DIV_24_MHZ	0x01
> >>
> >>+#define EFIKAMX_PCBID0		(2*32 + 16)
> >>+#define EFIKAMX_PCBID1		(2*32 + 17)
> >>+#define EFIKAMX_PCBID2		(2*32 + 11)
> >>+
> >>+/* the pci ids pin have pull up. they're driven low according to board
> > id */
> >>+#define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0,
> > PAD_CTL_PUS_100K_UP)
> >>+#define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0,
> > PAD_CTL_PUS_100K_UP)
> >>+#define MX51_PAD_PCBID2	IOMUX_PAD(0x504, 0x128, 3, 0x0,   0,
> > PAD_CTL_PUS_100K_UP)
> >>+
> >
> > Seems a bit wasteful to redefine the IOMUX definitions. Couldn't you
> > just do something like this?
> 
> With a define, you have only 1 place to look at when debugging and
> configuring the pad requires only to put it in the list like any other
> pad. With your approach, we need to change the pad control and then call
> mxc_iomux_v3_setup_multiple_pads() separately. It's making extra-step in
> the process.
> Also, such a specific treatment for configuring theses GPIOs means for
> me more errors/bugs possible.
I suggest to just use one of the two possibilies for now (I don't have a
strong preference here).  Hopefully Lothar's patch that makes the pad
definitions use a bit field[1] is merged soon and then this can become:

	#define MX51_PAD_PCBID0	(MX51_PAD_GPIOXY | PAD_CTL_PUS_100K_UP)

which is pretty and easy.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.linux.kernel/1052626/focus=94463
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
