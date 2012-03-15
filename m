From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 09:22:06 +0000
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201203150922.06379.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Nicolas Ferre wrote:
> Add some basic helpers to retrieve a DMA controller device_node and the
> DMA request specifications. By making DMA controllers register a generic
> translation function, we allow the management of any type of DMA requests
> specification.
> The void * output of an of_dma_xlate() function that will be implemented
> by the DMA controller can carry any type of "dma-request" argument.
> 
> The DMA client will search its associated DMA controller in the list and
> call the registered of_dam_xlate() function to retrieve the request values.
> 
> One simple xlate function is provided for the "single number" type of
> request binding.
> 
> This implementation is independent from dmaengine so it can also be used
> by legacy drivers.
> 
> For legacy reason another API will export the DMA request number into a
> Linux resource of type IORESOURCE_DMA.

This looks very good. I missed the first version of this patch, but was
thinking of very similar bindings.

> +Client drivers should specify the DMA request property using a phandle to
> +the controller. If needed, the DMA request identity on that controller is then
> +added followed by optional request specifications.
> +
> +Required property:
> +    - dma-request: List of phandle + dma-request + request specifications,
> +      one group per request "line".
> +Optional property:
> +    - dma-request-names: list of strings in the same order as the dma-request
> +      in the dma-request property.
> +
> +
> +Example:
> +
> +	i2c1: i2c at 1 {
> +		...
> +		dma-request = <&sdma 2 &sdma 3>;
> +		dma-request-names = "tx", "rx";
> +		...
> +	};

This is slightly different from how the proposed pwm binding works that
Thierry is working on, which uses an arbitrary property name instead of
requiring the use of a specific property but then allowing to give names
in another property.

I don't care much which way it's done, but please try to agree on one
approach that is used for both.

The one you have here is already used by reg and irq, while the other
one is used in gpio.

> +/**
> + * of_get_dma_request() - Get the associated DMA request data
> + * @np:		device node to get DMA request from
> + * @index:	index of the DMA request
> + * @out_data:	a output that can be filled in by the of_dma_xlate() function
> + *
> + * Returns return value of of_dma_xlate() and fills out_data (if provided).
> + * On error returns the appropriate errno value.
> + */

I would suggest provinding a helper function around this one that directly
calls __dma_request_channel(). AFAICT, you should be able to let the dma
controller provide a generic filter function in struct of_dma that the
driver can use by default.

	Arnd
