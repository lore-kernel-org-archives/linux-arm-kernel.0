From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 9 Aug 2011 18:13:18 +0530
Subject: [RFC][PATCH 2/2] spi: s3c64xx: Use clkdev for bus clock lookup
In-Reply-To: <1312898301-7229-1-git-send-email-padma.v@samsung.com>
References: <1312898301-7229-1-git-send-email-padma.v@samsung.com>
Message-ID: <CABb+yY1Be3q+5QVaLYnonOUq1VtjyCZMKp0S1yryjF2HRyqoSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 7:28 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> SPI driver is modified to lookup the bus clock using the
> alias name instead of getting clock name and clock
> number from platform data.
Cool.

> Driver is modified to get the best source clock among the
> available source clocks for the required frequency.
I am not sure if this driver should be deciding which clock is 'best' for it.
Because ...
1) Usually it's the board designer who decides which clock to run at
 what speed based upon target device. So ideally, based upon use-case
the driver should simply get the 'best' clock from board via platform in a
format that is compliant to the 'generic clock api'.
2) We are not changing source clock rates(and we should not).
 So the 'best' clock found, might still be way off in accuracy. And when we
can't anyway guarantee accuracy, why not leave the decision to
the board designer who might, say, select the source clock good enough
to be useful to more than one controller yet not absolutely accurate for any ?
3) It keeps enabled 3 unused clocks all the time.


> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 8945e20..d7c979d 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -132,6 +132,9 @@
> ?#define RXBUSY ? ?(1<<2)
> ?#define TXBUSY ? ?(1<<3)
>
> +#define MAX_SPI_BUS_CLK (4)
> +#define MAX_PSR (256)

Btw,

 #define MAX_SPI_BUS_CLK 4
 #define MAX_PSR 256

is safe ... even safer than with two on!
