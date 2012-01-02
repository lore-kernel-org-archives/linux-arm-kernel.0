From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 2 Jan 2012 09:25:34 +0000
Subject: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
In-Reply-To: <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 11, 2011 at 15:31:52, R, Govindraj wrote:
[...]
>  
> -	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
> +	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
> +			&& !uart_debug)
>  		device_init_wakeup(&pdev->dev, true);
>  }

I was testing this on AM335x and realized that this leads to creation of two
'wakeup' entries for UART. One is created by the tty layer in serial-core.c
and the other is created here.

Here's what I see on a branch based on Tony's 3.2-rc6:

./sys/devices/platform/omap/omap_uart.0/power/wakeup
./sys/devices/platform/omap/omap_uart.0/tty/ttyO0/power/wakeup

Shouldn't the OMAP serial just enable the 'wakeup' entry created by serial-core.c?

Regards,
Vaibhav
