From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 04 Oct 2011 10:16:00 +1030
Subject: [PATCH] virtio: Add platform bus driver for memory mapped virtio
	device
In-Reply-To: <1317217663-32647-1-git-send-email-pawel.moll@arm.com>
References: <1317217663-32647-1-git-send-email-pawel.moll@arm.com>
Message-ID: <878vp1iqpz.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Sep 2011 14:47:43 +0100, Pawel Moll <pawel.moll@arm.com> wrote:
> This patch, based on virtio PCI driver, adds support for memory
> mapped (platform) virtio device. This should allow environments
> like qemu to use virtio-based block & network devices even on
> platforms without PCI support.
> 
> One can define and register a platform device which resources
> will describe memory mapped control registers and "mailbox"
> interrupt. Such device can be also instantiated using the Device
> Tree node with compatible property equal "virtio,mmio".

Hi Pawel...

> +/* The alignment to use between consumer and producer parts of vring.
> + * Currently hardcoded to page size. */
> +#define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE

Really?  Shouldn't that just be 4k?  I haven't seen the qemu side of
this, but it seems weird to depend on the kernel's idea of page size...

Note that the seabios/coreboot hackers wanted a smaller ring alignment
so they didn't have to waste two precious pages per device.  You might
want to consider making this an option in the header (perhaps express
it as log2, eg. 12 rather than 4096).


> +	/* TODO: Write requested queue size to VIRTIO_MMIO_QUEUE_NUM */
> +
> +	/* Check if queue is either not available or already active. */
> +	num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> +	if (!num || readl(vm_dev->base + VIRTIO_MMIO_QUEUE_PFN)) {

Please fix this now, like so:

        /* Queue shouldn't already be set up. */        
        if (readl(vm_dev->base + VIRTIO_MMIO_QUEUE_PFN))
                ...

        /* Try for a big queue, drop down to a two-page queue. */
        num = VIRTIO_MMIO_MAX_RING;
        for (;;) {
                size = PAGE_ALIGN(vring_size(num, VIRTIO_MMIO_VRING_ALIGN));
                info->queue = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
                if (info->queue)
                        break;

                /* Already smallest possible allocation? */
                if (size == VIRTIO_MMIO_VRING_ALIGN*2) {
                        err = -ENOMEM;
                        goto error_kmalloc;
                }
                num /= 2;
        }

Thanks,
Rusty.
