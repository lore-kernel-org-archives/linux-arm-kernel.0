From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 10 Apr 2012 21:21:33 -0400
Subject: [PATCH] ARM: orion5x: Fix GPIO enable bits for MPP9
In-Reply-To: <1333771725.7150.32.camel@deadeye>
References: <1333771725.7150.32.camel@deadeye>
Message-ID: <20120411012133.GD14790@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 07, 2012 at 05:08:45AM +0100, Ben Hutchings wrote:
> Commit 554cdaefd1cf7bb54b209c4e68c7cec87ce442a9 seems to have
> accidentally inverted the GPIO valid bits for MPP9 (only).  For the
> mv2120 platform which uses MPP9 as a GPIO LED device, this results in
> the error:
> 
> [   12.711476] leds-gpio: probe of leds-gpio failed with error -22
> 
> Reported-by: Henry von Tresckow <hvontres@gmail.com>
> References: http://bugs.debian.org/667446
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: stable at vger.kernel.org [v3.0+]
> ---
> I know nothing about this platform, and this is totally untested.  But
> it does look quite straightforward...

Can we confirm that it doesn't break functionality on the following:

* d2net            (MPP9_GPIO, /* Rear power switch (auto|off) */)
* db88f5281        (MPP9_GPIO, /* JP3, CON11.3 */)
* dns-323          (MPP9_GPIO, /* power button switch */)
* dns-323b         (MPP9_GPIO, /* power button switch */)
* dns-323c         (MPP9_GPIO, /* i/o left amber LED */)
* ls-chl           (MPP9_GPIO, /* USB POWER */)
* ls_hgl           (MPP9_GPIO, /* USB_PWR */)
* lsmini           (MPP9_GPIO, /* LED_FUNC */)
* mv2120           (MPP9_GPIO, /* SATA 1 fail LED */)
* net2big          (MPP9_GPIO, /* Rear power switch (auto|off) */)
* rd88f5181l-fxo   (MPP9_GPIO, /* GE_RXERR */)
* rd88f5181l-ge    (MPP9_GPIO, /* GE_RXERR */)
* terastation_pro2 (MPP9_GPIO, /* RTC int */)
* wnr854t          (MPP9_GIGE, /* GE_RXERR */)
* wrt350n-v2       (MPP9_GIGE, /* GE_RXERR */)

Also, while I'm looking at it, Is it correct that four boards
(rd88f5181l-*, wnr854t, wrt350n-v2) use the same pin for the same
purpose, two declare it as GPIO, and two as GIGE... :-/  Perhaps part of
the same problem?

thx,

Jason.

> 
> Ben.
> 
>  arch/arm/mach-orion5x/mpp.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/mpp.h b/arch/arm/mach-orion5x/mpp.h
> index eac6897..db70e79 100644
> --- a/arch/arm/mach-orion5x/mpp.h
> +++ b/arch/arm/mach-orion5x/mpp.h
> @@ -65,8 +65,8 @@
>  #define MPP8_GIGE               MPP(8,  0x1, 0, 0, 1,   1,   1)
>  
>  #define MPP9_UNUSED		MPP(9,  0x0, 0, 0, 1,   1,   1)
> -#define MPP9_GPIO		MPP(9,  0x0, 0, 0, 1,   1,   1)
> -#define MPP9_GIGE               MPP(9,  0x1, 1, 1, 1,   1,   1)
> +#define MPP9_GPIO		MPP(9,  0x0, 1, 1, 1,   1,   1)
> +#define MPP9_GIGE               MPP(9,  0x1, 0, 0, 1,   1,   1)
>  
>  #define MPP10_UNUSED		MPP(10, 0x0, 0, 0, 1,   1,   1)
>  #define MPP10_GPIO		MPP(10, 0x0, 1, 1, 1,   1,   1)
> -- 
> 1.7.9.5
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
