From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 8 Jul 2011 10:25:40 +0300
Subject: mx25 gpt-clock issue, waits are too long
In-Reply-To: <3F263ABB4EDE344D974E1983B56807734FF6B38D@EX-DAG01.eckelmann.group>
References: <3F263ABB4EDE344D974E1983B56807734FF6B38D@EX-DAG01.eckelmann.group>
Message-ID: <20110708072539.GA13020@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Torsten,

On Mon, Jul 04, 2011 at 03:24:25PM +0000, Mehnert, Torsten wrote:
> i am using barebox and standard linux (2.6.39.1) on my mx25 board. Under 
> linux i now have the problem
> that a sleepwait or busywait results in a factor 1.8 too long waiting time.  
> So sleep(10) results in ~18 seconds
> of waiting.
> 
> I see through the clock registers
> and found that the clock source of the general purpose timer is set to 
> UPLL(240MHz), divided by 2 its 120MHz.
> So when 120Mhz is factor 1.8 too much, then the correct value should be 
> 66MHz. As this value can't be divided from
> UPLL i changed the clock source to AHB_DIV(133MHz), get the 66MHz and my 
> sleep(10) are the proper 10 seconds.
> I think that the clock-mx25.c expected the CCM_MCR register to be cleared 
> completely, which it's not in my case.
> 
> I tested this issue again on the mx25-3stack evaluation board, with the same result.
> 
> Old Kernel message: sched_clock: 32 bits at 120MHz, resolution 8ns, wraps every 35791ms
> New Kernel message: sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 64585ms

You should Cc Sascha Hauer <kernel@pengutronix.de> on i.MX related patches.  
Also, see the tread at 
http://thread.gmane.org/gmane.linux.ports.arm.kernel/72944, and especially the 
note of Rob Herring of (then) Freescale.

baruch

> This patch fixes this issue:
> 
> Request for comment and feedback.
> 
> From: T. Mehnert <t.mehnert@eckelmann.de>
> Date: Mon, 4 Jul 2011 15:53:30 +0200
> Subject: [PATCH] GPT clock fix: corrected the clock source
> 
> This patch changes the clock source for the general purpose timer
> of the arm/mx25 from UPLL to AHB_DIV. This fixes the problem,
> that sleep/busy wating waits factor 1.8 too long.
> 
> Signed-off-by: Torsten Mehnert <t.mehnert@eckelmann.de>
> ---
>  arch/arm/mach-imx/clock-imx25.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
> index a65838f..bf1ecda 100644
> --- a/arch/arm/mach-imx/clock-imx25.c
> +++ b/arch/arm/mach-imx/clock-imx25.c
> @@ -328,6 +328,10 @@ int __init mx25_clocks_init(void)
>         __raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
>                         CRM_BASE + 0x64);
> 
> +       /* Clock source for gpt is ahb_div */
> +       __raw_writel(__raw_readl(CRM_BASE+0x64) & ~(1 << 5),
> +                       CRM_BASE + 0x64);
> +
>         mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
> 
>         return 0;
> --

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
