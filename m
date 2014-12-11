From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Dec 2014 20:52:29 +0000
Subject: READ THIS: Modern driver coding practices
Message-ID: <20141211205229.GU11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today, ARM is a fully fledged architecture which supports many of the
mainstream features such as highmem.  Highmem gets used if you have
more than about 600 to 800MB of memory, which in todays modern ARM
platforms, is most of them.

What this means is that drivers should be appropriately coded to take
account of highmem buffers being passed to the driver.

What prompted this email is network drivers.  This is especially true
of network device drivers, especially when they support the NETIF_F_SG
(scatter-gather) feature.

This evening, I have come across two netdev drivers, and there is a
third known about, which implement the scatter-gather and TSO features,
but do this:

	address = page_address(frag->page.p) + frag->page_offset;

	dma_map_single(dev, address, ...);

This is buggy: frag->page.p may very well be a highmem page.  When a
highmem page is used here, page_address() will be NULL, which will
then be passed into dma_map_single().

With the asm-generic implementation of dma_map_single(), we will
attempt to convert the address (which is now a NULL pointer) back
to a struct page pointer and offset.  The result on Dove is either a
silent kernel lockup, or a kernel oops - but depending on the
virt-to-phys offset, this can end up hitting almost any address in
the system - and if it is successfully converted back to a physical
address, we could end up /silently/ invalidating the cache for
unintended addresses.

Please ensure that you appropriately consider highmem issues in your
driver if the subsystem for your driver can pass you highmem pages.
Moreover, please check whether the driver you are working on needs
to take account of highmem, and check that it appropriately does.

And most importantly, don't strip out highmem support "to make the
driver more simple" - that's what has happened to one of the drivers
which used to work fine but now oopses because of this for me.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
