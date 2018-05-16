From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 16 May 2018 22:32:40 +0200
Subject: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
In-Reply-To: <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
Message-ID: <20180516203240.GB24496@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2018 17:46:10+0200, Amelie Delaunay wrote:
>  struct stm32_rtc_registers {
> @@ -86,6 +98,9 @@ struct stm32_rtc_registers {
>  	u8 prer;
>  	u8 alrmar;
>  	u8 wpr;
> +	u8 sr;
> +	u8 scr;
> +	u16 verr;

All those offsets should probably be u16 or u32...

> +	if (regs.verr != UNDEF_REG) {

...else, this is not working, as reported by kbuild

> +		u32 ver = readl_relaxed(rtc->base + regs.verr);
> +
> +		dev_info(&pdev->dev, "registered rev:%d.%d\n",
> +			 (ver >> STM32_RTC_VERR_MAJREV_SHIFT) & 0xF,
> +			 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
> +	}
> +

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
