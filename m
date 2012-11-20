From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2012 16:32:43 +0000
Subject: [PATCH V4 1/5] arm: mvebu: Added support for coherency fabric in
 mach-mvebu
In-Reply-To: <1353357360-7242-2-git-send-email-gregory.clement@free-electrons.com>
References: <1353357360-7242-1-git-send-email-gregory.clement@free-electrons.com>
 <1353357360-7242-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121120163243.GA27765@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Thanks for turning this around so quickly! I still have a few comments on
your assembly, but you've got the right idea:

On Mon, Nov 19, 2012 at 08:35:55PM +0000, Gregory CLEMENT wrote:
> From: Yehuda Yitschak <yehuday@marvell.com>
> 
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]

> +/* Function defined in coherncy_ll.S */
> +extern void ll_set_cpu_coherent(void __iomem *base_addr,
> +				unsigned int hw_cpu_id);
> +
> +int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
> +{
> +	if (!coherency_base) {
> +		pr_warn("Can't make CPU %d cache coherent.\n", hw_cpu_id);
> +		pr_warn("Coherency fabric is not initialized\n");
> +		return 1;
> +	}
> +	ll_set_cpu_coherent(coherency_base, hw_cpu_id);
> +	return 0;
> +}

Yup, something like this is neater I reckon. You could even make
ll_set_cpu_coherent return 0 if you wanted, but it's up to you.

> +#include <linux/linkage.h>
> +#define ARMADA_XP_CFB_CTL_REG_OFFSET 0x0
> +#define ARMADA_XP_CFB_CFG_REG_OFFSET 0x4
> +
> +	.text
> +/*
> + * r0: CFB base adresse register

address

> + * r1: HW CPU id
> + */
> +ENTRY(ll_set_cpu_coherent)
> +	/* Create bit by cpu index */
> +	add     r1,r1,#24
> +	mov     r3, #1

Can you instead mov r3, #(1 << 24) and get rid of these two instructions?

> +	lsl     r1, r3, r1
> +
> +
> +	/* Add CPU to SMP group - Atomic */
> +	 orr	r0, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET

An add might be clearer here, despite the address alignment.

> +	ldr     r4, [r0]
> +	orr     r4 , r4, r1
> +	str	r4,[r0]

You haven't saved r4, so you can't use it here. It looks like you have r2
spare -- why not use that instead?

> +	/* Enable coherency on CPU - Atomic*/
> +	orr	r0, r0, #ARMADA_XP_CFB_CFG_REG_OFFSET

add

> +	ldr     r4, [r0]
> +	orr     r4 , r4, r1
> +	str     r4,[r0]

mov	r0, #0 here if you want to return 0.

> +	mov	pc, lr
> +ENDPROC(ll_set_cpu_coherent)

Will
