From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Sep 2014 10:28:47 +0100
Subject: [PATCH 7/9] dmaengine: Move slave caps to dma_device
In-Reply-To: <1411808085-27792-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411808085-27792-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140927092846.GA5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 10:54:43AM +0200, Maxime Ripard wrote:
> The previous code was relying on the fact that the slave_caps were to be
> defined on a per channel basis.
> 
> However, this proved to be a bit overkill, since every driver filling these so
> far were hardcoding it, disregarding which channel was actually given.
> 
> Add these capabilities to the dma_device structure, so that drivers can just
> provide them at probe time, and be done with it.

This is also buggy for the same reason as patch 6.

The only way to do this is to either have a flag day, fixing all drivers
at once (which isn't going to happen) or leave the caps code as-is, and
provide a library function which drivers can hook into the caps callback
which retrieves the information from dma_device.

That way, DMA engine drivers which are using the new method can just
install the new function, and those which haven't been updated with
capabilities can carry on as they are, and are detectable to drivers.

What would be acceptable is to have the DMA engine registration function
spot the lack of DMA caps function and print a warning at boot to
encourage people to add it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
