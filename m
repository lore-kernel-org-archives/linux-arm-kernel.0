From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 14 Aug 2012 07:55:42 +0200
Subject: [PATCH v3 05/10] resource: add PCI configuration space support
In-Reply-To: <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
Message-ID: <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 10:00:45PM -0700, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > This commit adds a new flag that allows marking resources as PCI
> > configuration space.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> > - new patch
> >
> >  include/linux/ioport.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 589e0e7..3314843 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -102,7 +102,7 @@ struct resource {
> >
> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> >  #define IORESOURCE_PCI_FIXED           (1<<4)  /* Do not move resource */
> > -
> > +#define IORESOURCE_PCI_CS              (1<<5)  /* PCI configuration space */
> 
> What is the purpose of this?  It seems that you are marking regions
> that we call MMCONFIG on x86, or ECAM-type regions in the language of
> the PCIe spec.  I see that you set it in several places, but I don't
> see anything that ever looks for it.  Do you have plans to use it in
> the future?  If it really does correspond to MMCONFIG/ECAM, we should
> handle those regions consistently across all architectures.

The purpose is ultimately to obtain the MMCONFIG/ECAM resources assigned
to a PCI host controller. I've used this in the of_pci_parse_ranges()
and in the static board setup code to mark ranges as such. Perhaps
IORESOURCE_ECAM or IORESOURCE_MMCONFIG might have been better names. I
also just noticed that I'm not using this anywhere, but the plan was to
eventually use it with platform_get_resource(). However that doesn't
seem to work either because the lower bits of the flags aren't use for
comparison in that function.

Any other ideas how that could be handled? Basically what I need is a
way to mark a resource as an MMCONFIG/ECAM range so that it can be used
to program the PCI host controller accordingly. I don't know how these
are assigned on x86. I was under the impression that the MMCONFIG/ECAM
space was accessed through a single single address/data register pair.

On Tegra 20 this region can be anywhere in the upper 1 GiB of the 4 GiB
address space, while on Tegra 30 it can be anywhere in the lower 1 GiB,
so they can be freely assigned.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120814/ab8cbdaa/attachment.sig>
