From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 10:47:40 -0800
Subject: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
In-Reply-To: <20091117222409.GH29266@atomide.com>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
	<20091116133654.14128.175.stgit@localhost.localdomain>
	<20091116140830.GA31522@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0911171036430.27682@utopia.booyaka.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FA689E6A@dbde02.ent.ti.com>
	<20091117222409.GH29266@atomide.com>
Message-ID: <20091118184740.GQ29266@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091117 14:24]:
> * Pandita, Vikram <vikram.pandita@ti.com> [091117 09:50]:
> > Paul
> > 
> > >-----Original Message-----
> > >From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Paul
> > >Walmsley
> > >Sent: Tuesday, November 17, 2009 11:39 AM
> > >To: Russell King - ARM Linux
> > >Cc: linux-arm-kernel at lists.infradead.org; Juha Lepp?nen; linux-omap at vger.kernel.org
> > >Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
> > <snip>
> > >
> > >+/**
> > >+ * omap_test_timeout - busy-loop, testing a condition
> > >+ * @cond: condition to test until it evaluates to true
> > >+ * @timeout: maximum number of microseconds in the timeout
> > >+ * @index: loop index (integer)
> > >+ *
> > >+ * Loop waiting for @cond to become true or until at least @timeout
> > >+ * microseconds have passed.  To use, define some integer @index in the
> > >+ * calling code.  After running, if @index == @timeout, then the loop has
> > >+ * timed out.
> > >+ */
> > >+#define omap_test_timeout(cond, timeout, index)			\
> > >+({								\
> > >+	for (index = 0; index < timeout; index++) {		\
> > >+		if (cond)					\
> > >+			break;					\
> > >+		udelay(1);					\
> > >+	}							\
> > >+})
> > >+
> > 
> > There is a similar kind of function implemented in USB host, that returns -ETIMEDOUT
> > Which makes more sense for failure case.
> > 
> > Maybe such a generic function for all omaps is needed.
> > 
> > Refer:
> > drivers/usb/host/ehci-hcd.c
> > static int handshake (struct ehci_hcd *ehci, void __iomem *ptr,
> >                       u32 mask, u32 done, int usec)
> > {
> >         u32     result;
> > 
> >         do {
> >                 result = ehci_readl(ehci, ptr);
> >                 if (result == ~(u32)0)          /* card removed */
> >                         return -ENODEV;
> >                 result &= mask;
> >                 if (result == done)
> >                         return 0;
> >                 udelay (1);
> >                 usec--;
> >         } while (usec > 0);
> >         return -ETIMEDOUT;
> > }
> > 
> > 
> > > #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
> 
> Well we need to stick to minimal changes if we plan to send this in as a fix.
> Anything more complex we should do the next merge window.

To me it sounds like this can wait until the merge window,
so not adding to omap-fixes for now.

Regards,

Tony
