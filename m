From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 19 Jan 2013 19:59:07 +0100
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50FABBED.1020905@web.de>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <201301171049.30415.arnd@arndb.de> <50F800EB.6040104@web.de>
 <201301172026.45514.arnd@arndb.de> <50FABBED.1020905@web.de>
Message-ID: <20130119185907.GA20719@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please find attached a debug log generated with your patch.
> 
> I used the sata disk and two em28xx dvb sticks, no other usb devices,
> no ethernet cable connected, tuners on saa716x-based card not used.
> 
> What I can see in the log: a lot of coherent mappings from sata_mv
> and orion_ehci, a few from mv643xx_eth, no other coherent mappings.
> All coherent mappings are page aligned, some of them (from orion_ehci)
> are not really small (as claimed in __alloc_from_pool).
> 
> I don't believe in a memory leak. When I restart vdr (the application
> utilizing the dvb sticks) then there is enough dma memory available
> again.

Hi Soeren

We should be able to rule out a leak. Mount debugfg and then:

while [ /bin/true ] ; do cat /debug/dma-api/num_free_entries ; sleep 60 ; done

while you are capturing. See if the number goes down.

      Andrew
