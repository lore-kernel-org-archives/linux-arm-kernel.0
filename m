From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 18 Mar 2012 22:12:00 +0000
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <201203182158.10957.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120318204421.759F23E07BF@localhost>
 <201203182158.10957.arnd@arndb.de>
Message-ID: <201203182212.00769.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 March 2012, Arnd Bergmann wrote:
> > 
> > Is dma_find_device() a new function?  How does it look up the dma
> > device?
> 
> Yes, it would be similar to the proposed function in Benoit's patch
> 

Well, actually we would not even need a new list with all the devices,
it can simply become

/* must be called with dma_list_mutex held */
static struct dma_device *dma_find_device(struct of_node *node)
{
	struct dma_device *device;
	
	list_for_each_entry(device, &dma_device_list, global_node) {
		if (device->dev.of_node == node)
			break;
	}
	return device;
}

Given that dma_device_list is most likely be a very short list, this will
be a fast operation.

	Arnd
