From: koen.beel.barco@gmail.com (Koen Beel)
Date: Tue, 9 Aug 2011 10:25:47 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <4E40ED4B.6030302@freescale.com>
References: <20110805135133.GA26981@pengutronix.de>
	<4E3F8087.6070206@freescale.com>
	<CAHMSPgMYP+5Hpa5sC-yt=1H-S=tEER8uNzj6uMSK403_DGYJ9Q@mail.gmail.com>
	<4E3FBC75.7010703@freescale.com>
	<CAHMSPgMdBmmNG41_QgGivSb+M1rG5nqJjtveyZueKHHJrA8vzA@mail.gmail.com>
	<4E40D563.2090202@freescale.com>
	<CAHMSPgPzVordYOn5wgp0OZLGbAqkSGKJxDre8bvRpTyAz85udw@mail.gmail.com>
	<4E40ED4B.6030302@freescale.com>
Message-ID: <CAHMSPgO=ZvjwUKmgYFSAMrQQXhzCLaX-xsw72Caa+h3+u7-E7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 10:18 AM, Huang Shijie <b32955@freescale.com> wrote:
> Hi Koen:
> thanks for your test.
>>
>> Hi,
>>
>>
>>
>> On Tue, Aug 9, 2011 at 8:36 AM, Huang Shijie<b32955@freescale.com> ?wrote:
>>>
>>> Hi Koen:
>>>>
>>>> Hi,
>>>>
>>>> On Mon, Aug 8, 2011 at 12:37 PM, Huang Shijie<b32955@freescale.com>
>>>> ?wrote:
>>>>>
>>>>> Hi,
>>>>>>
>>>>>> On my target, the mxs-dma is working for sdio until the gpmi-nand
>>>>>> gives a timeout. After that the dma for sdio is *not fully* working
>>>>>> anymore.
>>>>>>
>>>>> We need more log in following aspects:
>>>>> [1] apbh-dma registers
>>>>> [2] clk registers
>>>>> [3] gpmi registers
>>>>>
>>>>> Please git-apply the patch in the attachment.
>>>>> It will print out more DMA information WHEN dma-timeout occur.
>>>>
>>>> Don't get it. What exactly are you trying to dump?
>>>> This patch dumps CTRL0, CTRL1, CTRL2, DEVSEL but also some registers
>>>> of APBH channel0 which is reserved....
>>>
>>> sorry, I intended to print out the channel 4(NAND_DEVICE0).
>>>
>>> I want to know that:
>>> ?When the dma timeout occurs, whether it caused by the GPMI or by the DMA
>>> itself.
>>
>> Ok, I was a little confused about the addresses, but it seems like you
>> are using mx28 (and corresponding addresses). APBH dma for mx23 has
>> different address according to the datasheet.
>> So I adjusted the patch a little for mx23, see attachment.
>>
> you are right. My address was wrong.
>>
>> Here is the log with some comments added on the dma.
>>
>> # ubiformat /dev/mtd1
>> ubiformat: mtd1 (nand), size 20971520 bytes (20.0 MiB), 40 eraseblocks
>> of 524288 bytes (512.0 KiB), min. I/O size 4096 bytes
>> libscan: scanning eraseblock 0 -- ?2 % complete ?[ 86.720000] [
>> start_dma_without_bch_irq : 393 ] DMA timeout, last DMA :1
>> [ 86.720000] ------------------------DMA DUMP BEGIN ----------
>> [ 86.730000] APBH REG :0 : 30000000 ? // -> ?HW_APBH_CTRL0:
>> AHB_BURST8_EN, APB_BURST4_EN
>> [ 86.730000] APBH REG :10 : 00FF0000 ? // -> ?HW_APBH_CTRL1:
>> CHX_CMDCMPLT_IRQ_EN, no cmdcmplt_irq
>> [ 86.740000] APBH REG :20 : 00000000 ? // -> ?HW_APBH_CTRL2: no error_irq
>> [ 86.740000] APBH REG :30 : 00000000 ? // -> ?HW_APBH_DEVSEL: "N/A
>> for apbh bridge dma."
>> [ 86.750000] APBH CH4 REG :200 : 418D7098 // executing last dma
>> command of command chain (see below)
>> [ 86.750000] APBH CH4 REG :210 : 00000000 // no next command, ok
>> [ 86.750000] APBH CH4 REG :220 : 000001C8 // HW_APBH_CH4_CMD:
>> COMMAND = NO DMA TRANSFER, IRQONCMPLT, WAIT4ENDCMD, SEMAPHORE,
>> HALTONTERMINATE
>> [ 86.760000] APBH CH4 REG :230 : 00000000 // HW_APBH_CH4_BAR:
>> "Address of system memory buffer to be read or written over the AHB
>> bus." -> ?strange value ...
>> [ 86.760000] APBH CH4 REG :240 : 00010000 // HW_APBH_CH4_SEMA:
>> semaphore counter is 1
>> [ 86.770000] APBH CH4 REG :250 : 03A00015 // HW_APBH_CH4_DEBUG1:
>> LOCK, NEXTCMDADDRVALID, RD_FIFO_EMPTY, WR_FIFO_EMPTY, ?STATEMACHINE =
>> "WAIT_END = 0x15 When the Wait for Command End bit is set, the state
>> machine enters this state until the DMA device indicates that the
>> command is complete."
>> [ 86.770000] APBH CH4 REG :260 : 00000000 // -> ?HW_APBH_CH4_DEBUG2:
>> no apb of ahb bytes remaining for transfer
>> [ 86.780000] [ 0 ] : ME : 418d7000, next : 418d704c, bits :
>> 00002304, bytes : 00000000, buf : 00000000
>> [ 86.790000] [ 0 ] PIO[0] : 03800000
>> [ 86.790000] [ 0 ] PIO[1] : 00000000
>> [ 86.800000] [ 0 ] PIO[2] : 00000000
>> [ 86.800000] [ 1 ] : ME : 418d704c, next : 418d7098, bits :
>> 00006304, bytes : 00000001, buf : 4181b000
>> [ 86.810000] [ 1 ] PIO[0] : 018010da
>> [ 86.810000] [ 1 ] PIO[1] : 00000000
>> [ 86.820000] [ 1 ] PIO[2] : 000011ff
>> [ 86.820000] [ 2 ] : ME : 418d7098, next : 00000000, bits :
>
> It hungs here.
>
>> 000023c8, bytes : 00000000, buf : 00000000
>> [ 86.830000] [ 2 ] PIO[0] : 038010da
>> [ 86.840000] [ 2 ] PIO[1] : 00000000
>> [ 86.840000] [ 2 ] PIO[2] : 00000000
>> [ 86.840000] ------------------------DMA DUMP END ------------
>> [ 86.850000] [ gpmi_show_regs : 076 ] -------------- Show GPMI
>> registers ----------
>> [ 86.860000] [ gpmi_show_regs : 079 ] offset 0x000 : 0x238010da
>> [ 86.870000] [ gpmi_show_regs : 079 ] offset 0x010 : 0x00000000
>> [ 86.870000] [ gpmi_show_regs : 079 ] offset 0x020 : 0x000011ff
>> [ 86.880000] [ gpmi_show_regs : 079 ] offset 0x030 : 0x000010da
>> [ 86.890000] [ gpmi_show_regs : 079 ] offset 0x040 : 0x40f0c480
>> [ 86.890000] [ gpmi_show_regs : 079 ] offset 0x050 : 0x40f09000
>> [ 86.900000] [ gpmi_show_regs : 079 ] offset 0x060 : 0x0004000c
>> [ 86.910000] [ gpmi_show_regs : 079 ] offset 0x070 : 0x00010203
>> [ 86.910000] [ gpmi_show_regs : 079 ] offset 0x080 : 0x05000000
>> [ 86.920000] [ gpmi_show_regs : 079 ] offset 0x090 : 0x09020101
>> [ 86.920000] [ gpmi_show_regs : 079 ] offset 0x0a0 : 0x00000030
>> [ 86.930000] [ gpmi_show_regs : 079 ] offset 0x0b0 : 0x80000010
>> [ 86.940000] [ gpmi_show_regs : 079 ] offset 0x0c0 : 0x100000ba
>> [ 86.940000] [ gpmi_show_regs : 079 ] offset 0x0d0 : 0x03000000
>> [ 86.950000] [ gpmi_show_regs : 081 ] -------------- Show GPMI
>> registers end ----------
>> [ 86.960000] Kernel panic - not syncing: -----------DMA
>> FAILED------------------
>
> Please post the functions-calling stack when the panic occurs.
> I also want to know where the code is running when the time-out occur.

