From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 11 Jul 2016 15:46:21 +0100
Subject: [PATCH v2 4/6] common: DMA-mapping: add
 DMA_ATTR_PRIVILEGED_EXECUTABLE attribute
In-Reply-To: <20160709020919.6760-5-mitchelh@codeaurora.org>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
 <20160709020919.6760-5-mitchelh@codeaurora.org>
Message-ID: <5783B13D.5010404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/16 03:09, Mitchel Humpherys wrote:
> This patch adds the DMA_ATTR_PRIVILEGED_EXECUTABLE attribute to the
> DMA-mapping subsystem.

DMA_ATTR_PRIVILEGED. We can worry about the (much bigger) executable vs.
NX issue some other time.

> Some architectures require that writable mappings also be non-executable at
> lesser-privileged levels of execution.  This attribute is used to indicate

I don't think "architectures" is really an appropriate fit here - for
what we're addressing, maybe something like "Some advanced peripherals
such as remote processors and GPUs perform accesses to DMA buffers in
both privileged "supervisor" and unprivileged "user" modes."

> to the DMA-mapping subsystem that it should do whatever is necessary to
> ensure that the buffer is executable at an elevated privilege level (by
> making it read-only at the lesser-privileged levels, for example).

and correspondingly "...the buffer is fully accessible at the elevated
privilege level (and ideally inaccessible or at least read-only at the
lesser-privileged levels)". What do you think?

I'm not sure what the latest status of Krzysztof's dma_attrs
coversion[1] is, but if you weren't aware of it this is just a heads-up
that there might need to be some coordination there.

What would be really cool if we could somehow remember which buffers
were allocated as privileged and refuse to expose them to userspace in
dma_mmap_attrs(), but I don't a feasible way to implement that without
impractically massive changes.

Robin.

[1]:http://thread.gmane.org/gmane.comp.freedesktop.xorg.drivers.freedreno/164

> Cc: linux-doc at vger.kernel.org
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  Documentation/DMA-attributes.txt | 9 +++++++++
>  include/linux/dma-attrs.h        | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
> index e8cf9cf873b3..6a22d4307008 100644
> --- a/Documentation/DMA-attributes.txt
> +++ b/Documentation/DMA-attributes.txt
> @@ -126,3 +126,12 @@ means that we won't try quite as hard to get them.
>  
>  NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
>  though ARM64 patches will likely be posted soon.
> +
> +DMA_ATTR_PRIVILEGED_EXECUTABLE
> +------------------------------
> +
> +Some architectures require that writable mappings also be non-executable at
> +lesser-privileged levels of execution.  This attribute is used to indicate
> +to the DMA-mapping subsystem that it should do whatever is necessary to
> +ensure that the buffer is executable at an elevated privilege level (by
> +making it read-only at the lesser-privileged levels, for example).
> diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
> index 5246239a4953..8cf4dff6185b 100644
> --- a/include/linux/dma-attrs.h
> +++ b/include/linux/dma-attrs.h
> @@ -19,6 +19,7 @@ enum dma_attr {
>  	DMA_ATTR_SKIP_CPU_SYNC,
>  	DMA_ATTR_FORCE_CONTIGUOUS,
>  	DMA_ATTR_ALLOC_SINGLE_PAGES,
> +	DMA_ATTR_PRIVILEGED_EXECUTABLE,
>  	DMA_ATTR_MAX,
>  };
>  
> 
