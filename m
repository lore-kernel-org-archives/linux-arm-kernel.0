From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Jul 2014 15:04:12 +0800
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
Message-ID: <20140714070341.GC2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy more i.MX people ...

On Fri, Jul 11, 2014 at 08:34:19AM -0700, Tim Harvey wrote:
> Shawn,
> 
> I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
> for gpio's configured as outputs regardless of if they are outputing
> high or low.
> 
> Digging into gpio-mxc.c I see that the basic memory-mapped generic
> gpio controller is used, but its configured to use GPIO_PSR to obtain
> the gpio value. For the IMX6 (I can't speak for the other MXC/IMX
> users of this driver) the reference manual indicates that GPIO_PSR is
> appropriate only if the GPIO is an input and that GPIO_DR will read
> the proper state if its configured as an output or an input.


The following note can be found in i.MX Reference Manual.

			NOTE
While the GPIO direction is set to input (GPIO_GDIR = 0), a
read access to GPIO_DR does not return GPIO_DR data.
Instead, it returns the GPIO_PSR data, which is the
corresponding input signal value.

That said for an input GPIO, reading GPIO_DR functionally equals to
reading GPIO_PSR.  So reading either GPIO_DR or GPIO_PSR returns what we
want to get.

The remain question is what we want to get from an output GPIO, the
value that register GPIO_DR holds or the one driven on pad.  I *think*
both should be identical (but not so sure).  If that's the case, reading
GPIO_DR should just work.  But otherwise, we should read GPIO_PSR with
SION bit set to get what is actually driven on pad.

> 
> Even before the driver was converted to use the basic memory-mapped
> generic gpio controller this was the case (GPIO_PSR used for get). Is
> there a reason for this, or is it simply a bug that has been around
> since the driver's original creation as I suspect?
> 
> The following patch resolves the issue and causes gpio get to always
> return the proper setting when configured for an input or output:
> 
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 7176743..25b97db 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -458,8 +458,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>         }
> 
>         err = bgpio_init(&port->bgc, &pdev->dev, 4,
> -                        port->base + GPIO_PSR,
> -                        port->base + GPIO_DR, NULL,
> +                        port->base + GPIO_DR,
> +                        NULL, NULL,
>                          port->base + GPIO_GDIR, NULL, 0);
>         if (err)
>                 goto out_iounmap;
> 
> If this looks right to you for all IMX users let me know and I'll post
> a properly formatted patch with commit message.

So the question comes down to, for an output GPIO, whether the value in
GPIO_DR register is always identical to what we see on the pad.  If yes,
your patch makes sense to me.  Otherwise, we have to set SION bit to
read the value of an output GPIO from GPIO_PSR.

Shawn

> 
> Regards,
> 
> Tim
