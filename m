From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 08 Sep 2014 15:02:00 +0400
Subject: [PATCH] rtc: pcf8563: fix uninitialized use warning
In-Reply-To: <3640058.m4Rfp1dmTJ@wuerfel>
References: <3640058.m4Rfp1dmTJ@wuerfel>
Message-ID: <540D8CA8.5020104@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/8/2014 12:42 AM, Arnd Bergmann wrote:

> gcc-4.9 found a potential condition under which the 'pending'
> variable may be used uninitialized:

> drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_irq':
> drivers/rtc/rtc-pcf8563.c:173:5: warning: 'pending' may be used uninitialized in this function [-Wmaybe-uninitialized]

> This is because in the pcf8563_get_alarm_mode() function, we
> check any nonzero return of pcf8563_read_block_data, but
> in the irq function we only check for negative values, so
> a possible positive value does not get detected if the compiler
> chooses not to inline the entire call chain.

> Checking for any non-zero value in the interrupt handler as well
> is just as correct and lets the compiler know what we are doing,
> without needing a bogus initialization.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 5a197d9dc7e7..3a6f994c4da8 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -167,7 +167,7 @@ static irqreturn_t pcf8563_irq(int irq, void *dev_id)
>   	char pending;
>
>   	err = pcf8563_get_alarm_mode(pcf8563->client, NULL, &pending);
> -	if (err < 0)
> +	if (err)
>   		return err;

    Returning negative values from the IRQ handler doesn't seem valid.
Arbitrary positive value aren't good either. Perhaps should return IRQ_NONE 
instead?

WBR, Sergei
