From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 30 Nov 2009 14:23:20 -0800
Subject: [PATCH V4]ARM: NUC900: add RTC driver support for nuc910 and
	nuc920
In-Reply-To: <4B126B03.1060901@gmail.com>
References: <4B126B03.1060901@gmail.com>
Message-ID: <20091130142320.01f0c212.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 Nov 2009 20:37:23 +0800
Wan ZongShun <mcuos.com@gmail.com> wrote:

> Dear Alessandro,
> 
> I fixed this patch and submitted it again.
> 
> thanks!
> 
> signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

That's not a terribly useful changelog.

>
> ...
>
> +static void check_rtc_power(struct nuc900_rtc *nuc900_rtc)
> +{
> +	unsigned int i;
> +	__raw_writel(INIRRESET, nuc900_rtc->rtc_reg + REG_RTC_INIR);
> +
> +	mdelay(10);
> +
> +	__raw_writel(AERPOWERON, nuc900_rtc->rtc_reg + REG_RTC_AER);
> +
> +	for (i = 0; i < 1000000; i++) {
> +		if (__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB)
> +			break;
> +	}
> +}

I don't like that function much.

- It's not obvious what it actually does (I don't know), so it should
  have some comment explaining this.

- It's called "check_rtc_power", but it doesn't actually "check"
  anything.

- If that enormously expensive loop times out, the function will not
  inform the caller of this, so it will be called again and again and
  will continue to be enormously expensive.

>
> ...
>
