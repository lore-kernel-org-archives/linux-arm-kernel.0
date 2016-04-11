From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 11 Apr 2016 15:24:07 -0700
Subject: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
In-Reply-To: <570C1D47.7010102@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com>
 <4768648c-841b-490d-a752-f31cba545f74@broadcom.com>
 <570C1D47.7010102@gmail.com>
Message-ID: <ccabf53c-c035-be4b-a016-389bb7531557@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/11/2016 2:55 PM, Florian Fainelli wrote:
> On 11/04/16 13:06, Ray Jui wrote:
>>
>>
>> On 4/10/2016 6:43 PM, Florian Fainelli wrote:
>>> On April 9, 2016 2:50:23 PM PDT, "Rafa? Mi?ecki" <zajec5@gmail.com>
>>> wrote:
>>>> Some devices (e.g. Northstar ones) may have bridges that forward
>>>> harmless errors to the ARM core. In such case we need an option to
>>>> add a handler ignoring them.
>>>>
>>>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>>>> ---
>>>
>>>> +- brcm,pcie-hook-abort-handler: During PCI bus probing (device
>>>> enumeration)
>>>> +  there can be errors that are expected and harmless. Unfortunately
>>>> some bridges
>>>> +  can't be configured to ignore them and they forward them to the ARM
>>>> core
>>>> +  triggering die().
>>>> +  This property should be set in such case, it will make driver add
>>>> its own
>>>> +  handler ignoring such errors.
>>>
>>> The property is named after the function that allows you to catch
>>> abort handlers, whereas you should be describing the HW here.
>>> Something like brcm,bridge-error-forward or a better name even would
>>> be preferable.
>>>
>>>> +#ifdef CONFIG_ARM
>>>> +static int iproc_pcie_abort_handler(unsigned long addr, unsigned int
>>>> fsr,
>>>> +                    struct pt_regs *regs)
>>>> +{
>>>> +    if (fsr == 0x1406)
>>>> +        return 0;
>>>> +
>>>> +    return 1;
>>>
>>> As you later noted this prevents this driver from being a module now.
>>> Since the expectation is that either a fixed bootloader or a platform
>>> should enot produce these data aborts, or allow them to be ignored,
>>> why not just put this code back where it belongs in the machine
>>> specific file which kills many birds with the same stone:
>>>
>>
>> I assume the module compile issue can be simply fixed by exporting
>> symbol of "hook_fault_code"?
>
> I do not think it is desireable for this symbol to be exported in the
> first place, also last I looked, this was a one time registration thing,
> you cannot undo the hook you installed, but everything can be fixed.
>

Okay.

>>
>> I believe ARM64 based NS2 that uses the same iProc PCIe driver might
>> also need something like this (I'm still waiting for Jon Mason to give
>> me some more information on the NS2 errors that he saw, which is likely
>> related to this). I assume there will be something similar to the ARM
>> specific "hook_fault_code" for ARM64, but then ARM64 does not have any
>> "mach" specific directory. Where can this type of hook be installed for
>> ARM64 based platforms if not in the PCIe driver?
>
> OK, that is a fair point, then maybe have a two stage process, where we
> make sure that the part that installs the hook is always available and
> built-into the kernel, but let the iProc PCIe driver remain a module?
>

I guess we are sort of stuck on this. If "hook_fault_code" is not 
supposed to be used by any driver compiled as module like you described, 
then yes, I agree, I don't see how we can leave this in the iProc PCIe 
driver.

>>
>>> - code is ways built-in, and hook_fault_code is installed prior to
>>> PCIe loading (function is marked with __init)
>>> - platforms which do not need that, just do not install it for that
>>> specific code
>>> - it is clear which platforms need it and which do not, yet the driver
>>> remains agnostic
>>
>> It's actually unclear to me which iProc platforms need this.
>> - We know NS needs it
>> - Someone mentioned NSP does not need this? But where does the
>> information come from? Do we have similar PCIe connection configuration
>> on NSP as NS?
>> - I cannot confirm whether Cygnus needs this or not since we do not have
>> similar board configurations on Cygnus (on Cygnus each host is always
>> connected to a single device). I can check with the ASIC team, but that
>> will be a very lengthy process and I'm not sure when I can get the
>> answer we need (and yes I do work at Broadcom, :))
>> - Jon Mason reported similar abort issues on NS2 when an externally
>> connected, multi function device is used. I'm still waiting for him to
>> send me the error log and see if it's the same type of data abort.
>
> Is there really no way to flip some chicken bits to prevent the PCIe
> root complex from forwarding some of these errors?
>

