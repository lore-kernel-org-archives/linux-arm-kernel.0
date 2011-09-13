From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 13 Sep 2011 12:28:26 +0930
Subject: [RFC 1/2] virtio: Add AMBA bus driver for virtio device
In-Reply-To: <1315845956.3297.7.camel@hornet.cambridge.arm.com>
References: <1314966257-7503-1-git-send-email-pawel.moll@arm.com>
	<1314966257-7503-2-git-send-email-pawel.moll@arm.com>
	<877h5e5yxp.fsf@rustcorp.com.au>
	<1315845956.3297.7.camel@hornet.cambridge.arm.com>
Message-ID: <87hb4h408d.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Sep 2011 17:45:56 +0100, Pawel Moll <pawel.moll@arm.com> wrote:
> On Mon, 2011-09-12 at 11:01 +0930, Rusty Russell wrote:
> > You need to make these at least 64 bits.  Lguest makes them variable
> > width, in fact.
> 
> No problem, I've reserved 128 bits in the modified registers layout (see
> RFC v2), I can even change it into "offset/value" interface, which would
> give you variable width. One thing I don't get is how to access feature
> bits > 31? The get_features() seems
> to be limited to 32:
> 
> struct virtio_config_ops {
> <...>
> 	u32 (*get_features)(struct virtio_device *vdev);
> <...>
> }

There's a patch for that already :)

> > > + *  0x008   32  QueuePFN      PFN for the currently selected queue
> > > + *  0x00c   32  QueueNum      Queue size for the currently selected queue
> > 
> > You should, I believe, seriously consider allowing the guest to set the
> > queue size, rather than the host (perhaps the host could suggest one,
> > but the guest should be able to override it).
> 
> I guess the QueueNum could be simply a read/write register - guest can
> read suggestion and override it writing it back. The same question
> though - how can guest change it? (I mean some API?)

We can sort that out later... the Guest may try some ambitious large
allocation and fall back if it fails.

> > Anthony or Michael might suggest other changes, since they are most
> > familiar with virtio_pci limitations...
> 
> I've added them on the RFC v2 Cc as well - all feedback more then
> welcome!

Excellent...  of course, the virtualization list is down at the moment,
making this a bit more awkward.

Cheers,
Rusty.
