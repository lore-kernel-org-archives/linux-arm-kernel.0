From: venkatesh.vivekanandan@broadcom.com (Venkatesh Vivekanandan)
Date: Tue, 4 Oct 2016 11:07:53 +0530
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
Message-ID: <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 6:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Venkatesh,
>
> On 03/10/16 12:36, Venkatesh Vivekanandan wrote:
>>
>> Hi All,
>>
>> I am trying to collect ETF trace from Juno R1 and could see "cpu
>> stall" while dumping the trace. Attached is the log of sequence
>> followed. Was trying to collect the trace data from hardware and see
>> if it is any valid data. Am I missing anything here?.
>>
>
> There are few fixes from me and Suzuki queued for v4.9.
> Can you check if this issue persists even on linux-next ?

Issue is the same in linux-next as well. Please find the attached log.

linaro-test [rc=0]# dd if=/dev/20010000.etf of=/cstrace.bin bs=1
[  120.009698] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  120.015307]  2-...: (1 GPs behind) idle=f11/140000000000000/0
softirq=224/224 fqs=1903
[  120.023226]  (detected by 1, t=5255 jiffies, g=-1, c=-2, q=19)
[  120.029001] Task dump for CPU 2:
[  120.032190] dd              R  running task        0  1270   1267 0x00000002
[  120.039172] Call trace:
[  120.041594] [<ffff000008085534>] __switch_to+0xc8/0xd4
[  120.046675] [<0000000000020000>] 0x20000

Steps followed,
# git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
linux-next
# cd linux-next
# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig  <---
enable coresight
# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 Image
# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- dtbs
# arch/arm64/boot/Image <--- copied this kernel
# arch/arm64/boot/dts/arm/juno-r1.dtb <--- copied this dtb

Top commit in linux-next is,

commit c7d3b912180a9bb0733e5cfab84e5a7493dd3599
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Oct 4 14:52:03 2016 +1100

    Add linux-next specific files for 20161004

>
> --
> Regards,
> Sudeep
-------------- next part --------------
A non-text attachment was scrubbed...
Name: r1-next-trace-log
Type: application/octet-stream
Size: 3423 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/9cc7e974/attachment.obj>
