From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jan 2017 18:30:32 +0000
Subject: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
In-Reply-To: <20161221064603.11830-11-fu.wei@linaro.org>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
Message-ID: <20170116183032.GL5908@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 02:45:58PM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch refactor original memory-mapped timer init code:
>     (1) Refactor "arch_timer_mem_init", make it become a common code for
>         memory-mapped timer init.
>     (2) Add a new function "arch_timer_mem_of_init" for DT init.

As a general note, please write proper commit messages, describing what
the problem is, and why we are making the changes. These bullet points
don't add anything to what can be derived from a glance at the code.

For this patch, you can use:

  clocksource: arm_arch_timer: refactor MMIO timer probing

  Currently the code to probe MMIO architected timers mixes DT parsing
  with actual poking of hardware. This makes the code harder than
  necessary to understand, and makes it difficult to add support for
  probing via ACPI.

  This patch factors all the DT-specific logic out of
  arch_timer_mem_init(), into a new function, arch_timer_mem_of_init().
  The former pokes the hardware and determines the suitablility of
  frames based on a datastructure populated by the latter.

  This cleanly separates the two and will make it possible to add
  probing using the ACPI GTDT in subsequent patches.

[...]

> +	for_each_available_child_of_node(np, frame_node) {
> +		int n;
> +		struct arch_timer_mem_frame *frame = &timer_mem->frame[i];
> +
> +		if (of_property_read_u32(frame_node, "frame-number", &n)) {
> +			pr_err("Missing frame-number\n");
> +			of_node_put(frame_node);
> +			goto out;
> +		}
> +		frame->frame_nr = n;
> +
> +		if (of_address_to_resource(frame_node, 0, &res)) {
> +			of_node_put(frame_node);
> +			goto out;
> +		}
> +		frame->cntbase = res.start;
> +		frame->size = resource_size(&res);
> +
> +		frame->virt_irq = irq_of_parse_and_map(frame_node,
> +						       ARCH_TIMER_VIRT_SPI);
> +		frame->phys_irq = irq_of_parse_and_map(frame_node,
> +						       ARCH_TIMER_PHYS_SPI);
>  
> -	if (!arch_timer_needs_of_probing())
> +		if (++i >= ARCH_TIMER_MEM_MAX_FRAMES)
> +			break;
> +	}

It would be good if we could warn upon seeing more than
ARCH_TIMER_MEM_MAX_FRAMES children, since that's obviously an error.

Thanks,
Mark.
