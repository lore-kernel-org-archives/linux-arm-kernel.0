From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Dec 2011 16:17:04 -0200
Subject: [PATCH v4] tty: serial: imx: Allow UART to be a source for wakeup
In-Reply-To: <20111211060133.GA9470@S2100-06.ap.freescale.net>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
 <1323456065-6240-1-git-send-email-festevam@gmail.com>
 <20111211060133.GA9470@S2100-06.ap.freescale.net>
Message-ID: <CAOMZO5DM_eDZqbxsNKYvwgP+qjr=yoLHrWHuZb-PQn9xWZpsrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2011 at 4:01 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

>> + ? ? device_init_wakeup(&pdev->dev, 1);
>> + ? ? device_set_wakeup_enable(&pdev->dev, 0);
>> +
> Rather than calling these two functions, simply calling
>
> ? ? ? ?device_set_wakeup_capable(&pdev->dev, true);
>
> can just do what we want to do here.

Yes, this is correct.

After checking the code it seems to me that  neither of this calls are needed.

serial_core.c already calls:
		device_init_wakeup(tty_dev, 1);
		device_set_wakeup_enable(tty_dev, 0);

and we can see a wakeup entry at:

/sys/devices/platform/imx21-uart.0/tty/ttymxc0/power/wakeup

However, if I send "enabled" to this file the
"if (device_may_wakeup(&dev->dev)" statement is never true.

I am not sure what would be the correct argument for device_may_wakeup
to "see" the original wakeup entry.

Regards,

Fabio Estevam



>
> Other than that,
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> (Tested on i.MX6Q ARM2 board)
>
> --
> Regards,
> Shawn
>
