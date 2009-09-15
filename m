From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 12:06:35 +0100
Subject: [PATCH 08/10] S3C64XX I2S: Return correct codec clock
In-Reply-To: <1253008960-10666-1-git-send-email-jassi.brar@samsung.com>
References: <1253008960-10666-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915110635.GI22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:40PM +0900, Jassi wrote:

> -	return i2s->iis_cclk;
> +	if(iismod & S3C64XX_IISMOD_IMS_SYSMUX)
> +		return i2s->iis_cclk;
> +	else
> +		return i2s->iis_pclk;

There's three possible clocks here according to the datasheet - PCLK,
CLKAUDIO and I2SCLK - so this will still give the wrong clock some of
the time.  Also, please use checkpatch.

Ideally we wouldn't have to export the clock at all, of course.
