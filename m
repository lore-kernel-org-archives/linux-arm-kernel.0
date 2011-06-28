From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Jun 2011 19:45:52 +0400
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <20110628150631.GD24904@e102109-lin.cambridge.arm.com>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
	<20110628142045.GC7255@1n450.cable.virginmedia.net>
	<20110628143014.GD7255@1n450.cable.virginmedia.net>
	<BANLkTinL7-Kjx5fHrwHYHHhgjJ-6ex3=eA@mail.gmail.com>
	<BANLkTinoLB89VAWh-tSswq+H9EcmcQWnXQ@mail.gmail.com>
	<20110628150631.GD24904@e102109-lin.cambridge.arm.com>
Message-ID: <BANLkTi=dzYV5tdHaZL91oHjMfuVtXUCD5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/28/11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Jun 28, 2011 at 03:54:11PM +0100, Dmitry Eremin-Solenikov wrote:
>> On 6/28/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>> > On 6/28/11, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> Actually since the return address is in S_PC (which maybe gdb assumes
>> >> it
>> >> would be the saved LR), this is probably not be correct. After SVC
>> >> entry, we have he following structure on the stack:
>> >>
>> >> 	ORIG_r0
>> >> 	CPSR
>> >> 		<--- assuming this is the Call Frame Address (SP+S_PC+4)
>> >> 	PC	<--- CFA - 4
>> >> 	LR	<--- don't care
>> >> 	SP	<--- CFA - 12
>> >> 	...
>> >>
>> >>
>> >> So we tell gdb about this with something like below (untested):
>> >>
>> >> 	.cfi_def_cfa_offset S_PC + 4
>> >> 	.cfi_offset 14, -4
>> >> 	.cfi_offset 13, -12
>> >
>> > This brings "unknown CFA rule" gdb exception, but it seems I got your
>> > idea.
>>
>> No, this seems to work, it was my fault. I got more or less reasonable
>> backtrace now.
>
> Does gdb manage to get into the parent stack frame?
>
> BTW, are you compiling with FRAME_POINTER enabled? In this case you
> would need to set some offset for the FP register (11). If you don't
> mind missing the first part in the parent context, maybe something like
> below:
>
> 	.cfi_def_cfa_offset S_PC
> 	.cfi_offset 14, -4
> 	.cfi_offset 13, -8
> 	.cfi_offset 11, -16

No, this seems wrong. Previous version was better. Here is a part of gdb log
generated using the attached patch:

