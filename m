From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 19:31:50 +0000
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140127193149.GV15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 09:52:57AM -0800, Laura Abbott wrote:
> The dma_mask for a device structure is a pointer. This pointer
> needs to be set up before the dma mask can actually be set. Most
> frameworks in the kernel take care of setting this up properly but
> platform devices that don't follow a regular bus structure may not
> ever have this set. As a result, checks such as dma_capable will
> always return false on a raw platform device and dma_set_mask will
> always return -EIO. Fix this by adding a dma_mask in the
> platform_device archdata and setting it to be the dma_mask. Devices
> used in other frameworks can change this as needed.

You shouldn't need to do this.  I went through a lot of the drivers we
currently have, fixing them up in various manners.  The basic rules
for this stuff are:

- It is the responsibility of the code creating the device to set a
  reasonable default for the dma mask according to the bus and whether
  DMA is supportable.

- It is the responsibility of the driver _always_ to make a call to
  dma_set_mask() and/or dma_set_coherent_mask() according to the
  driver's needs if the driver is going to be using DMA.

As a work-around for the buggy situation we have in the kernel with DT,
various buggy workarounds have been incorporated into drivers which
involve writing directly to the DMA masks, and other such games.  None
of that is necessary when the dma_coerce_*() functions are used - but
these are a stop-gap until the DT code gets fixed.

The real answer here is to make DT conform to the first point above
and not add yet another different hack to the kernel.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
