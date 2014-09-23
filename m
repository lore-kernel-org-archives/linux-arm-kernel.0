From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 23 Sep 2014 14:58:28 +0100
Subject: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
In-Reply-To: <CAL_JsqK3yH-uf++haBovWdX6er1PtzeiZ-2-yT1TRfYPxAjFow@mail.gmail.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <20140922093228.GA20256@rric.localhost>
 <20140922114317.GN1994@e106497-lin.cambridge.arm.com>
 <8687285.EH4RPBeOB5@wuerfel>
 <CAL_JsqK3yH-uf++haBovWdX6er1PtzeiZ-2-yT1TRfYPxAjFow@mail.gmail.com>
Message-ID: <20140923135828.GS1994@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 02:30:08PM +0100, Rob Herring wrote:
> On Tue, Sep 23, 2014 at 2:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 22 September 2014 12:43:17 Liviu Dudau wrote:
> >> >
> >> > From e798af4fc2f664d1aff7e863489b8298f90e716e Mon Sep 17 00:00:00 2001
> >> > From: Robert Richter <rrichter@cavium.com>
> >> > Date: Mon, 22 Sep 2014 10:46:01 +0200
> >> > Subject: [PATCH] OF: PCI: Fix creation of mem-mapped pci host bridges
> >> >
> >> > The pci host bridge was not created if io_base was not set when
> >> > calling of_pci_get_host_bridge_resources(). This is esp. the case for
> >> > mem-mapped io (IORESOURCE_MEM). This patch fixes this. Function
> >> > parameter io_base is optional now.
> >>
> >> I think the message is misleading. What you want to do is make io_base
> >> optional for the case where the PCI host bridge only expects to have only
> >> IORESOURCE_MEM ranges and doesn't care about IORESOURCE_IO ones.
> >>
> >> As I'm going to touch this area again to address a comment from Bjorn,
> >> do you mind if I roll this patch into mine with your Signed-off-by and
> >> the mention that you have made io_base optional?
> >
> > I think the best way to deal with this is to move the check for
> > io_base down into the place where it is used: As long as the DT only
> > specifies IORESOURCE_MEM windows, we don't need to look at io_base,
> > but if the host controller driver does not support IORESOURCE_IO
> > while the DT specifies it, I guess it would be nice to return an
> > error.
> 
> The DT may specify it, but the h/w could be broken in some way so the
> host driver chooses to ignore it. I don't think we should force the
> host driver to provide a pointer in that case. Also, would we want it
> added to the resource list if it is not going to be used?

This is only for scanning the DT ranges. If the hardware is broken and
the driver knows about that then it can filter out the I/O ranges
before it passes them on to pci_scan_root_bus() or pci_create_root_bus().

Lets not complicate this function any further. If you get an I/O range
it should be expected to also pass an io_base pointer to store the
CPU address of the range, otherwise it will get lost in the conversion
to an IORESOURCE_IO resource. You want later to discard the resource
and forget the CPU address, then don't use it!

Best regards,
Liviu

> 
> Rob
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
