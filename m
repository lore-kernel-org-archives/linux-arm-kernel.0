From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 24 Jul 2014 03:36:34 +0000
Subject: [PATCH v5 0/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201407231428.01278.marex@denx.de>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
 <201407231428.01278.marex@denx.de>
Message-ID: <e5547e015bf6447e9b4fc18e82ddce74@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marek Vasut wrote:
> On Wednesday, July 23, 2014 at 10:24:41 AM, Yuan Yao wrote:
> > Changed in v5:
> > - add "*chan_dev = dma->chan_using->device->dev" for reduce the call time.
> 
> Did you check if the compiler generates different code ?
> 

Sorry, I didn't compare the assembly code. It's a subtle change. 
As you mentioned the "noodle" before.

Old:
dma_map_single(dma->chan_using->device->dev, ...);
dma_mapping_error(dma->chan_using->device->dev, ...);
dma_unmap_single(dma->chan_using->device->dev, ...);
	
New:
struct device *chan_dev = dma->chan_using->device->dev;
dma_map_single(chan_dev, ...);
dma_mapping_error(chan_dev, ...);
dma_unmap_single(chan_dev, ...);

> > - add the test logs.
> 
> [...]
> 
> Best regards,
> Marek Vasut
