From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Jun 2015 14:05:59 -0300
Subject: imx: apf27: the board no longer boot with latest git kernel
In-Reply-To: <558EA370.6020108@gmail.com>
References: <558EA370.6020108@gmail.com>
Message-ID: <CAOMZO5AcRd8UJQg9MpV6mXJKkB2JMriGHzzKYS95oWQYzMOsuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Sat, Jun 27, 2015 at 10:21 AM, Philippe Reynes <tremyfr@gmail.com> wrote:
> Hi all,
>
> I've tested the lastest linus git kernel, and this kernel
> no longer boot on my armadeus apf27. The last line of the
> log are (after, the kernel is stalled) :
>
> [    0.000000] CPU identified as i.MX27, silicon rev 2.1
> [    0.000000] Switching to timer-based delay loop, resolution 60ns
> [    0.000024] sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every
> 129171917793ns
> [    0.008172] clocksource mxc_timer1: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 114963006693 ns
> [    0.020252] Console: colour dummy device 80x30
> [    0.024894] Calibrating delay loop (skipped), value calculated using
> timer frequency..
>
> I've done a bisect and the commit that raise this issue is :
> db2ae4b4f6b79bd11d6461d41bd0966b0006f20b
> ARM: imx: provide gpt device specific irq functions
>
> Do you also reproduce this issue please ? or may be I've missed
> to enable an new option ?

I don't have access to a mx27 board at the moment, but I am wondering
if the change below would fix the problem:

--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -528,6 +528,7 @@ static void __init imx6dl_timer_init_dt(struct device_node *
 }

 CLOCKSOURCE_OF_DECLARE(imx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx27_timer, "fsl,imx27-gpt", imx1_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx21_timer, "fsl,imx21-gpt", imx21_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx31_timer, "fsl,imx31-gpt", imx31_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(imx25_timer, "fsl,imx25-gpt", imx31_timer_init_dt);

Regards,

Fabio Estevam
