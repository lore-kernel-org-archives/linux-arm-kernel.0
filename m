From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 11 Jul 2014 08:34:19 -0700
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
Message-ID: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
for gpio's configured as outputs regardless of if they are outputing
high or low.

Digging into gpio-mxc.c I see that the basic memory-mapped generic
gpio controller is used, but its configured to use GPIO_PSR to obtain
the gpio value. For the IMX6 (I can't speak for the other MXC/IMX
users of this driver) the reference manual indicates that GPIO_PSR is
appropriate only if the GPIO is an input and that GPIO_DR will read
the proper state if its configured as an output or an input.

Even before the driver was converted to use the basic memory-mapped
generic gpio controller this was the case (GPIO_PSR used for get). Is
there a reason for this, or is it simply a bug that has been around
since the driver's original creation as I suspect?

The following patch resolves the issue and causes gpio get to always
return the proper setting when configured for an input or output:

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 7176743..25b97db 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -458,8 +458,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
        }

        err = bgpio_init(&port->bgc, &pdev->dev, 4,
-                        port->base + GPIO_PSR,
-                        port->base + GPIO_DR, NULL,
+                        port->base + GPIO_DR,
+                        NULL, NULL,
                         port->base + GPIO_GDIR, NULL, 0);
        if (err)
                goto out_iounmap;

If this looks right to you for all IMX users let me know and I'll post
a properly formatted patch with commit message.

Regards,

Tim
