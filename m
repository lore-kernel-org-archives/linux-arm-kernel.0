From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 21 Sep 2016 14:18:45 -0500
Subject: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
In-Reply-To: <CADaLNDn4CeoB+sELQ5yQDQUS158raEu5QohPH2PsVtuGpfGKHg@mail.gmail.com>
References: <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com>
 <20160920133327.GB13855@localhost>
 <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
 <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost> <20160921140549.GA11968@red-moon>
 <20160921180457.GB20006@localhost>
 <CADaLNDn4CeoB+sELQ5yQDQUS158raEu5QohPH2PsVtuGpfGKHg@mail.gmail.com>
Message-ID: <20160921191845.GD20006@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 11:58:22AM -0700, Duc Dang wrote:
> On Wed, Sep 21, 2016 at 11:04 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Sep 21, 2016 at 03:05:49PM +0100, Lorenzo Pieralisi wrote:

> > The existing x86 practice is to use PNP0C02 devices for this purpose,
> > and I think we should just follow that practice.
> >
> > ...
> >
> > My point is that the hard-coding should not be buried in a driver
> > where it's invisible to the rest of the kernel.  If we hard-code it in
> > a quirk that adds _CRS entries, then the kernel will work just like it
> > would if the firmware had been correct in the first place.  The
> > resource will appear in /sys/devices/pnp*/*/resources and /proc/iomem,
> > and if we ever used _SRS to assign or move ACPI devices, we would know
> > to avoid the bridge resource.
> 
> Are you suggesting to add code similar to functions in
> linux/drivers/pnp/quirks.c to declare/attach the additional resource
> that the host need to have when the resource is not in MCFG table?

Yes, but what I'm suggesting is actually a little stronger.  This has
nothing to do with whether a resource is in the MCFG table or not.

I'm suggesting ACPI firmware should always describe the resource.  If the
firmware is defective and doesn't describe it, we should add a quirk in
pnp/quirks.c to add a resource for it.

Bjorn
