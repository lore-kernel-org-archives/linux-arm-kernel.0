From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 05 Nov 2013 10:45:59 +0000
Subject: [PATCH 2/3] virtio: mmio: fix signature checking for BE guests
In-Reply-To: <87a9hja5aw.fsf@rustcorp.com.au>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <1381502171-8187-3-git-send-email-marc.zyngier@arm.com>
 <1381740385.3247.6.camel@hornet> <87li1wb4k4.fsf@rustcorp.com.au>
 <87a9hja5aw.fsf@rustcorp.com.au>
Message-ID: <1383648359.11540.1.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-05 at 03:36 +0000, Rusty Russell wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> > Pawel Moll <pawel.moll@arm.com> writes:
> >> On Fri, 2013-10-11 at 15:36 +0100, Marc Zyngier wrote:
> >>> As virtio-mmio config registers are specified to be little-endian,
> >>> using readl() to read the magic value and then memcmp() to check it
> >>> fails on BE (as readl() has an implicit swab).
> >>> 
> >>> Fix it by encoding the magic value as an integer instead of a string.
> >>> 
> >>> Cc: Rusty Russell <rusty@rustcorp.com.au>
> >>> Cc: Michael S. Tsirkin <mst@redhat.com>
> >>> Cc: Pawel Moll <pawel.moll@arm.com>
> >>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>> ---
> >>>  drivers/virtio/virtio_mmio.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>> 
> >>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> >>> index 1ba0d68..57f24fd 100644
> >>> --- a/drivers/virtio/virtio_mmio.c
> >>> +++ b/drivers/virtio/virtio_mmio.c
> >>> @@ -470,7 +470,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
> >>>  
> >>>  	/* Check magic value */
> >>>  	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
> >>> -	if (memcmp(&magic, "virt", 4) != 0) {
> >>> +	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
> >>>  		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> >>>  		return -ENODEV;
> >>>  	}
> >>
> >> The new spec will clarify this:
> >>
> >> * 0x000 | R | MagicValue
> >>   Magic value. Must be 0x74726976 (a Little Endian equivalent
> >>   of a "virt" string).
> >>
> >> ... but I like the 'v'i'r't' characters still being there :-)
> >>
> >> Acked-by: Pawel Moll <pawel.moll@arm.com>
> >
> > Applied, thanks.
> 
> OK, I *said* applied, but left it in my pending queue.
> 
> Pawel, do you want to open this can of worms?  If so, I'l merge this
> now.

This particular can is empty - all worms already escaped :-)

It's a bugfix, not changing anything for the existing hosts. So - yes
please, do merge this one.

Thanks

Pawe?
