From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 21:27:59 +0100
Subject: [PATCH] usb: musb: USB_TI_CPPI41_DMA requires dmaengine support
In-Reply-To: <CADYTM3baomio7+nFizOKFXMav7guow+=GsVaGExBWxQyn9t=2w@mail.gmail.com>
References: <4370741.70D0kgBgnp@wuerfel>
 <CADYTM3baomio7+nFizOKFXMav7guow+=GsVaGExBWxQyn9t=2w@mail.gmail.com>
Message-ID: <3958456.qUtBLJFy2S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 12:29:27 Bin Liu wrote:
> > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > index 1f2037bbeb0d..45c83baf675d 100644
> > --- a/drivers/usb/musb/Kconfig
> > +++ b/drivers/usb/musb/Kconfig
> > @@ -159,7 +159,7 @@ config USB_TI_CPPI_DMA
> >
> >  config USB_TI_CPPI41_DMA
> >         bool 'TI CPPI 4.1 (AM335x)'
> > -       depends on ARCH_OMAP
> > +       depends on ARCH_OMAP && DMADEVICES
> >         select TI_CPPI41
> 
> I am not sure what the generic policy is, but instead of hiding
> USB_TI_CPPI41_DMA if DMADEVICES is disabled, I'd like to enable
> DMADEVICES if USB_TI_CPPI41_DMA is enabled, from user experience
> perspective.

General policy is that you should not 'select' a symbol that is
also user-visible, as that tends to cause dependency loops and
other problems when something is enabled without the user being
aware of that.

Ideally we should remove the 'select TI_CPPI41' here as well, but
what we could do instead is to make that a silent symbol and remove
the prompt so it always gets enabled implicitly when USB_TI_CPPI41_DMA
and DMADEVICES are both enabled.

	Arnd
