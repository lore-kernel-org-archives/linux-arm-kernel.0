From: ole.reinhardt@embedded-it.de (Ole Reinhardt)
Date: Fri, 14 May 2010 15:38:27 +0200
Subject: Possible memory leak: g_serial/ dma pool allocation in fsl_udc_core.c
Message-ID: <1273844307.30298.35.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

while debugging the g_serial schedule while atomic bug described some
days ago on this list I found a possible reason / problem:

In fsl_udc_core.c a dma pool is used to allocate memory for the dtd
structure in fsl_build_dtd().

The only place, where the memory is freed again is in done(). I noticed
that the dma allocation might fail, if it's done with GFP_ATOMIC. In
other words, dma memory went low.

To debug this dma pool allocation I added a counter which counts the
allocations / frees 

Testing the g_serial gadget with my little test-script 

#!/bin/sh
while [ 1 ] ; do
echo "Hello world" > /dev/ttyGS0
done

i noticed that there are only around 3 frees on 20 allocations... After
a short time the dma memory went low and dma_pool_alloc returned with
-ENOMEM when calling it with GFP_ATOMIC. With GPF_KERNEL it just hang
(if not called in an atomic situation, otherwise will fail with BUG).

When removing the g_serial module all the allocated memory is freed
again.

Any suggestions?

Regards,

Ole Reinhardt

-- 

Thermotemp GmbH, Embedded-IT

Embedded Hard-/ Software and Open Source Development, 
Integration and Consulting

http://www.embedded-it.de

Gesch?ftsstelle Siegen - Steinstra?e 67 - D-57072 Siegen - 
tel +49 (0)271 5513597, +49 (0)271-73681 - fax +49 (0)271 736 97

Hauptsitz - Hademarscher Weg 7 - 13503 Berlin
Tel +49 (0)30 4315205 - Fax +49 (0)30 43665002
Gesch?ftsf?hrer: J?rg Friedrichs, Ole Reinhardt
Handelsregister Berlin Charlottenburg HRB 45978 UstID DE 156329280 
