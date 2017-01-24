From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 24 Jan 2017 08:31:17 +0100
Subject: [PATCH] mmc: s3cmci: include linux/interrupt.h for tasklet_struct
In-Reply-To: <20170120200822.3349092-1-arnd@arndb.de>
References: <20170120200822.3349092-1-arnd@arndb.de>
Message-ID: <CAPDyKFp1mqAFjQ3-YryqxH9bDrhe-w1r23DUWF6UNZeqGXjuHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2017 at 21:08, Arnd Bergmann <arnd@arndb.de> wrote:
> I got this new build error on today's linux-next
>
> drivers/mmc/host/s3cmci.h:69:24: error: field 'pio_tasklet' has incomplete type
>   struct tasklet_struct pio_tasklet;
> drivers/mmc/host/s3cmci.c: In function 's3cmci_enable_irq':
> drivers/mmc/host/s3cmci.c:390:4: error: implicit declaration of function 'enable_irq';did you mean 'enable_imask'? [-Werror=implicit-function-declaration]
>
> While I haven't found out why this happened now and not earlier, the
> solution is obvious, we should include the header that defines
> the structure.

Yes, it's a bit weird. Actually non of the automated build system have
reported this.

I have my own homebrewed makefiles, as to run a quick sanity test for
mmc host drivers. However, my quick test didn't cover s3cmci, next
time it will.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for helping out! Applied for next and folded it in properly in
my queue to avoid bisect issues!

Kind regards
Uffe

> ---
>  drivers/mmc/host/s3cmci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 932a4b1fed33..7a173f8c455b 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -21,6 +21,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/gpio.h>
> +#include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
>
> --
> 2.9.0
>
