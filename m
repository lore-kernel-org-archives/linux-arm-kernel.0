From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 29 Nov 2016 12:20:14 -0600
Subject: [PATCH] PCI: Add information about describing PCI in ACPI
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A2949AF@SHSMSX101.ccr.corp.intel.com>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <1AE640813FDE7649BE1B193DEA596E886A2949AF@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20161129182014.GC17112@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 03:23:35AM +0000, Zheng, Lv wrote:
> Hi, Bjorn
> 
> Thanks for the documentation.
> It really helps!
> 
> However I have a question below.
> 
> > From: linux-acpi-owner at vger.kernel.org [mailto:linux-acpi-owner at vger.kernel.org] On Behalf Of Bjorn
> > Helgaas
> > Subject: [PATCH] PCI: Add information about describing PCI in ACPI
> > 
> > Add a writeup about how PCI host bridges should be described in ACPI
> > using PNP0A03/PNP0A08 devices, PNP0C02 devices, and the MCFG table.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/PCI/00-INDEX      |    2 +
> >  Documentation/PCI/acpi-info.txt |  136 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 138 insertions(+)
> >  create mode 100644 Documentation/PCI/acpi-info.txt
> > 
> > diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
> > index 147231f..0780280 100644
> > --- a/Documentation/PCI/00-INDEX
> > +++ b/Documentation/PCI/00-INDEX
> > @@ -1,5 +1,7 @@
> >  00-INDEX
> >  	- this file
> > +acpi-info.txt
> > +	- info on how PCI host bridges are represented in ACPI
> >  MSI-HOWTO.txt
> >  	- the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
> >  PCIEBUS-HOWTO.txt
> > diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.txt
> > new file mode 100644
> > index 0000000..ccbcfda
> > --- /dev/null
> > +++ b/Documentation/PCI/acpi-info.txt
> > @@ -0,0 +1,136 @@
> > +	    ACPI considerations for PCI host bridges
> > +
> > +The basic requirement is that the ACPI namespace should describe
> > +*everything* that consumes address space unless there's another
> > +standard way for the OS to find it [1, 2]. ?For example, windows that
> > +are forwarded to PCI by a PCI host bridge should be described via ACPI
> > +devices, since the OS can't locate the host bridge by itself. ?PCI
> > +devices *below* the host bridge do not need to be described via ACPI,
> > +because the resources they consume are inside the host bridge windows,
> > +and the OS can discover them via the standard PCI enumeration
> > +mechanism (using config accesses to read and size the BARs).
> > +
> > +This ACPI resource description is done via _CRS methods of devices in
> > +the ACPI namespace [2]. ? _CRS methods are like generalized PCI BARs:
> > +the OS can read _CRS and figure out what resource is being consumed
> > +even if it doesn't have a driver for the device [3]. ?That's important
> > +because it means an old OS can work correctly even on a system with
> > +new devices unknown to the OS. ?The new devices won't do anything, but
> > +the OS can at least make sure no resources conflict with them.
> > +
> > +Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
> > +reserving address space!  The static tables are for things the OS
> > +needs to know early in boot, before it can parse the ACPI namespace.
> > +If a new table is defined, an old OS needs to operate correctly even
> > +though it ignores the table.  _CRS allows that because it is generic
> > +and understood by the old OS; a static table does not.
> 
> The entire document doesn't talk about the details of _CBA.
> There is only one line below mentioned _CBA as an example.

Yes, that's a good point.  I'll add some more details about MCFG
and _CBA.

Bjorn
