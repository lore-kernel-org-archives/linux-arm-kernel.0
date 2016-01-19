From: Michael.Wang@alliedtelesis.co.nz (Michael Wang)
Date: Tue, 19 Jan 2016 22:33:46 +0000
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <87wpr6d21b.fsf@belgarion.home>
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home> <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home> <569C4ABD.6080803@alliedtelesis.co.nz>
 <87wpr6d21b.fsf@belgarion.home>
Message-ID: <569EB9CA.9080201@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2016 10:13 AM, Robert Jarzmik wrote:
>  From this analysis I think you have something broken in your platform, a driver
> taking a lock and blocking the scheduling or something like that. Your timeouts
> seem to come from there.
>
> If you want to add 2 prinks to validate the theory (and remove my debug logs
> which change the realtime behavior) :
>   - put one just before the "ret = IRQ_WAKE_THREAD";
>   - put the other on the first line of pxa3xx_nand_irq_thread()
>   - and calculate the difference.
Hi Robert,

Thank you very much for your help.

I have added the 2 printks, and I think you are right that there is 
something
blocking the scheduling.

[  146.372745] pxa3xx_nand_irq:700 IRQ_WAKE_THREAD status=2
[  146.378106] pxa3xx_nand_irq_thread:643
[  146.411117] pxa3xx_nand_irq:700 IRQ_WAKE_THREAD status=2
[  146.537124] pxa3xx_nand_irq_thread:643
       => irq thread was scheduled in 0.126 ms
[  146.541245] pxa3xx_nand_irq:700 IRQ_WAKE_THREAD status=2
[  146.546603] pxa3xx_nand_irq_thread:643

I will continue to investigate the cause of this delay.

Thanks,
Michael
