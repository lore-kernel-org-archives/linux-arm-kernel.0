From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 28 Nov 2014 21:09:07 +0530
Subject: [PATCH RFT 2/2] arm: dts: disable CCI on exynos420 based
 arndale-octa
In-Reply-To: <1417187977.19247.4.camel@AMDC1943>
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
 <1417186209-5256-2-git-send-email-a.kesavan@samsung.com>
 <1417187977.19247.4.camel@AMDC1943>
Message-ID: <CAM4voa=aN53CWjTzw-A736xZo3xWr2N4kBpM0vJX5KqfV-ikjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Fri, Nov 28, 2014 at 8:49 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On pi?, 2014-11-28 at 20:20 +0530, Abhilash Kesavan wrote:
>> The arndale-octa board was giving "imprecise external aborts" during
>> boot-up with MCPM enabled. CCI enablement of the boot cluster was found
>> to be the cause of these aborts (possibly because the secure f/w was not
>> allowing it). Hence, disable CCI for the arndale-octa board.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |    4 ++++
>>  arch/arm/boot/dts/exynos5420.dtsi             |    2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> I tested these 2 patches on Arndale Octa but there are no improvements.
> I still got imprecise aborts (some not fatal and sometimes killing init
> with full backtrace).

Thanks for testing. Are you testing this with exynos_defconfig with no
other changes ? Can you please confirm from the bootlog that MCPM and
CCI are not being initialized.

Can you remove these 2 patches and on linux-next check if you are
getting aborts even with 5420_MCPM disabled.