I'm not sure if NS has this capability, maybe Jon can help to check with 
the ASIC team on this matter? I know Jon has been checking with the ASIC 
team on the issue with NS2 but he's still waiting for a reply.

I can help to check with the Cygnus ASIC team on this. But even if I can 
get an answer, I'm not sure if the same configuration (if exists) can be 
applied on other chips.

> Also, sorry if this is repeating information, but how can we generate
> spurious aborts if we are scanning the PCIe bus, are we possibly trying
> to access the RC's config space before it is set up (this should not
> fail), or something else?
>
> Thanks!
>

I'm not sure why we see spurious aborts here, perhaps that's from 
different PCIe domains (therefore from devices hooked up to different 
PCIe RCs)?

Based on the error log from Rafal, it does look like the abort is 
triggered when the EPs are enumerated (i.e., not triggered from 
accessing the RC's config space):

[   10.547032] pci 0001:01:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[   10.555199] External imprecise Data abort at addr=0x1c6e00f, 
fsr=0x1406 ignored.
[   10.562635] Unhandled fault: imprecise external abort (0x1406) at 
0x01c6e00f
[   10.569699] pgd = c71e4000
[   10.572405] [01c6e00f] *pgd=0732b831, *pte=06d1f75f, *ppte=06d1fc7f
[   10.578711] Internal error: : 1406 [#1] SMP ARM
[   10.583249] Modules linked in: pcie_iproc_bcma(+) pcie_iproc 
ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw 
ip6table_mangle ip6table_filter ip6_tables x_tables leds_gpio 
gpio_button_hotplug usbcore nls_base usb_common
[   10.604388] CPU: 0 PID: 648 Comm: kmodloader Not tainted 4.4.6 #9
[   10.610493] Hardware name: BCM5301X
[   10.613985] task: c7a5a400 ti: c7346000 task.ti: c7346000
[   10.619404] PC is at pci_generic_config_read32+0x48/0x74
[   10.624733] LR is at arm_heavy_mb+0x20/0x40
[   10.628923] pc : [<c01ad4d8>]    lr : [<c001b2ac>]    psr: a0000093
[   10.628923] sp : c7347a00  ip : c73479c8  fp : c7347a1c
[   10.640427] r10: 0000000e  r9 : 00000000  r8 : c7347a72
[   10.645659] r7 : 60000013  r6 : 00000001  r5 : c7347a2c  r4 : 0000000e
[   10.652195] r3 : c88c4000  r2 : c88c41f8  r1 : 00120000  r0 : c88c41fc
[   10.658733] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[   10.665974] Control: 10c5387d  Table: 071e404a  DAC: 00000051
[   10.671728] Process kmodloader (pid: 648, stack limit = 0xc7346190)
[   10.678011] Stack: (0xc7347a00 to 0xc7348000)
[   10.682377] 7a00: c01ad490 c04bebec c716f600 60000013 c7347a5c 
c7347a20 c01ad26c c01ad49c
[   10.690576] 7a20: c7347a2c ffffffff 00000051 00000000 c7347a74 
c70f5000 c716f600 00000000
[   10.698775] 7a40: 00000000 00000000 c716fe00 00000000 c7347aa4 
c7347a60 c01afad8 c01ad21c
[   10.706974] 7a60: c01d9750 c017d4c8 c7347a8c c7347a78 c01ae8e0 
c01d9740 c70f5000 c716f600
[   10.715173] 7a80: c7347aa4 c70f5000 c716f600 00000000 00000000 
00000000 c7347acc c7347aa8
[   10.723373] 7aa0: c01b0174 c01afabc c7347ac4 00120000 c716f600 
c716f600 00000001 00000000
[   10.731570] 7ac0: c7347aec c7347ad0 c01b0210 c01b0100 c716f600 
00000008 00000001 00000002
[   10.739770] 7ae0: c7347b14 c7347af0 c01b0fb0 c01b01b8 c70f5800 
c716f600 00000001 00000002
[   10.747969] 7b00: 00000000 c716fe00 c7347b74 c7347b18 c01b0db8 
c01b0f94 c0053284 c0055958
[   10.756168] 7b20: c70f5800 c7347b3c c7347b74 00000000 00000000 
00000000 00000000 00000001
[   10.764368] 7b40: 00000001 00ff0201 c7347b74 c716fe00 c70f5800 
00000001 00000001 c716fe14
[   10.772568] 7b60: c716f800 00000000 c7347b9c c7347b78 c01b1010 
c01b0aa8 c70f6000 c716fe00
[   10.780766] 7b80: 00000000 00000001 00000000 c716f800 c7347bfc 
c7347ba0 c01b0db8 c01b0f94
[   10.788965] 7ba0: c0053284 c0055958 c70f6000 c7347bc4 c7347bfc 
00000000 00000000 00000000
[   10.797164] 7bc0: 00000000 00000001 00010001 00ff0100 c7347bfc 
c716f800 c70f6000 00000001
[   10.805363] 7be0: 00000000 c716f814 bf0641d0 c0075878 c7347c24 
c7347c00 c01b1010 c01b0aa8
[   10.813563] 7c00: c7209a90 c716f800 00000000 00000330 00000004 
bf0641d0 c7347c8c c7347c28
[   10.821762] 7c20: bf0606ac c01b0f94 c7347c94 c7a35e10 00000004 
bf0641d0 c7347c5c c7347c94
[   10.829961] 7c40: c0024e78 901201f0 c7347c94 c7347c9c c7347c7c 
c7347c60 01060400 c0024e68
[   10.838161] 7c60: c7209a90 c7209a90 c7347c94 c7a35e00 c7a35e10 
00000004 bf0641d0 c0075878
[   10.846360] 7c80: c7347cd4 c7347c90 bf0640f4 bf060130 c7a35e10 
c7347c94 c7347c94 40000000
[   10.854559] 7ca0: 47ffffff bf064154 00000200 c7347cb8 c0104c60 
c0104b78 c7a35e10 c04bf95c
[   10.862758] 7cc0: 00000000 c04bf958 c7347ce4 c7347cd8 c0230240 
bf064068 c7347d0c c7347ce8
[   10.870957] 7ce0: c01dd3d4 c0230224 c7a35e10 c7a35e44 bf0641d0 
c048bf34 c047a3c8 00000000
[   10.879156] 7d00: c7347d2c c7347d10 c01dd5a8 c01dd2e0 00000000 
bf0641d0 c01dd538 c048bf34
[   10.887356] 7d20: c7347d54 c7347d30 c01dbbd0 c01dd544 c788975c 
c7adf834 c7889770 bf0641d0
[   10.895555] 7d40: 00000000 c725ba00 c7347d64 c7347d58 c01dcf70 
c01dbb68 c7347d8c c7347d68
[   10.903754] 7d60: c01dcb7c c01dcf5c bf064181 c7347d78 bf0641d0 
bf066000 c047d9c8 c047d9c8
[   10.911952] 7d80: c7347da4 c7347d90 c01ddc34 c01dcab4 c73d6700 
bf066000 c7347db4 c7347da8
[   10.920152] 7da0: c02304fc c01ddb9c c7347dc4 c7347db8 bf066018 
c02304e0 c7347e44 c7347dc8
[   10.928351] 7dc0: c001393c bf06600c c047ccc4 c6df8000 c7ff1420 
40000000 00000000 00000000
[   10.936550] 7de0: 00000015 c0075878 c7347e1c c7347df8 c00875c8 
c00871d4 00000000 c73d6640
[   10.944749] 7e00: c8b3a000 00000001 00000000 00000001 c73d6640 
c8b3a000 00000001 dc8ba606
[   10.952948] 7e20: bf064240 c716ea00 c73d6640 c716eb80 00000000 
00000015 c7347e6c c7347e48
[   10.961147] 7e40: c0076c04 c001379c c7347e6c c7347e58 c00a99ac 
c7347f34 c716ea00 bf064240
[   10.969347] 7e60: c7347f2c c7347e70 c0078270 c0076bb0 bf06424c 
00007fff bf064240 c0075d28
[   10.977546] 7e80: 00012377 bf0643a0 c8b3abb8 c03d97d4 0000001c 
c8b3a3c8 0000001c bf064288
[   10.985745] 7ea0: c73d6640 024002c2 00000000 00000000 00000000 
00000000 00000000 00000000
[   10.993945] 7ec0: 65696370 7270695f 0000636f 00000000 00000000 
00000000 00000000 00000000
[   11.002143] 7ee0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 dc8ba606
[   11.010344] 7f00: c0078734 00000c08 01c6bc18 00000000 c8b3ac08 
00012377 c7346000 00000051
[   11.018542] 7f20: c7347fa4 c7347f30 c00787f0 c0076dd8 c7455cb8 
c8b3a000 00000c08 c8b3a8c0
[   11.026741] 7f40: c8b3a46f c8b3a6e4 000003c0 00000420 00000000 
00000000 00000000 00000308
[   11.034939] 7f60: 00000013 00000014 0000000e 00000000 00000008 
00000000 c00b64a4 00000000
[   11.043139] 7f80: 00000000 00000005 00000080 c00098c4 c7346000 
00000000 00000000 c7347fa8
[   11.051338] 7fa0: c0009700 c00786e0 00000000 00000000 01c6b010 
00000c08 00012377 0000fe00
[   11.059537] 7fc0: 00000000 00000000 00000005 00000080 00000c08 
00000000 00000001 00000000
[   11.067738] 7fe0: bee00d34 bee00d18 00011abc b6f5537c 60000010 
01c6b010 ffffffff ffffffff
[   11.075929] Backtrace:
[   11.078396] [<c01ad490>] (pci_generic_config_read32) from 
[<c01ad26c>] (pci_bus_read_config_byte+0x5c/0x84)
[   11.088160]  r7:60000013 r6:c716f600 r5:c04bebec r4:c01ad490
[   11.093867] [<c01ad210>] (pci_bus_read_config_byte) from [<c01afad8>] 
(pci_setup_device+0x28/0x3f4)
[   11.102930]  r10:00000000 r9:c716fe00 r8:00000000 r7:00000000 
r6:00000000 r5:c716f600
[   11.110816]  r4:c70f5000
[   11.113363] [<c01afab0>] (pci_setup_device) from [<c01b0174>] 
(pci_scan_single_device+0x80/0xb8)
[   11.122166]  r8:00000000 r7:00000000 r6:00000000 r5:c716f600 r4:c70f5000
[   11.128925] [<c01b00f4>] (pci_scan_single_device) from [<c01b0210>] 
(pci_scan_slot+0x64/0xe4)
[   11.137468]  r7:00000000 r6:00000001 r5:c716f600 r4:c716f600
[   11.143174] [<c01b01ac>] (pci_scan_slot) from [<c01b0fb0>] 
(pci_scan_child_bus+0x28/0xa8)
[   11.151368]  r7:00000002 r6:00000001 r5:00000008 r4:c716f600
[   11.157074] [<c01b0f88>] (pci_scan_child_bus) from [<c01b0db8>] 
(pci_scan_bridge+0x31c/0x4ec)
[   11.165616]  r9:c716fe00 r8:00000000 r7:00000002 r6:00000001 
r5:c716f600 r4:c70f5800
[   11.173420] [<c01b0a9c>] (pci_scan_bridge) from [<c01b1010>] 
(pci_scan_child_bus+0x88/0xa8)
[   11.181789]  r10:00000000 r9:c716f800 r8:c716fe14 r7:00000001 
r6:00000001 r5:c70f5800
[   11.189674]  r4:c716fe00
[   11.192221] [<c01b0f88>] (pci_scan_child_bus) from [<c01b0db8>] 
(pci_scan_bridge+0x31c/0x4ec)
[   11.200763]  r9:c716f800 r8:00000000 r7:00000001 r6:00000000 
r5:c716fe00 r4:c70f6000
[   11.208566] [<c01b0a9c>] (pci_scan_bridge) from [<c01b1010>] 
(pci_scan_child_bus+0x88/0xa8)
[   11.216935]  r10:c0075878 r9:bf0641d0 r8:c716f814 r7:00000000 
r6:00000001 r5:c70f6000
[   11.224821]  r4:c716f800
[   11.227371] [<c01b0f88>] (pci_scan_child_bus) from [<bf0606ac>] 
(iproc_pcie_setup+0x588/0x690 [pcie_iproc])
[   11.237129]  r9:bf0641d0 r8:00000004 r7:00000330 r6:00000000 
r5:c716f800 r4:c7209a90
[   11.244937] [<bf060124>] (iproc_pcie_setup [pcie_iproc]) from 
[<bf0640f4>] (iproc_pcie_bcma_probe+0x98/0xd0 [pcie_iproc_bcma])
[   11.256347]  r10:c0075878 r9:bf0641d0 r8:00000004 r7:c7a35e10 
r6:c7a35e00 r5:c7347c94
[   11.264233]  r4:c7209a90
[   11.266791] [<bf06405c>] (iproc_pcie_bcma_probe [pcie_iproc_bcma]) 
from [<c0230240>] (bcma_device_probe+0x28/0x34)
[   11.277158]  r7:c04bf958 r6:00000000 r5:c04bf95c r4:c7a35e10
[   11.282873] [<c0230218>] (bcma_device_probe) from [<c01dd3d4>] 
(driver_probe_device+0x100/0x264)
[   11.291683] [<c01dd2d4>] (driver_probe_device) from [<c01dd5a8>] 
(__driver_attach+0x70/0x94)
[   11.300136]  r9:00000000 r8:c047a3c8 r7:c048bf34 r6:bf0641d0 
r5:c7a35e44 r4:c7a35e10
[   11.307942] [<c01dd538>] (__driver_attach) from [<c01dbbd0>] 
(bus_for_each_dev+0x74/0x98)
[   11.316134]  r7:c048bf34 r6:c01dd538 r5:bf0641d0 r4:00000000
[   11.321842] [<c01dbb5c>] (bus_for_each_dev) from [<c01dcf70>] 
(driver_attach+0x20/0x28)
[   11.329861]  r6:c725ba00 r5:00000000 r4:bf0641d0
[   11.334515] [<c01dcf50>] (driver_attach) from [<c01dcb7c>] 
(bus_add_driver+0xd4/0x1f0)
[   11.342453] [<c01dcaa8>] (bus_add_driver) from [<c01ddc34>] 
(driver_register+0xa4/0xe8)
[   11.350472]  r7:c047d9c8 r6:c047d9c8 r5:bf066000 r4:bf0641d0
[   11.356180] [<c01ddb90>] (driver_register) from [<c02304fc>] 
(__bcma_driver_register+0x28/0x30)
[   11.364894]  r5:bf066000 r4:c73d6700
[   11.368498] [<c02304d4>] (__bcma_driver_register) from [<bf066018>] 
(init_module+0x18/0x24 [pcie_iproc_bcma])
[   11.378448] [<bf066000>] (init_module [pcie_iproc_bcma]) from 
[<c001393c>] (do_one_initcall+0x1ac/0x1ec)
[   11.387951] [<c0013790>] (do_one_initcall) from [<c0076c04>] 
(do_init_module+0x60/0x1a4)
[   11.396055]  r9:00000015 r8:00000000 r7:c716eb80 r6:c73d6640 
r5:c716ea00 r4:bf064240
[   11.403858] [<c0076ba4>] (do_init_module) from [<c0078270>] 
(load_module+0x14a4/0x1908)
[   11.411879]  r6:bf064240 r5:c716ea00 r4:c7347f34
[   11.416531] [<c0076dcc>] (load_module) from [<c00787f0>] 
(SyS_init_module+0x11c/0x13c)
[   11.424465]  r10:00000051 r9:c7346000 r8:00012377 r7:c8b3ac08 
r6:00000000 r5:01c6bc18
[   11.432350]  r4:00000c08
[   11.434900] [<c00786d4>] (SyS_init_module) from [<c0009700>] 
(ret_fast_syscall+0x0/0x3c)
[   11.443003]  r10:00000000 r9:c7346000 r8:c00098c4 r7:00000080 
r6:00000005 r5:00000000
[   11.450890]  r4:00000000
[   11.453437] Code: e5853000 e89da8f0 e5901000 f57ff04f (e3560002)
[   11.459545] ---[ end trace 904ac2ae157d3f83 ]---
