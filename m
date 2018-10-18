From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 18 Oct 2018 14:35:13 +0100
Subject: DMA configuration in non-DT probed driver
In-Reply-To: <18dfef35-54f6-0e45-ff8e-f0c3e70b8580@i2se.com>
References: <18dfef35-54f6-0e45-ff8e-f0c3e70b8580@i2se.com>
Message-ID: <839aa8cf-aabe-c087-4d35-c1a96bbf3f13@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/18 12:14, Stefan Wahren wrote:
> Hi,
> 
> i'm currently working on the VCHIQ driver ( drivers
> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers?h=next-20181018>/staging
> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging?h=next-20181018>/vc04_services
> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/vc04_services?h=next-20181018>/interface
> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/vc04_services/interface?h=next-20181018>/vchiq_arm
> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/vc04_services/interface/vchiq_arm?h=next-20181018>
> ) in staging which is only used by the Raspberry Pi. The driver should
> register at least 2 child devices (bcm2835-audio and bcm2835-camera)
> instead of model these via DT binding. The reason is the VCHIQ driver is
> a communication interface to the Video Core 4 GPU firmware, so a DT
> binding wont be appropriate.
> 
> Since the DT probing usually handle the DMA configuration, i need some
> kind of equivalent for non-DT probing. Looking at the kernel, i found in
> drivers/gpu/drm/xen/xen_drm_front.c in combination of
> of_dma_configure(dev, NULL, true) and manual setting of the coherent dma
> mask.

Yeah, I've noticed that that snuck in at some point, and frankly I think 
it's a disgusting hack, but don't have any better solution for that 
particular case - conceptually, it would at least be a bit less hacky to 
call arch_setup_dma_ops() directly there, but I *really* don't want to 
start exporting that to modules :(

> So here are my questions:
> Is this an acceptable way to setup dma ops and masks or is there a
> better solution?
> Which driver should do the dma configuration the parent (VCHIQ) or the
> child device (bcm2835-audio, ...)?

I'm a little puzzled at what the real topology is there, since AFAICS 
bcm2835-audio does have an of_match_table, relies on DT properties, and 
(at least downstream) has a node under /soc which should get handled 
like any other platform device.

More generally, though, I maintain that DMA configuration is logically 
the responsibility of whoever creates the struct device, i.e. usually 
the parent/bus driver. Whether DMA master devices are discrete 
peripheral blocks or just firmware functions running on some DSP (or 
indeed GPU), *somewhere* in the silicon there is a DMA master interface 
emitting transactions, and that interface (or at least one which is 
indistinguishable from it) should always be described by some DT node 
(e.g. for dynamically-discovered PCI devices it's the 'platform' side of 
the host bridge).

If you consider the VCHIQ node to represent "stuff the VC4 does" and 
don't want to go to a full-blown "devices owned by VC4" bus_type 
implementation similar to Host1x, then given that in practice you've got 
a pretty simple interconnect topology I reckon it's fair and 
sufficiently accurate for the VCHIQ driver to configure 
dynamically-created devices based on its own node, i.e. something like:

	child_dev = platform_device_alloc(...)
	of_dma_configure(&child_dev->dev, vchiq_dev->of_node, ...);
	platform_device_add(child_dev);

(the configuration wants to be done before anything which could trigger 
driver probing to avoid any possibility of awkward races)

You could *almost* just set child_dev's of_node and let 
platform_dma_configure() take care of the rest, but unfortunately I 
think that probably breaks driver matching.

Robin.
