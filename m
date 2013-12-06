From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 06 Dec 2013 14:34:17 +0400
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <20131206095345.GQ16425@us.netrek.org>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <20131206000253.GC21358@kroah.com>
 <20131206001728.GJ4360@n2100.arm.linux.org.uk>
 <1386322131.7152.36.camel@host5.omatika.ru>
 <20131206095345.GQ16425@us.netrek.org>
Message-ID: <1386326057.7152.44.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-12-06 at 20:53 +1100, James Cameron wrote:
> I don't understand why /dev/ttyS2 (4,66) changed to /dev/ttyS0 (4,64)
> after the patch was applied to olpc-kernel/arm-3.5 but, as you say it
> doesn't change, perhaps there is something between 3.5 and now for me
> to watch out for.  My problem.

The old pxa.c set device ids explicitly:
-static int serial_pxa_probe_dt(struct platform_device *pdev,
-                              struct uart_pxa_port *sport)
-{
-       struct device_node *np = pdev->dev.of_node;
-       int ret;
-
-       if (!np)
-               return 1;
-
-       ret = of_alias_get_id(np, "serial");
-       if (ret < 0) {
-               dev_err(&pdev->dev, "failed to get alias id, errno %d
\n", ret);
-               return ret;
-       }
-       sport->port.line = ret;
-       return 0;
-}

and

-       ret = serial_pxa_probe_dt(dev, sport);
-       if (ret > 0)
-               sport->port.line = dev->id;


However, this is not possible with 8250_core. The latter assigns device
ids strictly in the call order of serial8250_register_8250_port().

Hope it helps.
