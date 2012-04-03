From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 3 Apr 2012 20:43:07 +0300
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <20120403170812.GR17741@mudshark.cambridge.arm.com>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
 <20120402200034.GL5812@mwesterb-mobl.ger.corp.intel.com>
 <20120402214614.GK24211@n2100.arm.linux.org.uk>
 <20120403170812.GR17741@mudshark.cambridge.arm.com>
Message-ID: <20120403174307.GM5812@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 06:08:12PM +0100, Will Deacon wrote:

> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index dcb004a..cb6b49a 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -441,11 +441,9 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
>         u32 stat, irq;
>         int handled = 0;
>  
> -       stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> -       while (stat) {
> +       while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
>                 irq = ffs(stat) - 1;
>                 handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> -               stat &= ~(1 << irq);
>                 handled = 1;
>         }
> 

I can confirm that the above patch fixes spurious interrupts on ep93xx.
