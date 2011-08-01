From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2011 21:07:43 +0100
Subject: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
	platform_device from omap_device
In-Reply-To: <20110801185009.GA5217@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-9-git-send-email-khilman@ti.com>
	<20110730120332.GA15539@n2100.arm.linux.org.uk>
	<20110731025807.GA24334@ponder.secretlab.ca>
	<20110731150540.GA3019@n2100.arm.linux.org.uk>
	<871ux5nnop.fsf@ti.com>
	<CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
	<20110801185009.GA5217@legolas.emea.dhcp.ti.com>
Message-ID: <20110801200743.GA21535@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 09:50:09PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Aug 01, 2011 at 04:44:20PM +0100, Grant Likely wrote:
> > On Mon, Aug 1, 2011 at 4:42 PM, Kevin Hilman <khilman@ti.com> wrote:
> > > diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> > > index 9f390ce..bb777cd 100644
> > > --- a/arch/arm/include/asm/device.h
> > > +++ b/arch/arm/include/asm/device.h
> > > @@ -13,6 +13,7 @@ struct dev_archdata {
> > > ?};
> > >
> > > ?struct pdev_archdata {
> > > + ? ? ? void *p;
> > > ?};
> > 
> > struct omap_device *p;
> > 
> > Otherwise it is just asking for type safety problems.
> 
> considering that struct omap_device isn't ARM-wide, is it really wise to
> to do that ? I guess a void * will do better here.

Help the typechecker do its job.  As we have only one (at the moment...)
And make it:

+struct omap_device;

 struct pdev_archdata {
+#ifdef CONFIG_ARCH_OMAP
+	struct omap_device *omap;
+#endif
 };

for bonus points, so we only get the additional pointer for OMAP.