Oops, here it is:
[   86.960000] Kernel panic - not syncing: -----------DMA
FAILED------------------
[   86.970000] [<c03a19b0>] (unwind_backtrace+0x0/0xf0) from
[<c0635be4>] (panic+0x58/0x18c)
[   86.980000] [<c0635be4>] (panic+0x58/0x18c) from [<c057ebd0>]
(start_dma_without_bch_irq+0x9c/0xb4)
[   86.990000] [<c057ebd0>] (start_dma_without_bch_irq+0x9c/0xb4) from
[<c057ec14>] (start_dma_with_bch_irq+0x2c/0x78)
[   87.000000] [<c057ec14>] (start_dma_with_bch_irq+0x2c/0x78) from
[<c057f86c>] (gpmi_read_page+0x160/0x1cc)
[   87.010000] [<c057f86c>] (gpmi_read_page+0x160/0x1cc) from
[<c057e33c>] (mil_ecc_read_page+0x64/0x1d8)
[   87.020000] [<c057e33c>] (mil_ecc_read_page+0x64/0x1d8) from
[<c05795a0>] (nand_do_read_ops+0x1d8/0x468)
[   87.030000] [<c05795a0>] (nand_do_read_ops+0x1d8/0x468) from
[<c0579ba4>] (nand_read+0x94/0xb0)
[   87.040000] [<c0579ba4>] (nand_read+0x94/0xb0) from [<c0573768>]
(part_read+0x60/0xe4)
[   87.050000] [<c0573768>] (part_read+0x60/0xe4) from [<c05751f0>]
(mtd_read+0xd8/0x20c)
[   87.060000] [<c05751f0>] (mtd_read+0xd8/0x20c) from [<c0442890>]
(vfs_read+0xb0/0x180)
[   87.060000] [<c0442890>] (vfs_read+0xb0/0x180) from [<c04429a0>]
(sys_read+0x40/0x70)
[   87.070000] [<c04429a0>] (sys_read+0x40/0x70) from [<c039c780>]
(ret_fast_syscall+0x0/0x2c

>
> My gmail is shijie8 at gmail.com
> We may talk more on the gtalk.

i'm available using koen.beel.barco at gmail.com

>
> Best Regards
> Huang Shijie
>
>> Br,
>> Koen
>>
>>>
>>> Please try the new patch.
>>>
>>> Best Regards
>>> Huang Shijie
>>>>
>>>> Then it prints some debug info on channel 1 (ssp1) and then alle
>>>> channel 2 register except the debug register (ssp2 = not used here).
>>>>
>>>> What info do you need?
>>>>
>>>> Br,
>>>> Koen
>>>>
>>>>> Best Regards
>>>>> Huang Shijie
>>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>>
>
>
>
