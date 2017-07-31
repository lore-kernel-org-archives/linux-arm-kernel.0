From: hw.likun@huawei.com (Li Kun)
Date: Mon, 31 Jul 2017 21:17:40 +0800
Subject: [PATCH v3] arm64: kernel: implement fast refcount checking
In-Reply-To: <20170731120144.14214-1-ard.biesheuvel@linaro.org>
References: <20170731120144.14214-1-ard.biesheuvel@linaro.org>
Message-ID: <a0b6690d-039e-04ed-9847-b4521935375f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/7/31 20:01, Ard Biesheuvel ??:
> +static __always_inline __must_check bool refcount_add_not_zero(unsigned int i,
> +							       refcount_t *r)
> +{
> +	unsigned long tmp;
> +	int result;
> +
> +	asm volatile("// refcount_add_not_zero \n"
> +"	prfm		pstl1strm, %2\n"
> +"1:	ldxr		%w[val], %2\n"
> +"	cbz		%w[val], 2f\n"
> +"	adds		%w[val], %w[val], %w[i]\n"
> +"	stxr		%w1, %w[val], %2\n"
> +"	cbnz		%w1, 1b\n"
> +	REFCOUNT_POST_CHECK_NEG
> +"2:"
> +	: [val] "=&r" (result), "=&r" (tmp), "+Q" (r->refs.counter)
> +	: REFCOUNT_INPUTS(&r->refs) [i] "Ir" (i)
> +	: REFCOUNT_CLOBBERS);
> +
> +	return result != 0;
> +}
> +
Could we use "cas" here instead of ll/sc ?

-- 
Best Regards
Li Kun
