From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 18 Jan 2016 22:13:20 +0100
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <569C4ABD.6080803@alliedtelesis.co.nz> (Michael Wang's message of
 "Mon, 18 Jan 2016 02:15:31 +0000")
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home> <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home> <569C4ABD.6080803@alliedtelesis.co.nz>
Message-ID: <87wpr6d21b.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Wang <Michael.Wang@alliedtelesis.co.nz> writes:

> On 01/17/2016 12:53 PM, Robert Jarzmik wrote:
>> Might a ask another capture, but with :
>>   1) the timestamps this time
>>      (ie. CONFIG_PRINTK_TIME=y) ? This will give me the timing of your failure,
>>      in the dmesg you will provide me.
>>   2) on the first line of drain_fifo(), add a single :
>>      nand_readl(info, NDSR)
>>
>> This will enable me to see how your board behaves on the temporal aspect, as
>> today I only have this, which looks correct AFAICT
> Hi Robert,
>
> Thank you for your analysis.
>
> The attachment file contains the complete debug output with the 
> additional info you requested.
>
> I just want to mention that I get slightly different results on my board 
> with debugs enabled/disabled.
>
> Without your debugs, the kernel will fail to boot up properly with 
> command timing out and nand
> controller in invalid state:
>  >pxa3xx-nand f10d0000.nand: Wait time out!!!
>  >pxa3xx-nand f10d0000.nand: handle_data_pio: invalid state 0
>
> With your debugs, commands still time out a few times, but 
> handle_data_pio() doesn't get into
> invalid state and the kernel boots up fine.

Ok, I analysed with the timings, and now I'm pretty against the timeout change
if the analysis below is correct.

See in the log extract in [1], you have a contiguous sequence of one working
read followed by one broken read :
 - in the working read, the irq thread is scheduled in 8ms, which is pretty
   decent.
 - in the broken read, the irq thread is scheduled in 160ms, which is just
   unbearable.

>From this analysis I think you have something broken in your platform, a driver
taking a lock and blocking the scheduling or something like that. Your timeouts
seem to come from there.

If you want to add 2 prinks to validate the theory (and remove my debug logs
which change the realtime behavior) :
 - put one just before the "ret = IRQ_WAKE_THREAD";
 - put the other on the first line of pxa3xx_nand_irq_thread()
 - and calculate the difference. 

Cheers.

--
Robert

[1] Extract of your log
	=> RJK: begin of the working read
[ 2172.409771] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():445 nand_writel(0x1, NDECCCTRL)
[ 2172.417844] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():465 nand_writel(0xfff, NDSR)
[ 2172.426084] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():466 nand_writel(0x0, NDCR)
[ 2172.434147] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():467 nand_writel(0xd104b000, NDCR)
[ 2172.442823] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():658 nand_readl(NDSR): 0x1
[ 2172.450608] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():708 nand_writel(0x1, NDSR)
[ 2172.458479] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():722 nand_writel(0x300d3000, NDCB0)
[ 2172.466961] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():723 nand_writel(0x7fcb0000, NDCB0)
[ 2172.475442] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():724 nand_writel(0x3, NDCB0)
[ 2172.483312] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():728 nand_writel(0x820, NDCB0)
[ 2172.491450] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():658 nand_readl(NDSR): 0x2
[ 2172.499259] pxa3xx-nand f10d0000.nand: drain_fifo():509 nand_readl(NDSR): 0x2
	=> RJK: here the irq thread was scheduled in 8ms
[ 2172.506741] pxa3xx-nand f10d0000.nand: drain_fifo():509 nand_readl(NDSR): 0x2
[ 2172.514106] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq_thread():638 nand_writel(0x6, NDSR)
[ 2172.522606] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():658 nand_readl(NDSR): 0x500
[ 2172.530565] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():708 nand_writel(0x500, NDSR)
	=> RJK: begin of the broken read
[ 2172.538671] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():445 nand_writel(0x1, NDECCCTRL)
[ 2172.546753] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():465 nand_writel(0xfff, NDSR)
[ 2172.554991] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():466 nand_writel(0x0, NDCR)
[ 2172.563050] pxa3xx-nand f10d0000.nand: pxa3xx_nand_start():467 nand_writel(0xd104b000, NDCR)
[ 2172.571722] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():658 nand_readl(NDSR): 0x1
[ 2172.579508] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():708 nand_writel(0x1, NDSR)
[ 2172.587379] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():722 nand_writel(0x100d3000, NDCB0)
[ 2172.595860] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():723 nand_writel(0xfefd0000, NDCB0)
[ 2172.604341] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():724 nand_writel(0x2, NDCB0)
[ 2172.612212] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():728 nand_writel(0x820, NDCB0)
[ 2172.620319] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():658 nand_readl(NDSR): 0x1800
[ 2172.628367] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():708 nand_writel(0x1800, NDSR)
[ 2172.636519] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq():658 nand_readl(NDSR): 0x2
[ 2172.798485] pxa3xx-nand f10d0000.nand: drain_fifo():509 nand_readl(NDSR): 0x2
	=> RJK: here the irq thread was scheduled in 160ms
[ 2172.805996] pxa3xx-nand f10d0000.nand: drain_fifo():509 nand_readl(NDSR): 0x2
[ 2172.813379] pxa3xx-nand f10d0000.nand: pxa3xx_nand_irq_thread():638 nand_writel(0x6, NDSR)
[ 2172.821017] pxa3xx-nand f10d0000.nand: Wait time out!!!
[ 2172.821029] pxa3xx-nand f10d0000.nand: pxa3xx_nand_stop():476 nand_readl(NDCR): 0xc104b000
[ 2172.821038] pxa3xx-nand f10d0000.nand: pxa3xx_nand_stop():487 nand_writel(0xfff, NDSR)
