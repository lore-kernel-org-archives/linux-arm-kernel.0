From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 19 Mar 2010 03:46:45 +0000
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check
	for it on V6
In-Reply-To: <20100319013521.GP2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
	<1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
	<20100317191114.GH2900@atomide.com>
	<1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
	<20100318170021.GN2900@atomide.com>
	<20100319013521.GP2900@atomide.com>
Message-ID: <20100319034645.GG14108@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote:
> Also, I wonder if the change __kuser_get_tls is safe?
> 
> +	ldr     r0, [pc, #(16 - 8)]		@ TLS set at 0xffff0ff0?
> +	cmp	r0, #0				@ assume hw TLS if not set
> +	mrceq	p15, 0, r0, c13, c0, 3		@ read TLS register

You cannot assume the TLS value is non-zero, because it's provided by
userspace to use however it wants.  It doesn't even have to be an address.

I'm thinking, why not an alternative() macro like on x86, which is a
very nice way to describe run-time patches of one or a few instructions
which depend on arch feature bits.

Then all that switch_to() logic could be made the size it was before.

An alternative() macro could make a lot of other chip-dependent calls
smaller too, i.e. all those which dispatch through function pointers
at present for cache flushing etc - they could become direct calls, or
an inline instruction or two when possible.

-- Jamie
