From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 26 Jul 2017 02:27:08 +0200
Subject: [PATCH 3/4] ACPI: Introduce DMA ranges parsing
In-Reply-To: <20170725090615.GA17133@red-moon>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <CAJZ5v0h_ySMbtGfs5_E+PCJko+3_aDo=1joDaA1_2wCT5tZe=Q@mail.gmail.com>
 <20170725090615.GA17133@red-moon>
Message-ID: <3695178.yaaBKZ8vrz@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 25, 2017 10:06:15 AM Lorenzo Pieralisi wrote:
> On Mon, Jul 24, 2017 at 08:42:15PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 24, 2017 at 12:40 PM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Sat, Jul 22, 2017 at 12:15:42AM +0200, Rafael J. Wysocki wrote:
> > >
> > 
> > [cut]
> > 
> > >
> > >> > +           return -EINVAL;
> > >> > +   }
> > >> > +
> > >> > +   ret = acpi_dev_get_dma_resources(adev, &list);
> > >> > +   if (ret > 0) {
> > >> > +           list_for_each_entry(rentry, &list, node) {
> > >> > +                   if (dma_offset && rentry->offset != dma_offset) {
> > >> > +                           ret = -EINVAL;
> > >> > +                           pr_warn("Can't handle multiple windows with different offsets\n");
> > >> > +                           goto out;
> > >> > +                   }
> > >> > +                   dma_offset = rentry->offset;
> > >> > +
> > >> > +                   /* Take lower and upper limits */
> > >> > +                   if (rentry->res->start < dma_start)
> > >> > +                           dma_start = rentry->res->start;
> > >> > +                   if (rentry->res->end > dma_end)
> > >> > +                           dma_end = rentry->res->end;
> > >> > +           }
> > >> > +
> > >> > +           if (dma_start >= dma_end) {
> > >> > +                   ret = -EINVAL;
> > >> > +                   pr_warn("Invalid DMA regions configuration\n");
> > >>
> > >> dev_warn()?
> > >>
> > >> And why _warn() and not _info()?
> > >
> > > Mmm..ok for the dev_ prefix - basically this would be a FW_BUG (I think
> > > this specific error condition is overkill TBH, the ACPI resource
> > > validation code should catch it before we even get here) not sure
> > > about downgrading it to _info() though, I would leave it at this
> > > loglevel - in particular in the offset check above:
> > >
> > >         if (dma_offset && rentry->offset != dma_offset) {
> > >                 ret = -EINVAL;
> > >                 pr_warn("Can't handle multiple windows with different offsets\n");
> > >                 goto out;
> > >         }
> > 
> > Well, so the "why" question above still has no answer ...
> 
> It is a firmware misconfiguration, we end up dismissing firmware
> information and use the device with default/possibly misconfigured
> DMA windows (ie offset == 0) for that platform, that's the reason
> why I thought it would deserve a _warn rather than _info loglevel.

Well, _warn only makes it slightly more visible for people with somewhat
unusual logging configurations, but fair enough.

Thanks,
Rafael
