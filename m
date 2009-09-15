From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 12:49:36 +0100
Subject: [PATCH 10/10] S3C64XX I2S: En/Disable codec clocks.
In-Reply-To: <1253008962-10730-1-git-send-email-jassi.brar@samsung.com>
References: <1253008962-10730-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915114936.GK22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:42PM +0900, Jassi wrote:

>  	switch (clk_id) {
>  	case S3C64XX_CLKSRC_PCLK:
>  		iismod &= ~S3C64XX_IISMOD_IMS_SYSMUX;
> +		clk_disable(i2s->iis_cclk);
>  		break;
>  
>  	case S3C64XX_CLKSRC_MUX:
>  		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
> +		clk_enable(i2s->iis_cclk);
>  		break;

I'd expect that this will cause trouble eventually - machine drivers
tend to call set_sysclk() repeatedly, meaning that the clock will be
repeatedly enabled or disabled.  Eventually this will overflow the
counter the clock API is using, perhaps even cause it to complain loudly
about errors (eg, if the use count drops below zero).  A local reference
count should deal with those issues, or checking to see if iismod
actualy changed before updating the clock API.

Ideally we'd be able to stop the clock while the IIS interface is idle
for a small power saving.
