From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 07 Mar 2014 16:46:21 -0800
Subject: [BUG] atmel: spi: scheduling while atomic
In-Reply-To: <20140307225810.GB2918@piout.net>
References: <5315E33C.5000205@aksignal.cz> <20140304214039.GA4441@piout.net>
 <5316CA84.4080907@aksignal.cz> <20140307225810.GB2918@piout.net>
Message-ID: <531A685D.2010802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/14 14:58, Alexandre Belloni wrote:
> Hi,
>
> On 05/03/2014 at 07:56:04 +0100, Ji?? Prchal wrote :
>> Hi Alex,
>> I have a bad news, disabling dma does not help.
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 3.14.0-rc4_cpm9g25+ (prchal at prchal)
>> (gcc version 4.5.2 (GCC) ) #1 PREEMPT Tue Mar 4 14:28:23 CET 2014
>> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
>> ...
>> [    0.878906] atmel_spi f0000000.spi: version: 0x212
>> [    0.882812] of_dma_request_slave_channel: dma-names property of node '/ahb/apb/spi at f0000000' missing or empty
>> [    0.886718] atmel_spi f0000000.spi: DMA TX channel not available, SPI unable to use DMA
>> [    0.890625] atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
>> [    0.894531] atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 28)
>> ...
>> [    0.902343] BUG: scheduling while atomic: spi0/383/0x00000002
>> [    0.906250] Modules linked in:
>> [    0.906250] CPU: 0 PID: 383 Comm: spi0 Not tainted 3.14.0-rc4_cpm9g25+ #1
>> [    0.906250] [<c000d9f4>] (unwind_backtrace) from [<c000bdc0>] (show_stack+0x10/0x14)
>> [    0.906250] [<c000bdc0>] (show_stack) from [<c003a224>] (__schedule_bug+0x48/0x60)
>> [    0.906250] [<c003a224>] (__schedule_bug) from [<c0390294>] (__schedule+0x60/0x484)
>> [    0.906250] [<c0390294>] (__schedule) from [<c038feac>] (schedule_timeout+0x17c/0x1ac)
>> [    0.906250] [<c038feac>] (schedule_timeout) from [<c039111c>] (wait_for_common+0x10c/0x1f0)
>> [    0.906250] [<c039111c>] (wait_for_common) from [<c0249228>] (atmel_spi_transfer_one_message+0x71c/0xa48)
>> [    0.906250] [<c0249228>] (atmel_spi_transfer_one_message) from [<c0246624>] (spi_pump_messages+0x210/0x238)
>> [    0.906250] [<c0246624>] (spi_pump_messages) from [<c00343d0>] (kthread_worker_fn+0x15c/0x1b4)
>> [    0.906250] [<c00343d0>] (kthread_worker_fn) from [<c0034534>] (kthread+0xb8/0xcc)
>> [    0.906250] [<c0034534>] (kthread) from [<c0009510>] (ret_from_fork+0x14/0x24)
>> [    0.906250] at25 spi0.0: 128 KByte at25 eeprom, pagesize 512
>> ...
>> [   62.527343] BUG: scheduling while atomic: spi0/383/0x00000002
>> [   62.531250] Modules linked in:
>> [   62.531250] CPU: 0 PID: 383 Comm: spi0 Tainted: G        W    3.14.0-rc4_cpm9g25+ #1
>> [   62.531250] [<c000d9f4>] (unwind_backtrace) from [<c000bdc0>] (show_stack+0x10/0x14)
>> [   62.531250] [<c000bdc0>] (show_stack) from [<c003a224>] (__schedule_bug+0x48/0x60)
>> [   62.531250] [<c003a224>] (__schedule_bug) from [<c0390294>] (__schedule+0x60/0x484)
>> [   62.531250] [<c0390294>] (__schedule) from [<c038feac>] (schedule_timeout+0x17c/0x1ac)
>> [   62.531250] [<c038feac>] (schedule_timeout) from [<c039111c>] (wait_for_common+0x10c/0x1f0)
>> [   62.531250] [<c039111c>] (wait_for_common) from [<c0249228>] (atmel_spi_transfer_one_message+0x71c/0xa48)
>> [   62.531250] [<c0249228>] (atmel_spi_transfer_one_message) from [<c0246624>] (spi_pump_messages+0x210/0x238)
>> [   62.531250] [<c0246624>] (spi_pump_messages) from [<c00343d0>] (kthread_worker_fn+0x15c/0x1b4)
>> [   62.531250] [<c00343d0>] (kthread_worker_fn) from [<c0034534>] (kthread+0xb8/0xcc)
>> [   62.531250] [<c0034534>] (kthread) from [<c0009510>] (ret_from_fork+0x14/0x24)
>>
>>
> So I tried, both with an at91sam9rl-ek and an at91sam9m10-g45-ek and I
> don't observe that warning. Those boards have an AT45 dataflash do you
> see that with other spi devices if you have any ?
>
> Actually, I'm not quite sure how spi_pump_messages can be called from an
> atomic context.

It isn't. It looks like atmel_spi_transfer_one_message() calls
atmel_spi_lock() which is a thing wrapper around spinlock_irqsave() and
then atmel_spi_one_transfer() is called which eventually calls
wait_for_completion_timeout().

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
