From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Oct 2017 07:20:32 +0200
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <20171002020618.23924-4-nicolas.pitre@linaro.org>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
 <20171002020618.23924-4-nicolas.pitre@linaro.org>
Message-ID: <20171002052032.5ohpvogewio6axdr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

On Sun, Oct 01, 2017 at 10:06:18PM -0400, Nicolas Pitre wrote:
> With printch() the console messages are sent out one character at a time
> which is agonizingly slow especially with semihosting as the whole trap
> intercept, remote byte access, and system resume danse is performed for

s/danse/dance/ ?

> every single character across a relatively slow remote debug connection.
> Let's use printascii() to send a whole string at once. This is also going
> to be more efficient, albeit to a quite lesser extent, with serial ports
> as well.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/kernel/early_printk.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> index 4307653696..9257736ec9 100644
> --- a/arch/arm/kernel/early_printk.c
> +++ b/arch/arm/kernel/early_printk.c
> @@ -11,16 +11,20 @@
>  #include <linux/kernel.h>
>  #include <linux/console.h>
>  #include <linux/init.h>
> +#include <linux/string.h>
>  
> -extern void printch(int);
> +extern void printascii(const char *);
>  
>  static void early_write(const char *s, unsigned n)
>  {
> -	while (n-- > 0) {
> -		if (*s == '\n')
> -			printch('\r');
> -		printch(*s);
> -		s++;
> +	char buf[128];
> +	while (n) {
> +		unsigned l = min(n, sizeof(buf)-1);
> +		memcpy(buf, s, l);
> +		buf[l] = 0;
> +		s += l;
> +		n -= l;
> +		printascii(buf);

I wonder if it is a usual case that n < 128 and s[n] == '\0'. If so this
could be tested for and then the memcpy could be dropped.
(The downside of course is that s[n] might also be something completely
different?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
