From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 4 Oct 2016 15:29:12 +0100
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
 <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
Message-ID: <434a0256-de86-c1f0-0dc3-a38f55596e8e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/16 06:37, Venkatesh Vivekanandan wrote:
> On Mon, Oct 3, 2016 at 6:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Venkatesh,
>>
>> On 03/10/16 12:36, Venkatesh Vivekanandan wrote:
>>>
>>> Hi All,
>>>
>>> I am trying to collect ETF trace from Juno R1 and could see "cpu
>>> stall" while dumping the trace. Attached is the log of sequence
>>> followed. Was trying to collect the trace data from hardware and see
>>> if it is any valid data. Am I missing anything here?.
>>>
>>
>> There are few fixes from me and Suzuki queued for v4.9.
>> Can you check if this issue persists even on linux-next ?
>
> Issue is the same in linux-next as well. Please find the attached log.
>
> linaro-test [rc=0]# dd if=/dev/20010000.etf of=/cstrace.bin bs=1
> [  120.009698] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  120.015307]  2-...: (1 GPs behind) idle=f11/140000000000000/0
> softirq=224/224 fqs=1903
> [  120.023226]  (detected by 1, t=5255 jiffies, g=-1, c=-2, q=19)
> [  120.029001] Task dump for CPU 2:
> [  120.032190] dd              R  running task        0  1270   1267 0x00000002
> [  120.039172] Call trace:
> [  120.041594] [<ffff000008085534>] __switch_to+0xc8/0xd4
> [  120.046675] [<0000000000020000>] 0x20000
>
> Steps followed,
> # git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> linux-next
> # cd linux-next
> # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
> # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig  <---
> enable coresight
> # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 Image
> # make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- dtbs
> # arch/arm64/boot/Image <--- copied this kernel
> # arch/arm64/boot/dts/arm/juno-r1.dtb <--- copied this dtb
>
> Top commit in linux-next is,
>
> commit c7d3b912180a9bb0733e5cfab84e5a7493dd3599
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Tue Oct 4 14:52:03 2016 +1100
>
>     Add linux-next specific files for 20161004

Can't reproduce it here either.

root at localhost:/sys/bus/coresight/devices# echo 1 > 20010000.etf/enable_sink
root at localhost:/sys/bus/coresight/devices# echo 1 > 22140000.etm/enable_source
root at localhost:/sys/bus/coresight/devices# dd if=/dev/20010000.etf bs=1 of=/root/etr.bin
65536+0 records in
65536+0 records out
65536 bytes (66 kB) copied, 0.227546 s, 288 kB/s
root at localhost:/sys/bus/coresight/devices# dd if=/dev/20010000.etf bs=1 of=/root/etr.bin
65536+0 records in
65536+0 records out
65536 bytes (66 kB) copied, 0.233527 s, 281 kB/s
root at localhost:/sys/bus/coresight/devices# echo 0 > 20010000.etf/enable_sink
root at localhost:/sys/bus/coresight/devices# dd if=/dev/20010000.etf bs=1 of=/root/etr.bin
65536+0 records in
65536+0 records out
65536 bytes (66 kB) copied, 0.474943 s, 138 kB/s

FWIW, here is my firmware version :

NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.1(release):e04723e21362
NOTICE:  BL1: Built : 15:39:56, Sep  1 2015
NOTICE:  BL1: Booting BL2
NOTICE:  BL2: v1.1(release):e04723e21362
NOTICE:  BL2: Built : 15:42:30, Sep  1 2015
NOTICE:  BL1: Booting BL3-1
NOTICE:  BL3-1: v1.1(release):604d5da6f2aa
NOTICE:  BL3-1: Built : 14:50:36, Sep 10 2015
UEFI firmware (version ea31f8e built at 16:35:17 on Aug  5 2015)


Cheers
Suzuki
