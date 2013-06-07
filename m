From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 7 Jun 2013 15:12:10 +0200 (CEST)
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <2024464.67s93nOUnz@wuerfel>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <1370008605-3745603-2-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.64.1306071214200.11277@axis700.grange>
 <2024464.67s93nOUnz@wuerfel>
Message-ID: <Pine.LNX.4.64.1306071507060.11277@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Arnd Bergmann wrote:

[snip]

> I think that is a flaw in the dmaengine driver. I don't actually know how
> any dma-engine driver could use dmaengine_slave_config to pick the request
> line, since that is something the driver should not know at the time
> it calls dmaengine_slave_config().
> 
> It's probably best to change the shdma driver to just ignore the slave_id
> value in slave_config, like most other drivers to.

This is how shdma driver used to work. We used to pass the slave ID (DMA 
request line ID) to shdma from clients from the filter. This was 
considered bad and we were asked to switch to using 
dmaengine_slave_config(), which is the current preferred API, IIUC.

> I don't see how that
> could possibly work when used from a portable slave driver.

A DMA slave ID (DMA request line) is considered to be a portable 
parameter. I.e. on every platform your DMA slave has to request a DMA 
request line to the DMAC and that line can be coded with an int. That's 
the current assumption, I think.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
