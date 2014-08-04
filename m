From: lisovy@gmail.com (Rostislav Lisovy)
Date: Mon, 04 Aug 2014 11:31:08 +0200
Subject: [PATCH] ARM: PCI: Use PCI_CLASS_* defines for PCI class
In-Reply-To: <53DE3629.2020706@kernel.org>
References: <1406904671-19197-1-git-send-email-lisovy@gmail.com>
 <53DE3629.2020706@kernel.org>
Message-ID: <1407144668.21386.8.camel@umadbro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-08-03 at 09:16 -0400, Sasha Levin wrote:
> > -     /* FIXME: add defines for class 0x68000 and 0x80103 */
> >       if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
> > -         dev->class == 0x68000 ||
> > -         dev->class == 0x80103) {
> > +         dev->class == (PCI_CLASS_BRIDGE_OTHER << 8) ||
> > +         dev->class == ((PCI_CLASS_SYSTEM_DMA << 8) | 0x03)) {
> >               for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> >                       dev->resource[i].start = 0;
> >                       dev->resource[i].end   = 0;
> > 
> 
> Care to explain how your new code is equivalent to the old one?

The header file include/linux/pci_ids.h defines
#define PCI_CLASS_BRIDGE_OTHER          0x0680
#define PCI_CLASS_SYSTEM_DMA            0x0801

((struct pci_dev*)dev)->class
corresponds to the 3 bytes Class code in the PCI Configuration space
header -- 1B Base class, 1B Sub-class, 1B Reg-level interface.

In that case
(PCI_CLASS_BRIDGE_OTHER << 8)
is equivalent to 0x68000 (imagine the leading zero)
and
((PCI_CLASS_SYSTEM_DMA << 8) | 0x03))
is equivalent to 0x80103.

Best regards;
Rostislav
