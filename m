From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Feb 2010 20:40:09 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002171015.52875.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<201002160922.47072.oliver@neukum.org>
	<1266397543.16346.264.camel@pasglop>
	<201002171015.52875.oliver@neukum.org>
Message-ID: <1266399609.16346.271.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-17 at 10:15 +0100, Oliver Neukum wrote:
> We should have changed the subject line.
> 
> There's a second problem. It turns out that on ARM
> mapping for DMA must not be done if PIO will be used. Some HCDs
> use PIO for some transfers but DMA for others. The generic layer
> must learn about this. 

Ah, that makes a lot of sense and the same problem would happen on
any non-DMA coherent architecture, including some embedded ppc's.

I can see why the dma unmap would invalidate the dcache and blow
away the PIO.

What bugs me here is that the dma_map_* operation should always
be done at the lowest level, ie, the actual HCD driver, and thus
it should be up to the HCD to decide whether to dma_map or not
depending on whether it's going to do DMA or not. I haven't
scrutinized USB lately but if that isn't the case and the dma_map_*
operations are done behind your back by the USB core then that needs to
be changed in a way or another, or hooked at least.

Cheers,
Ben.
