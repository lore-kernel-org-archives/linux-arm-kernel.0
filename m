From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 26 Jan 2016 10:03:57 -0300
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <87fuxl9yil.fsf@belgarion.home>
References: <5695CEF0.1080100@alliedtelesis.co.nz>
 <87a8o9ex9r.fsf@belgarion.home>
 <569827BC.10601@alliedtelesis.co.nz>
 <874meddqu5.fsf@belgarion.home> <20160125183022.GA41251@google.com>
 <87fuxl9yil.fsf@belgarion.home>
Message-ID: <CAAEAJfCNzh9+zRq_Yb=hFyLfP8RFoX+LUsDL4dVwUenVc_gVOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 January 2016 at 17:48, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Brian Norris <computersforpeace@gmail.com> writes:
>
>> Hi Robert,
>>
>> On Sun, Jan 17, 2016 at 12:53:06AM +0100, Robert Jarzmik wrote:
>> commit 24542257a3b987025d4b998ec2d15e556c98ad3f
>> Author: Robert Jarzmik <robert.jarzmik@free.fr>
>> Date:   Fri Feb 20 19:36:43 2015 +0100
>>
>>     mtd: pxa3xx-nand: handle PIO in threaded interrupt
>>
>>
>> And now I'm wondering: when does the completion get triggered? i.e.:
>>
>>       complete(&info->cmd_complete);
>
>> It seems to me like you've short-circuited some of the IRQ handling
>> code, so that the threaded handler is buggy. AIUI, if the completion
>> event ever happens, it's actually happening *before* the full (threaded)
>> handler is actually finished, since it occurs in pxa3xx_nand_irq(),
>> before pxa3xx_nand_irq_thread() ever runs. Now, I'm not sure if that
>> causes a real problem in practice, since you used IRQF_ONESHOT, but I
>> would think that's also suspect.
>
> I think you're very right, this "goto NORMAL_IRQ_EXIT" creates a
> short-cirtcuit. That makes me think that I should :
>  - add
> static void pxa3xx_nand_data_finished(struct pxa3xx_nand_info *info)
> {
>         unsigned int done;
>
>         cmd_done = info->cs ? NDSR_CS1_CMDD : NDSR_CS0_CMDD;
>         nand_writel(info, NDSR, cmd_done);
>         complete(&inf0->cmd_complete);
> }
>
>  - in pxa3xx_nand_irq_thread(), I should add at the end:
>         pxa3xx_nand_data_finished(info);
>
>  - in pxa3xx_nand_data_dma_irq(), I should add at the end:
>         pxa3xx_nand_data_finished(info);
>
> Ezequiel, would you have a look at that code snippet and tell me if I'm missing
> something in the driver's structure ?
>

Although it seems Brian is right, I'm not so sure about it. As far as
I can recall, the IRQ sequence is (please correct me if I'm wrong!):

1. Write command request (WRCMDREQ), the IRQ handler writes the command.
2. Read/write data request (RDDREQ | WRDREQ). The IRQ handler fires
the threaded handler, which does data transfer.
3. Command done IRQ (CMDD), the IRQ handler completes the completion.

I don't think data request and command done can be found
simultaneously, so I don't think this is a real issue. Ideas?

Regarding the fixed proposed up there, it seems wrong: the completion
should be completed only after a command done IRQ is found, and not as
the result of data transfer being finished.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
