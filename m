From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 15 Nov 2009 22:35:44 +0100
Subject: [PATCH] Remove __raw_* accessors from PL031 RTC
In-Reply-To: <1258009987-11317-1-git-send-email-linus.walleij@stericsson.com>
References: <1258009987-11317-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20091115213544.GA1370@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 12, 2009 at 08:13:07AM +0100, Linus Walleij wrote:
> This switches __raw_[read|write]l() for plain [read|write]l in
> the PL031 RTC driver. The sister driver for PL030 use the simple
> accessors as most PrimeCell drivers.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/rtc/rtc-pl031.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
> index f41873f..0264b11 100644
> --- a/drivers/rtc/rtc-pl031.c
> +++ b/drivers/rtc/rtc-pl031.c
> @@ -51,10 +51,10 @@ static int pl031_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  
>  	switch (cmd) {
>  	case RTC_AIE_OFF:
> -		__raw_writel(1, ldata->base + RTC_MIS);
> +		writel(1, ldata->base + RTC_MIS);
arch/arm/include/asm/io.h defines writel like so:

	#define writel(v,c)		__raw_writel((__force __u32) \
						cpu_to_le32(v),__mem_pci(c))

So this change isn't a noop on big-endian systems that define __mem_pci.
I don't know how many of these exist though.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