Regards,
Abhilash
>
> Tested on next-20141128. System booted from microSD (bootloader from
> Linaro Ubuntu Saucy server image):
>
> ==================================
> U-Boot 2012.07 (Feb 15 2014 - 17:29:55) for ARNDALE OCTA
>
> CPU: Exynos5420 Rev2.0 [Samsung SOC on SMP Platform Base on ARM CortexA15]
> APLL = 800MHz, KPLL = 600MHz
> MPLL = 532MHz, BPLL = 800MHz
>
> Board: ARNDALE OCTA
> DRAM:  2 GiB
> WARNING: Caches not enabled
>
> TrustZone Enabled BSP
> BL1 version:
>
> Checking Boot Mode ... SDMMC
> MMC:   S5P_MSHC2: 0, S5P_MSHC0: 1
> MMC Device 0: 29.3 GiB
> MMC Device 1: 7.3 GiB
> MMC Device 2: MMC Device 2 not found
> there are pending interrupts 0x00000001
> In:    serial
> Out:   serial
> Err:   serial
> Net:   No ethernet found.
> (Re)start USB...
> USB:   Register 1313 NbrPorts 3
> USB EHCI 1.00
> scanning bus for devices... The request port(2) is not configured
> The request port(2) is not configured
> 3 USB Device(s) found
>        scanning bus for storage devices... 0 Storage Device(s) found
>        scanning usb for ethernet devices... 1 Ethernet Device(s) found
> Hit any key to stop autoboot:  0
> ARNDALE # uTTY
> Unknown command 'uTTY' - try 'help'
> ARNDALE # run nn
> reading uImage
>
> 3674704 bytes read
> reading uInitrd
>
> 2330480 bytes read
> reading board.dtb
>
> 33680 bytes read
> ## Booting kernel from Legacy Image at 20007000 ...
>    Image Name:   Linux-exynos5420-arndale-octa
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3674640 Bytes = 3.5 MiB
>    Load Address: 41008000
>    Entry Point:  41008000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 22000000 ...
>    Image Name:   initramfs
>    Image Type:   ARM Linux RAMDisk Image (uncompressed)
>    Data Size:    2330416 Bytes = 2.2 MiB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 21f00000
>    Booting using the fdt blob at 0x21f00000
>    Loading Kernel Image ... OK
> OK
>    Using Device Tree in place at 21f00000, end 21f0b38f
>
> Starting kernel ...
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.18.0-rc6-next-20141128-00007-g33b7bf7da133 (k.kozlowski at AMDC1943) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #24 SMP PREEMPT Fri Nov 28 16:13:43 CET 2014
> [    0.000000] CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5387d
>
> ...
> [   12.874514] VFS: Mounted root (ext4 filesystem) readonly on device 179:67.
> [   12.887392] devtmpfs: mounted
> [   12.889321] Freeing unused kernel memory: 324K (c0669000 - c06ba000)
> [   12.951241] Unhandled fault: imprecise external abort (0x406) at 0x00000000
> [   12.966312] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
> [   12.966312]
> [   12.973980] CPU: 0 PID: 1 Comm: bash Tainted: G        W      3.18.0-rc6-next-20141128-00007-g33b7bf7da133 #24
> [   12.983938] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   12.990014] [<c0014d44>] (unwind_backtrace) from [<c0011c88>] (show_stack+0x10/0x14)
> [   12.997723] [<c0011c88>] (show_stack) from [<c048e82c>] (dump_stack+0x70/0xbc)
> [   13.004911] [<c048e82c>] (dump_stack) from [<c048a8c0>] (panic+0x94/0x20c)
> [   13.011753] [<c048a8c0>] (panic) from [<c0026500>] (do_exit+0x944/0x988)
> [   13.018424] [<c0026500>] (do_exit) from [<c00265f4>] (do_group_exit+0x3c/0xbc)
> [   13.025621] [<c00265f4>] (do_group_exit) from [<c0030d60>] (get_signal+0x218/0x8c4)
> [   13.033247] [<c0030d60>] (get_signal) from [<c048a39c>] (do_signal+0x84/0x350)
> [   13.040438] [<c048a39c>] (do_signal) from [<c00115ec>] (do_work_pending+0xbc/0xcc)
> [   13.047979] [<c00115ec>] (do_work_pending) from [<c000f1f8>] (work_pending+0xc/0x20)
> [   13.055693] CPU1: stopping
> [   13.058385] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W      3.18.0-rc6-next-20141128-00007-g33b7bf7da133 #24
> [   13.068790] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   13.074858] [<c0014d44>] (unwind_backtrace) from [<c0011c88>] (show_stack+0x10/0x14)
> [   13.082573] [<c0011c88>] (show_stack) from [<c048e82c>] (dump_stack+0x70/0xbc)
> [   13.089762] [<c048e82c>] (dump_stack) from [<c0013e14>] (handle_IPI+0x158/0x18c)
> [   13.097128] [<c0013e14>] (handle_IPI) from [<c00086f4>] (gic_handle_irq+0x60/0x68)
> [   13.104669] [<c00086f4>] (gic_handle_irq) from [<c00127c4>] (__irq_svc+0x44/0x7c)
> [   13.112112] Exception stack(0xee4c3fa0 to 0xee4c3fe8)
> [   13.117135] 3fa0: c000fd7c ee4c3fe8 ee4c3ff0 00000000 c06c24e8 c04997e0 c06fa60a c06fa60a
> [   13.125287] 3fc0: 00000001 412fc0f3 00000000 00000000 00000001 ee4c3fe8 c000fd7c c000fd80
> [   13.133429] 3fe0: 60000013 ffffffff
> [   13.136895] [<c00127c4>] (__irq_svc) from [<c000fd80>] (arch_cpu_idle+0x20/0x3c)
> [   13.144272] [<c000fd80>] (arch_cpu_idle) from [<c0059d0c>] (cpu_startup_entry+0x11c/0x1a0)
> [   13.152499] [<c0059d0c>] (cpu_startup_entry) from [<40008784>] (0x40008784)
> [   13.159424] CPU2: stopping
> [   13.162102] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W      3.18.0-rc6-next-20141128-00007-g33b7bf7da133 #24
> [   13.172508] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   13.178577] [<c0014d44>] (unwind_backtrace) from [<c0011c88>] (show_stack+0x10/0x14)
> [   13.186291] [<c0011c88>] (show_stack) from [<c048e82c>] (dump_stack+0x70/0xbc)
> [   13.193479] [<c048e82c>] (dump_stack) from [<c0013e14>] (handle_IPI+0x158/0x18c)
> [   13.200845] [<c0013e14>] (handle_IPI) from [<c00086f4>] (gic_handle_irq+0x60/0x68)
> [   13.208386] [<c00086f4>] (gic_handle_irq) from [<c00127c4>] (__irq_svc+0x44/0x7c)
> [   13.215833] Exception stack(0xee4c5fa0 to 0xee4c5fe8)
> [   13.220854] 5fa0: c000fd7c ee4c5fe8 ee4c5ff0 00000000 c06c24e8 c04997e0 c06fa60a c06fa60a
> [   13.229006] 5fc0: 00000001 412fc0f3 00000000 00000000 00000001 ee4c5fe8 c000fd7c c000fd80
> [   13.237149] 5fe0: 60000113 ffffffff
> [   13.240612] [<c00127c4>] (__irq_svc) from [<c000fd80>] (arch_cpu_idle+0x20/0x3c)
> [   13.247986] [<c000fd80>] (arch_cpu_idle) from [<c0059d0c>] (cpu_startup_entry+0x11c/0x1a0)
> [   13.256218] [<c0059d0c>] (cpu_startup_entry) from [<40008784>] (0x40008784)
> [   13.263144] CPU3: stopping
> [   13.265823] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W      3.18.0-rc6-next-20141128-00007-g33b7bf7da133 #24
> [   13.276230] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   13.282300] [<c0014d44>] (unwind_backtrace) from [<c0011c88>] (show_stack+0x10/0x14)
> [   13.290012] [<c0011c88>] (show_stack) from [<c048e82c>] (dump_stack+0x70/0xbc)
> [   13.297200] [<c048e82c>] (dump_stack) from [<c0013e14>] (handle_IPI+0x158/0x18c)
> [   13.304565] [<c0013e14>] (handle_IPI) from [<c00086f4>] (gic_handle_irq+0x60/0x68)
> [   13.312108] [<c00086f4>] (gic_handle_irq) from [<c00127c4>] (__irq_svc+0x44/0x7c)
> [   13.319553] Exception stack(0xee4c7fa0 to 0xee4c7fe8)
> [   13.324576] 7fa0: c000fd7c ee4c7fe8 ee4c7ff0 00000000 c06c24e8 c04997e0 c06fa60a c06fa60a
> [   13.332727] 7fc0: 00000001 412fc0f3 00000000 00000000 00000001 ee4c7fe8 c000fd7c c000fd80
> [   13.340870] 7fe0: 60000113 ffffffff
> [   13.344335] [<c00127c4>] (__irq_svc) from [<c000fd80>] (arch_cpu_idle+0x20/0x3c)
> [   13.351710] [<c000fd80>] (arch_cpu_idle) from [<c0059d0c>] (cpu_startup_entry+0x11c/0x1a0)
> [   13.359939] [<c0059d0c>] (cpu_startup_entry) from [<40008784>] (0x40008784)
> [   13.366878] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
> [   13.366878]
>
> ==================================
>
> Best regards,
> Krzysztof
>
>
>> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> index aa7a7d7..db2c1c4 100644
>> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> @@ -372,3 +372,7 @@
>>  &usbdrd_dwc3_1 {
>>       dr_mode = "host";
>>  };
>> +
>> +&cci {
>> +     status = "disabled";
>> +};
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index 517e50f..0a82ae7 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -120,7 +120,7 @@
>>               };
>>       };
>>
>> -     cci at 10d20000 {
>> +     cci: cci at 10d20000 {
>>               compatible = "arm,cci-400";
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>
