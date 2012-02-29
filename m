From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 12:54:15 -0800
Subject: [RFC PATCH] of: DMA helpers: manage generic requests specification
In-Reply-To: <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com>
References: <4F22DEF2.5000807@ti.com>
 <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF217B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre wrote at Wednesday, February 29, 2012 7:54 AM:
> By making DMA controllers register a generic translation
> function, we allow the management of any type of DMA requests
> specification.
> The void * output of an of_dma_xlate() function that will be implemented
> by the DMA controller can carry any type of "dma-request" argument.
> 
> The DMA client will search its associated DMA controller in the list
> and call the registered of_dam_xlate() function to retrieve the
> request values.
> 
> One simple xlate function is provided for the "single number" type
> of request biding.
> 
> This implementation is independent from dmaengine so it can also be
> used by legacy drivers.

At a high level this seems along the right lines.

The big issue I see is the lack of type-safety in of_get_dma_request()'s
out_data pointer: The DMA xlate function will assume it points at some
particular type, and the client is responsible for allocating that
correct type. However, it's "user"-supplied device tree data that hooks
the two together, and there could easily be mismatches, thus causing
the xlate function to trash memory.

Could each DMA controller (or type of out_data) have some enum in the
kernel that the client passes in, and the DMA engine validates matches
its expectations, to prevent this kind of thing?

enum DMA_PARAMS_TYPE {
    FOO_DMA_PARAMS,
    BAR_DMA_PARAMS,
    ...
};

struct foo_dma_params { ... };

struct foo_dma_params params;

of_get_dma_request(np, 0, &params, FOO_DMA_PARAMS);

and inside xlate():

if (params_type != FOO_DMA_PARAMS)
    return -EINVAL;

For the dmaengine case, I assume there'd be a single DMA_PARAMS_TYPE
value for the dmaengine specifier type, and the dmaengine core would
take care of making sure everything matched somehow.

-- 
nvpublic
