From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 29 Jun 2016 15:56:20 +0800
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1463114260-8724-1-git-send-email-oss@buserror.net>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
Message-ID: <57737F24.5050906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Scott,

On 2016/5/13 12:37, Scott Wood wrote:
[...]
>  
> +#ifdef CONFIG_ARM64
> +static __always_inline void rewrite_tval(const int access,
> +		unsigned long evt, struct clock_event_device *clk)
> +{
> +	u64 cval_old, cval_new;
> +	int timeout = 200;
> +
> +	do {
> +		cval_old = __arch_counter_get_cntvct();
> +		arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);

For not memory mapped timer, it will call arch_timer_reg_write_cp15() which has
isb() at the end of arch_timer_reg_write_cp15()...

> +		cval_new = __arch_counter_get_cntvct();

So there is isb() between counter retry read, I think it's likely cval_new will
not be equal with cval_old when the cntvct is correct (time lapse is more than
one arch timer cycle).

> +		timeout--;
> +	} while (cval_old != cval_new && timeout);
> +
> +	WARN_ON_ONCE(!timeout);

Then trigger the warning here, correct me if I miss something else.

Thanks
Hanjun
