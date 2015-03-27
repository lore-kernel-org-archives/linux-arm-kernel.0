From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Mar 2015 20:22:30 +0000
Subject: [PATCH v3 6/7] dmaengine: omap-dma: Remove mapping between
 virtual channels and requests
In-Reply-To: <1427459213-14611-7-git-send-email-peter.ujfalusi@ti.com>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
 <1427459213-14611-7-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150327202230.GA4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 02:26:52PM +0200, Peter Ujfalusi wrote:
> Do not direct map the virtual channels to sDMA request number. When the
> sDMA is behind of a crossbar this direct mapping can cause situations when
> certain channel can not be requested since the crossbar request number
> will no longer match with the sDMA request line.
> The direct mapping for virtual channels with HW request lines will make it
> harder to implement MEM_TO_MEM mode for the driver.

There's no point having 127 virtual DMA channels then... is there?
We might as well reduce the number down to a more reasonable set
rather than wasting memory.

> @@ -1049,7 +1050,6 @@ static int omap_dma_chan_init(struct omap_dmadev *od, int dma_sig)
>  		return -ENOMEM;
>  
>  	c->reg_map = od->reg_map;
> -	c->dma_sig = dma_sig;

That's the only user of dma_sig in this function.  Why not remove it from
the function prototype and its caller?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
