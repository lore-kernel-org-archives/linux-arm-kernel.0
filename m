From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 05 Jun 2013 16:42:20 -0400 (EDT)
Subject: [PATCH 5/8] arm: mvebu: don't hardcode a physical address in
 headsmp.S
In-Reply-To: <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.LFD.2.03.1306051637020.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Jun 2013, Thomas Petazzoni wrote:

[...]
>  ENTRY(armada_xp_secondary_startup)
> +	/* Get coherency fabric base physical address */
> +	adr	r0, 1f
> +	ldmia	r0, {r1, r2}
> +	sub	r0, r0, r1
> +	add	r2, r2, r0
> +	ldr	r0, [r2]
[...]
> +
> +	.align 2
> +1:
> +	.long	.
> +	.long	coherency_phys_base

You may simplify the above like this:

	adr	r0, 1f
	ldr	r1, [r0]
	ldr	r0, [r0, r1]
	...,
1:	.long	coherency_phys_base - .


Nicolas
