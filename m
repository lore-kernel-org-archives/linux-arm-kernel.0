From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Aug 2015 23:56:46 +0200
Subject: [PATCH 2/3] Display a DMA error message
In-Reply-To: <55CE612C.4010405@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <2099290.n6l88bWDgg@wuerfel> <55CE612C.4010405@arm.com>
Message-ID: <3034536.ALogCXmi9A@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 August 2015 16:44:12 Jeremy Linton wrote:
> On 08/14/2015 04:19 PM, Arnd Bergmann wrote:
> > On Wednesday 12 August 2015 16:51:29 Jeremy Linton wrote:
> >> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> >> index 2593def..82e396f 100644
> >> --- a/drivers/usb/host/ehci-platform.c
> >> +++ b/drivers/usb/host/ehci-platform.c
> >> @@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
> >>
> >>          err = dma_coerce_mask_and_coherent(&dev->dev,
> >>                  pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> >> -       if (err)
> >> +       if (err) {
> >> +               dev_err(&dev->dev, "Error: DMA setup failed\n");
> >>                  return err;
> >> +       }
> >
> > We should really stop doing this: the platform should provide the
> > correct dma mask when creating the device, instead of setting a
> > bogus pdata field. Do not duplicate this bug for ACPI.
> 
> 
> I'm not sure I understand, I'm not changing the mask anywhere, all I'm 
> doing is printing a message if the mask cannot be set.

The problem is that dma_coerce_mask_and_coherent() is not a proper
interface for a driver to use, it's an annotation that tells us
that the driver is trying to do something horrible by overriding
the dma mask that was set by the platform.

> AKA if CCA is missing or set to 0 then, this line is triggered because 
> the dma_coerce_mask_and_coherent() routine returns with a failure 
> indicating there aren't any DMA ops to set a mask on. Right now what 
> happens is the device detection displays that there is an EHCI 
> controller then silently disappears with telling the user why it didn't 
> configure.

Adding a warning is fine, but the text is not right here (the driver is
not setting up the dma mask, but trying to override the one that has been
set up by the platform), and the solution should really be to not
call dma_coerce_mask_and_coherent() at all for ACPI. The main reason
that we have not removed this call here yet is that there is still a
MIPS platform that relies on it. We should probably remove it for DT
already and only do it if platform data was provided, but that requires
careful testing.

	Arnd
