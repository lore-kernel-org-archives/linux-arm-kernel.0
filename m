From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 4 Mar 2014 17:31:26 +0530
Subject: [REGRESSION] Arndale Octa panics when booting 3.14-rc1
In-Reply-To: <20140304103936.GA10559@e102654-lin.cambridge.arm.com>
References: <20140303185755.GA11460@e102654-lin.cambridge.arm.com>
 <5314D239.7090001@gmail.com> <5314EBCB.3060400@gmail.com>
 <20140304101608.GA3852@e102654-lin.cambridge.arm.com>
 <5315AB3B.5080207@samsung.com>
 <20140304103936.GA10559@e102654-lin.cambridge.arm.com>
Message-ID: <CAHbNUh2kbYUa1OegRrOXMAEmKRjsf4PifT6tZnKdBx7NoDkq6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2014 16:09, Javi Merino <javi.merino@arm.com> wrote:
> On Tue, Mar 04, 2014 at 10:30:19AM +0000, Sylwester Nawrocki wrote:
>> On 04/03/14 11:16, Javi Merino wrote:
>> > Yes, with [1] applied I don't get a kernel panic but the kernel fails
>> > to boot later on with an Imprecise external abort.  Removing the mdma
>> > nodes from the dts gets rid of that.  I guess what's missing is what
>> > you said: clocks for the mdma devices.
>>
>> Is removing mdm0 node enough to fix the boot failure, or both have to be
>> removed ?
>
> Actually, you it's only mdma1.  Just removing the mdma1 node from the
> dt fixes the imprecise external abort.
>

MDMA1 can support both secure and non-secure AXI transactions, the
actual behaviour is controlled by trustzone software. It may be the
case that MDMA1 is configured to be used in secure mode only, hence
accessing it in non-secure mode is causing the oops.

Right now, the only solution looks like disabling this node in
Arndale-Octa dts file.

--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -354,4 +354,16 @@
                samsung,i2s-controller = <&i2s0>;
                samsung,audio-codec = <&i2s_stub>;
        };
+
+       amba {
+               mdma1: mdma at 11C10000 {
+                       /*
+                        * MDMA1 can support both secure and non-secure
+                        * AXI transactions. When this is enabled in the kernel
+                        * for boards that run in secure mode, we are getting
+                        * imprecise external aborts causing the kernel to oops.
+                        */
+                       status = "disabled";
+               };
+       };

If it works, I will submit this patch.

>> Unfortunately I don't access to exynos5420 datasheet at the moment, I've
>> added guys from Samsung Linaro Landing Team at cc, hopefully they can
>> provide a patch for the clocks driver to fix this.
>
> Thanks,
> Javi
>
>> > 8<---
>> > [    8.060000] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ d)
>> > [    8.070000] Registering SWP/SWPB emulation handler
>> > [    8.075000] s3c-rtc 101e0000.rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
>> > [    8.080000] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ )
>> > [    8.090000] Freeing unused kernel memory: 220K (c04c1000 - c04f8000)
>> > [    8.100000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> > [    8.105000] mmc0: new high speed DDR MMC card at address 0001
>> > [    8.110000] mmcblk0: mmc0:0001 M4G1FB 3.64 GiB
>> > [    8.115000] mmcblk0boot0: mmc0:0001 M4G1FB partition 1 1.00 MiB
>> > [    8.120000] mmcblk0boot1: mmc0:0001 M4G1FB partition 2 1.00 MiB
>> > [    8.125000] mmcblk0rpmb: mmc0:0001 M4G1FB partition 3 128 KiB
>> > [    8.135000]  mmcblk0: p1 p2 p3 p4
>> > [    8.140000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
>> > [    8.140000]
>> > [    8.140000] CPU: 0 PID: 1 Comm: init Not tainted 3.14.0-rc5-00002-g691b10f #189
>> > [    8.140000] [<c0013e24>] (unwind_backtrace) from [<c0011238>] (show_stack+0x10/0x14)
>> > [    8.140000] [<c0011238>] (show_stack) from [<c038218c>] (dump_stack+0x64/0xb4)
>> > [    8.140000] [<c038218c>] (dump_stack) from [<c037f6f4>] (panic+0x8c/0x1dc)
>> > [    8.140000] [<c037f6f4>] (panic) from [<c001f178>] (do_exit+0x80c/0x8b8)
>> > [    8.140000] [<c001f178>] (do_exit) from [<c001f310>] (do_group_exit+0x3c/0xb0)
>> > [    8.140000] [<c001f310>] (do_group_exit) from [<c00298a0>] (get_signal_to_deliver+0x278/0x500)
>> > [    8.140000] [<c00298a0>] (get_signal_to_deliver) from [<c001076c>] (do_signal+0x78/0x398)
>> > [    8.140000] [<c001076c>] (do_signal) from [<c0010db4>] (do_work_pending+0x64/0xac)
>> > [    8.140000] [<c0010db4>] (do_work_pending) from [<c000e460>] (work_pending+0xc/0x20)
>> > 8<---
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Tushar Behera
