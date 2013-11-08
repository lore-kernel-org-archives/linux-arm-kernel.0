From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 08 Nov 2013 17:02:57 +0000
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Thu, 7 Nov 2013 11:20:42 -0800")
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <yw1xr4aqx1vi.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> +int __aeabi_idiv(int numerator, int denominator)
> +{
> +	if (static_key_false(&cpu_has_idiv)) {
> +		int ret;
> +
> +		asm volatile (
> +		".arch_extension idiv\n"
> +		"sdiv %0, %1, %2"
> +		: "=&r" (ret)

There is no need for the & in the output constraint.  Dropping it allows
using one of the source registers as destination which may sometimes be
beneficial.

> +		: "r" (numerator), "r" (denominator));
> +
> +		return ret;
> +	}
> +
> +	return ___aeabi_idiv(numerator, denominator);
> +}

-- 
M?ns Rullg?rd
mans at mansr.com
