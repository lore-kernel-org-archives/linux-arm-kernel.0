From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 27 Jun 2012 21:53:52 +0200 (CEST)
Subject: [PATCH] rtc: rtc-mxc: fix irq enabled interrupts warning
In-Reply-To: <2125427519.2533544.1339534219329.JavaMail.root@advansee.com>
Message-ID: <1277218263.182768.1340826832378.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing more people.

On Tue, Jun 12, 2012 at 10:50:19PM +0200, Beno?t Th?baudeau wrote:
> [   29.669224] WARNING: at /linux/kernel/irq/handle.c:146
> handle_irq_event_percpu+0x19c/0x1b8()
> [   29.669269] irq 25 handler mxc_rtc_interrupt+0x0/0xac enabled
> interrupts
> [   29.669284] Modules linked in:
> [   29.669324] [<c0012218>] (unwind_backtrace+0x0/0xf0) from
> [<c001c1dc>] (warn_slowpath_common+0x4c/0x64)
> [   29.669361] [<c001c1dc>] (warn_slowpath_common+0x4c/0x64) from
> [<c001c288>] (warn_slowpath_fmt+0x30/0x40)
> [   29.669399] [<c001c288>] (warn_slowpath_fmt+0x30/0x40) from
> [<c004c46c>] (handle_irq_event_percpu+0x19c/0x1b8)
> [   29.669439] [<c004c46c>] (handle_irq_event_percpu+0x19c/0x1b8)
> from [<c004c4b0>] (handle_irq_event+0x28/0x38)
> [   29.669479] [<c004c4b0>] (handle_irq_event+0x28/0x38) from
> [<c004e4b0>] (handle_level_irq+0x80/0xc4)
> [   29.669517] [<c004e4b0>] (handle_level_irq+0x80/0xc4) from
> [<c004bcd0>] (generic_handle_irq+0x24/0x38)
> [   29.669563] [<c004bcd0>] (generic_handle_irq+0x24/0x38) from
> [<c000e6cc>] (handle_IRQ+0x30/0x84)
> [   29.669599] [<c000e6cc>] (handle_IRQ+0x30/0x84) from [<c0008508>]
> (avic_handle_irq+0x2c/0x4c)
> [   29.669633] [<c0008508>] (avic_handle_irq+0x2c/0x4c) from
> [<c000db40>] (__irq_svc+0x40/0x60)
> [   29.669655] Exception stack(0xc050bf60 to 0xc050bfa8)
> [   29.669685] bf60: 00000001 00000000 003c4208 c0018e20 c050a000
> c050a000 c054a4c8 c050a000
> [   29.669717] bf80: c05157a8 4117b363 80503bb4 00000000 01000000
> c050bfa8 c0018e2c c000e808
> [   29.669739] bfa0: 60000013 ffffffff
> [   29.669769] [<c000db40>] (__irq_svc+0x40/0x60) from [<c000e808>]
> (default_idle+0x1c/0x30)
> [   29.669805] [<c000e808>] (default_idle+0x1c/0x30) from
> [<c000e9bc>] (cpu_idle+0x68/0xa8)
> [   29.669846] [<c000e9bc>] (cpu_idle+0x68/0xa8) from [<c04e76dc>]
> (start_kernel+0x22c/0x26c)
> [   29.669868] ---[ end trace 2f7406c4b6216986 ]---
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> Cc: <rtc-linux@googlegroups.com>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../drivers/rtc/rtc-mxc.c                          |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git linux-next-HEAD-c90e5d2.orig/drivers/rtc/rtc-mxc.c
> linux-next-HEAD-c90e5d2/drivers/rtc/rtc-mxc.c
> index 5e1d64e..e3e50d6 100644
> --- linux-next-HEAD-c90e5d2.orig/drivers/rtc/rtc-mxc.c
> +++ linux-next-HEAD-c90e5d2/drivers/rtc/rtc-mxc.c
> @@ -202,10 +202,11 @@ static irqreturn_t mxc_rtc_interrupt(int irq,
> void *dev_id)
>  	struct platform_device *pdev = dev_id;
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
>  	void __iomem *ioaddr = pdata->ioaddr;
> +	unsigned long flags;
>  	u32 status;
>  	u32 events = 0;
>  
> -	spin_lock_irq(&pdata->rtc->irq_lock);
> +	spin_lock_irqsave(&pdata->rtc->irq_lock, flags);
>  	status = readw(ioaddr + RTC_RTCISR) & readw(ioaddr + RTC_RTCIENR);
>  	/* clear interrupt sources */
>  	writew(status, ioaddr + RTC_RTCISR);
> @@ -224,7 +225,7 @@ static irqreturn_t mxc_rtc_interrupt(int irq,
> void *dev_id)
>  		events |= (RTC_PF | RTC_IRQF);
>  
>  	rtc_update_irq(pdata->rtc, 1, events);
> -	spin_unlock_irq(&pdata->rtc->irq_lock);
> +	spin_unlock_irqrestore(&pdata->rtc->irq_lock, flags);
>  
>  	return IRQ_HANDLED;
>  }
> 
