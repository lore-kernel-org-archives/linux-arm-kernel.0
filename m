From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 25 Jan 2016 10:30:22 -0800
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <874meddqu5.fsf@belgarion.home>
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home>
 <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home>
Message-ID: <20160125183022.GA41251@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Sun, Jan 17, 2016 at 12:53:06AM +0100, Robert Jarzmik wrote:
> Michael Wang <Michael.Wang@alliedtelesis.co.nz> writes:
> 
> > The complete output of debug traces and boot log from your debug patch
> > is in the attachment.
> 
> Okay, thanks, that's great.
> Might a ask another capture, but with :
>  1) the timestamps this time
>     (ie. CONFIG_PRINTK_TIME=y) ? This will give me the timing of your failure,
>     in the dmesg you will provide me.
>  2) on the first line of drain_fifo(), add a single :
>     nand_readl(info, NDSR)
> 
> This will enable me to see how your board behaves on the temporal aspect, as
> today I only have this, which looks correct AFAICT:
> 
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():445 nand_writel(0x1, NDECCCTRL)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():465 nand_writel(0xfff, NDSR)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():466 nand_writel(0x0, NDCR)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():467 nand_writel(0xd104b000, NDCR)
> 
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():656 nand_readl(NDSR): 0x1
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():706 nand_writel(0x1, NDSR)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():720 nand_writel(0x100d3000, NDCB0)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():721 nand_writel(0x4ff0000, NDCB0)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():722 nand_writel(0x2, NDCB0)
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():726 nand_writel(0x820, NDCB0)
>   => RJK: here the read command is submitted
> 
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():656 nand_readl(NDSR): 0x1800
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():706 nand_writel(0x1800, NDSR)
>   => RJK: here the read command is completed
> 
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():656 nand_readl(NDSR): 0x2
> pxa3xx-nand f10d0000.nand: Wait time out!!!
>   => RJK: here data is available in NAND controller, and yet it's too late
> 
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_stop():476 nand_readl(0x0000): 0xd104b000
> pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq_thread():636 nand_writel(0x6, 0x0014)
>   => RJK: here we finish the read data transfer operation, too late

I'm not extremely familiar with this driver, but you've caused me to
take a second look at this commit:

commit 24542257a3b987025d4b998ec2d15e556c98ad3f
Author: Robert Jarzmik <robert.jarzmik@free.fr>
Date:   Fri Feb 20 19:36:43 2015 +0100

    mtd: pxa3xx-nand: handle PIO in threaded interrupt


And now I'm wondering: when does the completion get triggered? i.e.:

	complete(&info->cmd_complete);

?

It seems to me like you've short-circuited some of the IRQ handling
code, so that the threaded handler is buggy. AIUI, if the completion
event ever happens, it's actually happening *before* the full (threaded)
handler is actually finished, since it occurs in pxa3xx_nand_irq(),
before pxa3xx_nand_irq_thread() ever runs. Now, I'm not sure if that
causes a real problem in practice, since you used IRQF_ONESHOT, but I
would think that's also suspect.

Brian
