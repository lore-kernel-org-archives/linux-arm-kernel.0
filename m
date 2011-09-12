From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 12 Sep 2011 11:01:14 +0930
Subject: [RFC 1/2] virtio: Add AMBA bus driver for virtio device
In-Reply-To: <1314966257-7503-2-git-send-email-pawel.moll@arm.com>
References: <1314966257-7503-1-git-send-email-pawel.moll@arm.com>
	<1314966257-7503-2-git-send-email-pawel.moll@arm.com>
Message-ID: <877h5e5yxp.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  2 Sep 2011 13:24:16 +0100, Pawel Moll <pawel.moll@arm.com> wrote:
> This patch, based on virtio PCI driver, adds support for virtio
> AMBA device. This should allow environments like qemu to use
> virtio-based block & network devices.

Cool work!  I like the concept, but a few implementation notes below:

> + * offset width name          description
> + * ------ ----- ------------- -----------------
> + *
> + *  0x000   32  HostFeatures  Features supported by the host
> + *  0x004   32  GuestFeatures Features activated by the guest

You need to make these at least 64 bits.  Lguest makes them variable
width, in fact.

> + *  0x008   32  QueuePFN      PFN for the currently selected queue
> + *  0x00c   32  QueueNum      Queue size for the currently selected queue

You should, I believe, seriously consider allowing the guest to set the
queue size, rather than the host (perhaps the host could suggest one,
but the guest should be able to override it).

Anthony or Michael might suggest other changes, since they are most
familiar with virtio_pci limitations...

Cheers,
Rusty.
