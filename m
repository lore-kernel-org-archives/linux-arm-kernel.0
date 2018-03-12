From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Mar 2018 14:44:43 +0000
Subject: [PATCH v5 03/23] arm64: insn: Add encoder for bitwise operations
 using literals
In-Reply-To: <20180301155538.26860-4-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-4-marc.zyngier@arm.com>
Message-ID: <20aed108-d44e-89b9-0532-cad5fbb27f46@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/18 15:55, Marc Zyngier wrote:
> We lack a way to encode operations such as AND, ORR, EOR that take
> an immediate value. Doing so is quite involved, and is all about
> reverse engineering the decoding algorithm described in the
> pseudocode function DecodeBitMasks().
> 
> This has been tested by feeding it all the possible literal values
> and comparing the output with that of GAS.

This is getting quite funny. Although the test harness was 100% matching
the GAS encoding...

[...]

> +	/*
> +	 * Inverse of Replicate(). Try to spot a repeating pattern
> +	 * with a pow2 stride.
> +	 */
> +	for (tmp = esz / 2; tmp >= 2; tmp /= 2) {
> +		u64 emask = BIT(tmp) - 1;
> +
> +		if ((imm & emask) != ((imm >> (tmp / 2)) & emask))

... I failed to move a fix from the test harness to the kernel code.
Total fail. Here, "(tmp / 2)" should really read "tmp".

Thanks to James for noticing the breakage.

	M. (annoyed)
-- 
Jazz is not dead. It just smells funny...
