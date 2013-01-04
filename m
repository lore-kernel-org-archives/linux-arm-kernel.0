From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Jan 2013 17:10:33 +0100
Subject: [PATCH 2/2] dma: mv_xor: do not sync the DMA buffer after being
 deallocated
In-Reply-To: <1356636228-23096-2-git-send-email-lkundrak@v3.sk>
References: <1356636228-23096-1-git-send-email-lkundrak@v3.sk>
 <1356636228-23096-2-git-send-email-lkundrak@v3.sk>
Message-ID: <20130104171033.4a244c3d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lubomir Rintel,

On Thu, 27 Dec 2012 20:23:48 +0100, Lubomir Rintel wrote:

>  	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
>  				MV_XOR_TEST_SIZE, DMA_FROM_DEVICE);
> +	dma_unmap_single(dma_chan->device->dev, dest_dma, MV_XOR_TEST_SIZE,
> +			 DMA_FROM_DEVICE);

I would assume that dma_unmap_single() implies a
dma_sync_single_for_cpu() since you're unmapping the DMA buffer. So if
you use dma_unmap_single(), I think you can remove the call to
dma_sync_single_for_cpu().


>  	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
>  				PAGE_SIZE, DMA_FROM_DEVICE);
> +	dma_unmap_page(dma_chan->device->dev, dest_dma, PAGE_SIZE,
> +		       DMA_FROM_DEVICE);

Ditto.

Also, the mv_xor_memcpy_self_test() function not only dma_map_single()
the destination buffer, but also the source buffer. So presumably, the
source buffer should also be dma_unmap_single()'d.

And for the mv_xor_xor_self_test() function, multiple source buffers
are dma_map_page()'d, so they should all be dma_unmap_page()'d I guess,
not only the destination buffer.

Does that make sense?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
