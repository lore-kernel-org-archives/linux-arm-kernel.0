From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2012 16:40:58 +0000
Subject: [PATCH V4 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <1353357360-7242-6-git-send-email-gregory.clement@free-electrons.com>
References: <1353357360-7242-1-git-send-email-gregory.clement@free-electrons.com>
 <1353357360-7242-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121120164058.GB27765@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 08:35:59PM +0000, Gregory CLEMENT wrote:
> +/*
> + * Armada XP specific entry point for secondary CPUs.
> + * We add the CPU to the coherency fabric and then jump to secondary
> + * startup
> + */
> +ENTRY(armada_xp_secondary_startup)
> +
> +	/* Read CPU id */
> + 	mrc     p15, 0, r1, c0, c0, 5
> +	and     r1, r1, #0xF
> +
> +	/* Add CPU to coherency fabric */
> +
> +	ldr     r0, = ARMADA_XP_CFB_BASE
> +	mov	lr, pc
> +	b	ll_set_cpu_coherent
> +	b	secondary_startup

adr	lr, BSYM(secondary_startup)
bl	ll_set_cpu_coherent

should let you get rid of the mov, b, b, although I think you could do
better than that by making this function a prefix of ll_set_cpu_coherent:

ENTRY(armada_xp_secondary_startup)
	ldr     r0, =ARMADA_XP_CFB_BASE
	mrc     p15, 0, r1, c0, c0, 5
	and     r1, r1, #0xF
	adr	lr, BSYM(secondary_startup)

	/* Fallthrough */

ENTRY(ll_set_cpu_coherent)
...
ENDPROC(ll_set_cpu_coherent)
ENDPROC(armada_xp_secondary_startup)

what do you think?

Will
