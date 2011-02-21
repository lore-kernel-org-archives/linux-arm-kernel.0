From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 21 Feb 2011 14:14:39 +0300
Subject: [PATCH 2/2] DM9000B: Fix PHY power for network down/up
In-Reply-To: <4D618B5D.5040001@henry.nestler.mail.gmail.com>
References: <4D618B5D.5040001@henry.nestler.mail.gmail.com>
Message-ID: <4D62491F.4050602@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-02-2011 0:45, Henry Nestler wrote:

> DM9000 revision B needs 1 ms delay after PHY power on (see spec), and PHY
> power must on in register

    Couldn't parse that.

> DM9000_GPR before all other settings will change.
> Remember, that register DM9000_GPR was not changed by reset sequence.

> Without these fix the FIFO goes out of sync and sends wrong data after

    s/these/this/

> sequence of "ifconfig ethX down ; sleep 3 ; ifconfig ethX up".
[...]

> diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
> index 2d4c4fc..5925569 100644
> --- a/drivers/net/dm9000.c
> +++ b/drivers/net/dm9000.c
[...]
> @@ -1194,6 +1191,10 @@ dm9000_open(struct net_device *dev)
>   	if (request_irq(dev->irq, dm9000_interrupt, irqflags, dev->name, dev))
>   		return -EAGAIN;
>
> +	/* GPIO0 on pre-activate PHY, Reg 1F is not set by reset */
> +	iow(db, DM9000_GPR, 0);	/* REG_1F bit0 activate phyxcer */
> +	udelay(1000); /* delay needs by DM9000B */

    Why not mdelay(1)?

WBR, Sergei
