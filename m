From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Mar 2010 10:16:11 +0000
Subject: DMA using data buffer vmapped in kernel space
In-Reply-To: <20100309.012935.98310472.davem@davemloft.net>
References: <20100306193127.GA13262@n2100.arm.linux.org.uk>
	<10d816431003082345j5438d8cdi8ad72c4fa296b684@mail.gmail.com>
	<20100309091403.GB5691@n2100.arm.linux.org.uk>
	<20100309.012935.98310472.davem@davemloft.net>
Message-ID: <20100309101611.GC5691@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 01:29:35AM -0800, David Miller wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Date: Tue, 9 Mar 2010 09:14:03 +0000
> 
> > What you could do is prepare a patch to allow the firmware support to
> > export a scatterlist via the struct firmware, and then use that with
> > dma_map_sg().  Let's hope that the SPI interfaces support scatterlists.
> 
> It's so common to want a scatterlist from a vmalloc/vmap area
> that a generic common helper is probably the best.
> 
> Just iterate over the vmalloc/vmap area using vmalloc_to_page()
> to fill in the SG entries.

It looks like the firmware interface may return a pointer to either the
kernel binary itself for built-in firmware, or to a set of pages which
have been vmap'd.  In the former case, vmalloc_to_page() will fail.
