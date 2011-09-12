From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 12 Sep 2011 17:45:56 +0100
Subject: [RFC 1/2] virtio: Add AMBA bus driver for virtio device
In-Reply-To: <877h5e5yxp.fsf@rustcorp.com.au>
References: <1314966257-7503-1-git-send-email-pawel.moll@arm.com>
	<1314966257-7503-2-git-send-email-pawel.moll@arm.com>
	<877h5e5yxp.fsf@rustcorp.com.au>
Message-ID: <1315845956.3297.7.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-09-12 at 11:01 +0930, Rusty Russell wrote:
> Cool work!  I like the concept, but a few implementation notes below:

Glad to hear that it makes any sense :-)

I'll post the RFC v2 in a second - it's a platform bus driver now, so
it's not ARM specific any more...

> > + * offset width name          description
> > + * ------ ----- ------------- -----------------
> > + *
> > + *  0x000   32  HostFeatures  Features supported by the host
> > + *  0x004   32  GuestFeatures Features activated by the guest
> 
> You need to make these at least 64 bits.  Lguest makes them variable
> width, in fact.

No problem, I've reserved 128 bits in the modified registers layout (see
RFC v2), I can even change it into "offset/value" interface, which would
give you variable width. One thing I don't get is how to access feature
bits > 31? The get_features() seems
to be limited to 32:

struct virtio_config_ops {
<...>
	u32 (*get_features)(struct virtio_device *vdev);
<...>
}

> > + *  0x008   32  QueuePFN      PFN for the currently selected queue
> > + *  0x00c   32  QueueNum      Queue size for the currently selected queue
> 
> You should, I believe, seriously consider allowing the guest to set the
> queue size, rather than the host (perhaps the host could suggest one,
> but the guest should be able to override it).

I guess the QueueNum could be simply a read/write register - guest can
read suggestion and override it writing it back. The same question
though - how can guest change it? (I mean some API?)

> Anthony or Michael might suggest other changes, since they are most
> familiar with virtio_pci limitations...

I've added them on the RFC v2 Cc as well - all feedback more then
welcome!

Cheers!

Pawe?
