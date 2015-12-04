From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 14:01:19 +0000
Subject: [PATCH v8 4/4] arm64: switch to irq_stack during softirq
In-Reply-To: <1449226948-14251-5-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-5-git-send-email-james.morse@arm.com>
Message-ID: <20151204140119.GL10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:02:28AM +0000, James Morse wrote:
> +ENTRY(__do_softirq_on_irqstack)
> +	push	x19, lr
> +	push	x25, x26
> +
> +	irq_stack_entry lr
> +
> +	/* irq_stack_entry leaves irq_count in x25 */
> +	ldr	x1, [x25]
> +	add	x1, x1, #1
> +	str	x1, [x25]
> +
> +	bl	__do_softirq
> +
> +	ldr	x1, [x25]
> +	sub	x1, x1, #1
> +	str	x1, [x25]
> +
> +	irq_stack_exit
> +
> +	pop x25, x26
> +	pop x19, lr
> +	ret
> +ENDPROC(__do_softirq_on_irqstack)

I was thinking of doing do_softirq_own_stack() entirely in assembly
without the need to check for on_irq_stack() check in C, just a test of
the irq_count value.

But this means collapsing patches 3 and 4 ;).

-- 
Catalin