Breakpoint 2, pxamci_start_cmd (host=0xc3bfd680, cmd=0xc3e7bed8,
cmdat=2112) at /run/shm/zigbee-kernel/drivers/mmc/host/pxamci.c:256
256		WARN_ON(host->cmd != NULL);
#0  pxamci_start_cmd (host=0xc3bfd680, cmd=0xc3e7bed8, cmdat=2112) at
/run/shm/zigbee-kernel/drivers/mmc/host/pxamci.c:256
#1  0xc0248870 in mmc_start_request (host=0xc3bfd400, mrq=0xc3e7beb0)
at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:196
#2  0xc02488bc in mmc_wait_for_req (host=0xc3bfd400, mrq=0xc3e7beb0)
at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:220
#3  0xc0248930 in mmc_wait_for_cmd (host=0xc3bfd400, cmd=0xc3e7bed8,
retries=0) at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:249
#4  0xc024ef48 in mmc_io_rw_direct_host (host=0xc3bfd400, write=<value
optimized out>, fn=<value optimized out>, addr=<value optimized out>,
in=<value optimized out>, out=0xc3e7bf3f  <incomplete sequence \330>)
at /run/shm/zigbee-kernel/drivers/mmc/core/sdio_ops.c:89
#5  0xc024efd4 in sdio_reset (host=0xc3bfd400) at
/run/shm/zigbee-kernel/drivers/mmc/core/sdio_ops.c:191
#6  0xc0249974 in mmc_rescan_try_freq (host=0xc3bfd400, freq=<value
optimized out>) at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:1548
#7  0xc0249b60 in mmc_rescan (work=0xc3bfd618) at
/run/shm/zigbee-kernel/drivers/mmc/core/core.c:1609
#8  0xc00638b0 in process_one_work (worker=0xc3e63580,
work=0xc3bfd618) at /run/shm/zigbee-kernel/kernel/workqueue.c:1868
#9  0xc0063e2c in worker_thread (__worker=<value optimized out>) at
/run/shm/zigbee-kernel/kernel/workqueue.c:1979
#10 0xc00675dc in kthread (_create=0xc3e41ef0) at
/run/shm/zigbee-kernel/kernel/kthread.c:96
#11 0xc0033810 in kernel_thread_helper ()
#12 0xc0033810 in kernel_thread_helper ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Breakpoint 1, pxamci_irq (irq=39, devid=0xc3bfd680) at
/run/shm/zigbee-kernel/drivers/mmc/host/pxamci.c:397
397		testtt();
#0  pxamci_irq (irq=39, devid=0xc3bfd680) at
/run/shm/zigbee-kernel/drivers/mmc/host/pxamci.c:397
#1  0xc0084fa4 in handle_irq_event_percpu (desc=0xc3e05ea0,
action=0xc399f1c0) at /run/shm/zigbee-kernel/kernel/irq/handle.c:126
#2  0xc0085128 in handle_irq_event (desc=0xc3e05ea0) at
/run/shm/zigbee-kernel/kernel/irq/handle.c:182
#3  0xc00871d0 in handle_level_irq (irq=<value optimized out>,
desc=0xc3e05ea0) at /run/shm/zigbee-kernel/kernel/irq/chip.c:345
#4  0xc0084f64 in generic_handle_irq_desc (irq=39) at
/run/shm/zigbee-kernel/include/linux/irqdesc.h:111
#5  generic_handle_irq (irq=39) at
/run/shm/zigbee-kernel/kernel/irq/irqdesc.c:304
#6  0xc0032060 in asm_do_IRQ (irq=39, regs=<value optimized out>) at
/run/shm/zigbee-kernel/arch/arm/kernel/irq.c:90
#7  0xc0032b50 in __irq_svc () at
/run/shm/zigbee-kernel/arch/arm/kernel/entry-armv.S:222
#8  0xc0253bc4 in arch_local_irq_restore (host=0xc3bfd680,
cmd=0xc3e7bed8, cmdat=2113) at
/run/shm/zigbee-kernel/arch/arm/include/asm/irqflags.h:142
#9  spin_unlock_irqrestore (host=0xc3bfd680, cmd=0xc3e7bed8,
cmdat=2113) at /run/shm/zigbee-kernel/include/linux/spinlock.h:340
#10 pxamci_enable_irq (host=0xc3bfd680, cmd=0xc3e7bed8, cmdat=2113) at
/run/shm/zigbee-kernel/drivers/mmc/host/pxamci.c:160
#11 pxamci_start_cmd (host=0xc3bfd680, cmd=0xc3e7bed8, cmdat=2113) at
/run/shm/zigbee-kernel/drivers/mmc/host/pxamci.c:285
#12 0xc0248870 in mmc_start_request (host=0xc3bfd400, mrq=0xc3e7beb0)
at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:196
#13 0xc02488bc in mmc_wait_for_req (host=0xc3bfd400, mrq=0xc3e7beb0)
at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:220
#14 0xc0248930 in mmc_wait_for_cmd (host=0xc3bfd400, cmd=0xc3e7bed8,
retries=0) at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:249
#15 0xc024ef48 in mmc_io_rw_direct_host (host=0xc3bfd400, write=<value
optimized out>, fn=<value optimized out>, addr=<value optimized out>,
in=<value optimized out>, out=0xc3e7bf3f  <incomplete sequence \330>)
at /run/shm/zigbee-kernel/drivers/mmc/core/sdio_ops.c:89
#16 0xc024efd4 in sdio_reset (host=0xc3bfd400) at
/run/shm/zigbee-kernel/drivers/mmc/core/sdio_ops.c:191
#17 0xc0249974 in mmc_rescan_try_freq (host=0xc3bfd400, freq=<value
optimized out>) at /run/shm/zigbee-kernel/drivers/mmc/core/core.c:1548
#18 0xc0249b60 in mmc_rescan (work=0xc3bfd618) at
/run/shm/zigbee-kernel/drivers/mmc/core/core.c:1609
#19 0xc00638b0 in process_one_work (worker=0xc3e63580,
work=0xc3bfd618) at /run/shm/zigbee-kernel/kernel/workqueue.c:1868
#20 0xc0063e2c in worker_thread (__worker=<value optimized out>) at
/run/shm/zigbee-kernel/kernel/workqueue.c:1979
#21 0xc00675dc in kthread (_create=0xc3e41ef0) at
/run/shm/zigbee-kernel/kernel/kthread.c:96
#22 0xc0033810 in kernel_thread_helper ()
#23 0xc0033810 in kernel_thread_helper ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Colleagues, does this look suitable for you?

-- 
With best wishes
Dmitry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ARM_CFI.patch
Type: text/x-patch
Size: 2492 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110628/316f4c3f/attachment.bin>
