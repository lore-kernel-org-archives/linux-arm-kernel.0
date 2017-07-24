From: rafael@kernel.org (Rafael J. Wysocki)
Date: Mon, 24 Jul 2017 20:42:15 +0200
Subject: [PATCH 3/4] ACPI: Introduce DMA ranges parsing
In-Reply-To: <20170724104048.GD13145@red-moon>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <20170720144517.32529-4-lorenzo.pieralisi@arm.com>
 <37547189.Yunjf1Ri5r@aspire.rjw.lan>
 <20170724104048.GD13145@red-moon>
Message-ID: <CAJZ5v0h_ySMbtGfs5_E+PCJko+3_aDo=1joDaA1_2wCT5tZe=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 12:40 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Sat, Jul 22, 2017 at 12:15:42AM +0200, Rafael J. Wysocki wrote:
>

[cut]

>
>> > +           return -EINVAL;
>> > +   }
>> > +
>> > +   ret = acpi_dev_get_dma_resources(adev, &list);
>> > +   if (ret > 0) {
>> > +           list_for_each_entry(rentry, &list, node) {
>> > +                   if (dma_offset && rentry->offset != dma_offset) {
>> > +                           ret = -EINVAL;
>> > +                           pr_warn("Can't handle multiple windows with different offsets\n");
>> > +                           goto out;
>> > +                   }
>> > +                   dma_offset = rentry->offset;
>> > +
>> > +                   /* Take lower and upper limits */
>> > +                   if (rentry->res->start < dma_start)
>> > +                           dma_start = rentry->res->start;
>> > +                   if (rentry->res->end > dma_end)
>> > +                           dma_end = rentry->res->end;
>> > +           }
>> > +
>> > +           if (dma_start >= dma_end) {
>> > +                   ret = -EINVAL;
>> > +                   pr_warn("Invalid DMA regions configuration\n");
>>
>> dev_warn()?
>>
>> And why _warn() and not _info()?
>
> Mmm..ok for the dev_ prefix - basically this would be a FW_BUG (I think
> this specific error condition is overkill TBH, the ACPI resource
> validation code should catch it before we even get here) not sure
> about downgrading it to _info() though, I would leave it at this
> loglevel - in particular in the offset check above:
>
>         if (dma_offset && rentry->offset != dma_offset) {
>                 ret = -EINVAL;
>                 pr_warn("Can't handle multiple windows with different offsets\n");
>                 goto out;
>         }

Well, so the "why" question above still has no answer ...
