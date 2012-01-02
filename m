From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 2 Jan 2012 16:00:37 +0530
Subject: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
 <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
Message-ID: <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

On Mon, Jan 2, 2012 at 2:55 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> Hello,
>
> On Fri, Nov 11, 2011 at 15:31:52, R, Govindraj wrote:
> [...]
>>
>> - ? ? if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
>> + ? ? if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
>> + ? ? ? ? ? ? ? ? ? ? && !uart_debug)
>> ? ? ? ? ? ? ? device_init_wakeup(&pdev->dev, true);
>> ?}
>
> I was testing this on AM335x and realized that this leads to creation of two
> 'wakeup' entries for UART. One is created by the tty layer in serial-core.c
> and the other is created here.
>
> Here's what I see on a branch based on Tony's 3.2-rc6:
>
> ./sys/devices/platform/omap/omap_uart.0/power/wakeup
> ./sys/devices/platform/omap/omap_uart.0/tty/ttyO0/power/wakeup
>
> Shouldn't the OMAP serial just enable the 'wakeup' entry created by serial-core.c?

currently runtime pm is available from omap-serial device and not from tty_dev.
Setting tty_dev wakeup is to use irq_wakeup from suspend available
from serail_core layer which I think we are not using for omap-uart
and we use pad wakeup from suspend path.

Also omap-uart.x/power/wakeup is used to gate uart clocks using runtime
PM api's in omap-serial driver.

--
Thanks,
Govindraj.R
