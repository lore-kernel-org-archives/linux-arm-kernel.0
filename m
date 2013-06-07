From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 18:06:15 +0200
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <Pine.LNX.4.64.1306071659290.11277@axis700.grange>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <201306071653.21668.arnd@arndb.de>
 <Pine.LNX.4.64.1306071659290.11277@axis700.grange>
Message-ID: <201306071806.16031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Guennadi Liakhovetski wrote:
> Isn't it a board property? In case of external devices, or an SoC property 
> in case of integrated DMA slave and controller? 

Correct.

> Let me try to explain. The 
> DMAC has to configure the controller to "link" a specific DMA channel to a 
> slave request line. E.g. to link an internal channel #0 to SDHI0 tx. To do 
> this it has to write specific "magic" values in certain DMAC registers. 
> Those values aren't known to the DMAC driver, they are a property of the 
> SoC. Let's say, the SoC has 3 DMAC instances, each of them can serve any 
> of compatible DMA slaves, including SDHI0, on each of their 6 channels. To 
> configure a channel on a DMAC instance for SDHI0 tx you have to write to 
> that channel's config register a certain value, that cannot be calculated. 

Right. Or multiple values.

> Those values are only known to the SoC code, so, they are passed as 
> platform parameters to the DMAC driver. Now, when SDHI0 asks DMAC to set 
> up a DMA channel for its tx, the DMAC driver has to find that value in its 
> platform data. In most cases you could use the client address (e.g. FIFO 
> register) and direction to find that value. But, I think, that might not 
> always be enough. So, we use unique enum values to find those values in 
> DMAC platform data. The SDHI driver gets that enum value in its platform 
> data, passes it to the DMAC driver as a slave ID, and the DMAC driver uses 
> it to find the value(s), it needs to set up its DMA channel. Do you see a 
> better way to do the same?

Ah, so you have multiple values, too, and you just abstract them by using
an enum to index an array of platform_data in the dma engine.

This obviously works as well, and lets you get away with a single 32-bit
enum to use as the slave-id. However, I think slave drivers should not
be written with the assumption that all dma-engine drivers do this.
In particular, you seem to assume that the argument to the filter function
is not a pointer but this enum.

It also gets more complicated with the DT binding, since that should
reflect the hardware settings, i.e. not an arbitrarily defined enum
but the data that you have in your array. To keep the DT and platform_data
cases similar, I would suggest you actually remove the array listing
the per-slave data, and move that data instead as an opaque pointer into
the platform data. You can take a look at drivers/mmc/host/mmci.c for
an example of a driver that does this and that is portable across
multiple DMA engine drivers.

Essentially we pass the dma_filter function and dma_param struct pointers
to dma_request_channel directly from the platform_data, without trying
to interpret them. In case of stedma40, the dma_param contains a complex
data structure, while for others it may contain a single integer.

If you do the same, you would essentially pass the mid_rid and chcr values
of your sh_dmae_slave_config as in the pointer that gets passed from
the platform_data down to the filter function, get rid of the slave_id
number and pass the addr value through slave_config.

	Arnd
