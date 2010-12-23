From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 23 Dec 2010 23:24:33 +0100
Subject: [PATCH] OMAP4: hwmod data: Fix SR flags, structures order and
	field alignment
In-Reply-To: <20101223204608.GR7771@atomide.com>
References: <1293113700-24309-1-git-send-email-b-cousson@ti.com>
	<20101223204608.GR7771@atomide.com>
Message-ID: <4D13CC21.9010109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2010 9:46 PM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [101223 06:14]:
>> Smartreflex is missing the recently introduced SIDLE_SMART_WKUP
>> flag in idlemodes field.
>
> So this actually also changes something too?

Not yet, because we are not doing any clock domain transition to
INACTIVE for the moment, so the wakeup is still not used.

>> The merge of the DMA and SR series on top of the already modified
>> omap_hwmod_data_44xx.c moved the dma_system structure at the wrong
>> position in the file. The same thing happened for the SR structure.
>> - Re-order the structures properly.
>>
>> In order to be fully aligned with the Python generator output,
>> change a couple of fields.
>> - Add tab in class and dev_attr structures to align fields
>> - Add a comma at the end of the following line to simplify the
>>    code generation:
>>    ".pre_shutdown   =&omap2_wd_timer_disable,"
>
> To me it sounds like this should be at least two separate patches:
> One that adds the SIDLE_SMART_WKUP, then another patch that
> only does clean-up with no functional changes.

OK

> Also this patch applied (contactenated multiple patches?) turns
> into a hard to read interleaved patch for some parts:

Mmm, I do not understand how did you get that diff? This is not
like that in the patch I sent you?
The patch should apply cleanely on top of your omap-for-linus
branch.

> -static struct omap_hwmod_irq_info omap44xx_uart2_irqs[] = {
> -	{ .irq = 73 + OMAP44XX_IRQ_GIC_START },
> -};
> -
> -static struct omap_hwmod_dma_info omap44xx_uart2_sdma_reqs[] = {
> -	{ .name = "tx", .dma_req = 50 + OMAP44XX_DMA_REQ_START },
> -	{ .name = "rx", .dma_req = 51 + OMAP44XX_DMA_REQ_START },
> +/* smartreflex_iva */
> +static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
> +	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
>   };
>
> -static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
> +static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
>   	{
> -		.pa_start	= 0x4806c000,
> -		.pa_end		= 0x4806c0ff,
> +		.pa_start	= 0x4a0db000,
> +		.pa_end		= 0x4a0db03f,
>   		.flags		= ADDR_TYPE_RT
>   	},
>   };
> ...
>
> So sounds like your original three patches would be the better
> way to go.

OK, as a special gift for you, you will have 4 patches :-)

Same place:
git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_fixes


Thanks,
Benoit
