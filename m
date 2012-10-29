From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 29 Oct 2012 15:09:18 +0100
Subject: [RFC] Using CMA with devicetree generated devices
In-Reply-To: <508AFA78.4080602@codeaurora.org>
References: <508AFA78.4080602@codeaurora.org>
Message-ID: <508E8E0E.8000605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 10/26/2012 11:02 PM, Laura Abbott wrote:
> Is it possible to use the devices generated from device tree for use
> with CMA? The API for reserving a CMA region (dma_declare_contiguous)
> requires a device pointer to properly associate a region with a device.
> By the time the devices from devicetree are actually available
> (generally during machine_init), dma_contiguous_remap has already been
> called so it's too late to have a properly setup region.
>
> I currently see several options:
>
> 1) All CMA devices must be statically declared in the board file
> 2) Scan the FDT to set up 'dummy' devices early which can later be used
> to set up CMA with the 'proper' devices
> 3) My assumption is completely wrong and the check that I was using is
> invalid:

dma_declare_contiguous() must be called very early, before any dynamic 
structures has been created and before core memory management subsystem 
has been set up. IMHO it should be possible to add support for DT 
directly in drivers/base/dma-contiguous.c. CMA code can iterate over DT 
nodes to initialize its internal structures and then use them once the 
DT devices are being probed/set-up.

> (...)

> I'm currently leaning towards setting up #2 unless I'm missing something
> obvious here. Thanks.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
