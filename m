From: achandran@mvista.com (Arun Chandran)
Date: Thu, 6 Nov 2014 21:43:04 +0530
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141106152830.GF23706@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
Message-ID: <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 6, 2014 at 8:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Nov 06, 2014 at 12:16:12PM +0000, Arun Chandran wrote:
>> Hi Geoff,
>>
>> I am trying this on my hardware (apm-mustang.dtb)
>>
>> On Fri, Oct 24, 2014 at 4:40 AM, Geoff Levand <geoff@infradead.org> wrote:
>> > Hi All,
>> >
>> > This series adds the core support for kexec re-boots on arm64.  I have tested
>> > with the ARM VE fast model, the ARM Base model and the ARM Foundation
>> > model with various kernel config options for both the first and second stage
>> > kernels.
>> >
>> > To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
>> > kexec-tools [2], which have not yet been merged upstream, are needed.
>> >
>> > Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
>> > routine the ability to switch exception levels from EL1 to EL2 for kernels that
>> > were entered in EL2.
>> >
>> > Patches 5 and 6 convert the use of device tree /memreserve/ to device tree
>> > reserved-memory nodes.
>> >
>> > Patch 7 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
>> > dcache_line_size macro it defines can be uesd by kexec's relocate kernel
>> > routine.
>> >
>> > Patches 8-10 add the actual kexec support.
>> >
>> > Please consider all patches for inclusion.  Any comments or suggestions on how
>> > to improve are welcome.
>> >
>> > [1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
>> > [2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git
>> >
>> > Several things are known to have problems on kexec re-boot:
>> >
>> > spin-table
>> > ----------
>> >
>> > PROBLEM: The spin-table enable method does not implement all the methods needed
>> > for CPU hot-plug, so the first stage kernel cannot be shutdown properly.
>> >
>> > WORK-AROUND: Upgrade to system firmware that provides PSCI enable method
>> > support, OR build the first stage kernel with CONFIG_SMP=n, OR pass 'maxcpus=1'
>> > on the first stage kernel command line.
>>
>> I have CONFIG_SMP=n
>>
>> >
>> > FIX: Upgrade system firmware to provide PSCI enable method support.
>> >
>> > KVM
>> > ---
>> >
>> > PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
>> > resources on shutdown, so the first stage kernel cannot be shutdown properly.
>> >
>> > WORK-AROUND:  Build the first stage kernel with CONFIG_KVM=n.
>>
>> KVM also disabled.
>>
>> /root at genericarmv8:~# usr/local/sbin/kexec --lite -l vmlinux
>> --dtb=apm-mustang.dtb --command-line=
>> "root=/dev/nfs rw
>> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
>>  ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
>> earlyprintk=uart8250-32bit,0x1c020000"
>>
>> kexec version: 14.10.21.16.36-ga38e0a6
>> arch_process_options:85: command_line: root=/dev/nfs rw
>> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
>> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
>> earlyprintk=uart8250-32bit,0x1
>> c020000
>> arch_process_options:87: initrd: (null)
>> arch_process_options:88: dtb: apm-mustang.dtb
>> arch_process_options:89: lite: 1
>> kernel: 0x7f756e7010 kernel_size: 0x488a308
>> Modified cmdline: root=/dev/nfs
>> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
>> from purgatory is diabled
>> get_memory_ranges_dt:638: node_1516 memory
>> get_memory_ranges_dt:664:  RAM: 0000004000000000 - 0000004400000000
>> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
>> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
>> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
>> get_memory_ranges_dt:678: Success
>> elf_arm64_load: PE format: yes
>> p_vaddr: ffffffc000080000
>> virt_to_phys: ffffffc000080000 -> 0000004000080000
>> add_segment_phys_virt: 0000007f756f7010 - 0000007f75d3cf70 (00645f60)
>> -> 0000004000080000 - 00000040006fb000 (0067b000)
>> elf_arm64_load: text_offset: 0000000000080000
>> elf_arm64_load: image_size:  000000000067f000
>> elf_arm64_load: page_offset: ffffffc000000000
>> elf_arm64_load: memstart:    0000004000000000
>> virt_to_phys: ffffffc000080000 -> 0000004000080000
>> elf_arm64_load: e_entry:     ffffffc000080000 -> 0000004000080000
>> virt_to_phys: ffffffc000080000 -> 0000004000080000
>> Modified cmdline:root=/dev/nfs rw
>> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
>> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
>> earlyprintk=uart8250-32bit,0x1c020000
>> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
>> from purgatory is diabled
>> read_cpu_info: dtb_1 cpu-0 (/cpus/cpu at 000): hwid-0, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-1 (/cpus/cpu at 001): hwid-1, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-2 (/cpus/cpu at 100): hwid-100, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-3 (/cpus/cpu at 101): hwid-101, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-4 (/cpus/cpu at 200): hwid-200, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-5 (/cpus/cpu at 201): hwid-201, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-6 (/cpus/cpu at 300): hwid-300, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_1 cpu-7 (/cpus/cpu at 301): hwid-301, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-0 (/cpus/cpu at 000): hwid-0, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-1 (/cpus/cpu at 001): hwid-1, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-2 (/cpus/cpu at 100): hwid-100, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-3 (/cpus/cpu at 101): hwid-101, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-4 (/cpus/cpu at 200): hwid-200, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-5 (/cpus/cpu at 201): hwid-201, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-6 (/cpus/cpu at 300): hwid-300, 'spin-table',
>> cpu-release-addr 400000fff8
>> read_cpu_info: dtb_2 cpu-7 (/cpus/cpu at 301): hwid-301, 'spin-table',
>> cpu-release-addr 400000fff8
>> check_cpu_properties: hwid-0: OK
>> check_cpu_properties: hwid-1: OK
>> check_cpu_properties: hwid-100: OK
>> check_cpu_properties: hwid-101: OK
>> check_cpu_properties: hwid-200: OK
>> check_cpu_properties: hwid-201: OK
>> check_cpu_properties: hwid-300: OK
>> check_cpu_properties: hwid-301: OK
>> dtb:    base 4000700000, size 221ch (8732)
>> add_segment_phys_virt: 0000000024c14c90 - 0000000024c16eac (0000221c)
>> -> 0000004000700000 - 0000004000703000 (00003000)
>> kexec_load: entry = 0x4000080000 flags = 0xb70000
>> nr_segments = 2
>> segment[0].buf   = 0x7f756f7010
>> segment[0].bufsz = 0x645f60
>> segment[0].mem   = 0x4000080000
>> segment[0].memsz = 0x67b000
>> segment[1].buf   = 0x24c14c90
>> segment[1].bufsz = 0x221c
>> segment[1].mem   = 0x4000700000
>> segment[1].memsz = 0x3000
>>
>> root at genericarmv8:~# /usr/local/sbin/kexec --lite -e
>> kexec version: 14.10.21.16.36-ga38e0a6
>> arch_process_options:85: command_line: (null)
>> arch_process_options:87: initrd: (null)
>> arch_process_options:88: dtb: (null)
>> arch_process_options:89: lite: 1
>> sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> kexec: Starting new kernel
>> Bye!
>>
>> It fails to come up.  In debugger I can see
>>
>>     Core number       : 0
>>     Core state        : debug (AArch64 EL1)
>>     Debug entry cause : External Debug Request
>>     Current PC        : 0xffffffc000083200
>
> That's a kernel virtual address, and it looks to be somewhere early in
> the boot path, given it's close to PAGE_OFFSET + TEXT_OFFSET.
>
Yes. My earlyconsole setting was wrong that is why I did not see
anything in console for the kexec rebooting.

With correct earlycon setting I can see

root at genericarmv8:~# /usr/local/sbin/kexec --lite -l vmlinux
--dtb=apm-mustang.dtb --command-line=
"root=/dev/nfs rw
nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
 ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
earlycon=uart8250,mmio32,0x1c020000"

root at genericarmv8:~# /usr/local/sbin/kexec --lite -e
kexec version: 14.10.21.16.36-ga38e0a6
arch_process_options:85: command_line: (null)
arch_process_options:87: initrd: (null)
arch_process_options:88: dtb: (null)
arch_process_options:89: lite: 1
sd 0:0:0:0: [sda] Synchronizing SCSI cache
kexec: Starting new kernel
Bye!
Initializing cgroup subsys cpu
Linux version 3.17.0-rc4+ (arun at arun-OptiPlex-9010) (gcc version 4.9.1
20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro
GCC 4.9-2014.05) ) #12 PREEMPT Thu Nov 6 21:38:03 IST 2014
CPU: AArch64 Processor [500f0000] revision 0
Detected PIPT I-cache on CPU0
Ignoring memory block 0x100000000 - 0x180000000
Early serial console at MMIO32 0x1c020000 (options '')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
efi: UEFI not found.
cma: Failed to reserve 16 MiB
Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-rc4+ #12
Call trace:
[<ffffffc000087cf0>] dump_backtrace+0x0/0x124
[<ffffffc000087e24>] show_stack+0x10/0x1c
[<ffffffc0004bcee8>] dump_stack+0x1c/0x28
[<ffffffc0004bc27c>] panic+0xd8/0x230
[<ffffffc00065510c>] memblock_alloc_base+0x2c/0x3c
[<ffffffc000655128>] memblock_alloc+0xc/0x18
[<ffffffc00064d6cc>] early_alloc.constprop.5+0x14/0x4c
[<ffffffc00064db50>] paging_init+0x124/0x1b8
[<ffffffc00064b758>] setup_arch+0x2a8/0x464
[<ffffffc00064966c>] start_kernel+0x88/0x38c
---[ end Kernel panic - not syncing: ERROR: Failed to allocate 0x1000
bytes below 0x0.

Bad mode in Synchronous Abort handler detected, code 0x86000005
CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-rc4+ #12
task: ffffffc000688460 ti: ffffffc00067c000 task.ti: ffffffc00067c000
PC is at 0x0
LR is at el1_irq+0x64/0xd0
pc : [<0000000000000000>] lr : [<ffffffc000083da4>] pstate: 800001c5
sp : ffffffc00067fc90
x29: ffffffc00067fdb0 x28: 0000000000000000
x27: ffffffc0005cf500 x26: 0000000000000000
x25: ffffffc000697000 x24: ffffffc000000000
x23: 0000000080000245 x22: ffffffc0004bc384
x21: ffffffc00067fdb0 x20: ffffffc0006c8000
x19: ffffffc0006c84d0 x18: 0000000000000004
x17: 0000000000000040 x16: ffffffc0006d6948
x15: 00000000ffffffff x14: 3030317830206574
x13: 61636f6c6c61206f x12: 742064656c696146
x11: 203a524f52524520 x10: 3a676e69636e7973
x9 : 20746f6e202d2063 x8 : 0000000000000018
x7 : 2073657479622030 x6 : ffffffc0006c9b57
x5 : ffffffc0006ca91c x4 : 0000000000000004
x3 : 0000000000000003 x2 : 0000000000200002
x1 : 0000000000000000 x0 : ffffffc00067fc90

Internal error: Oops - bad mode: 0 [#1] PREEMPT
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-rc4+ #12
task: ffffffc000688460 ti: ffffffc00067c000 task.ti: ffffffc00067c000
PC is at 0x0
LR is at el1_irq+0x64/0xd0
pc : [<0000000000000000>] lr : [<ffffffc000083da4>] pstate: 800001c5
sp : ffffffc00067fc90
x29: ffffffc00067fdb0 x28: 0000000000000000
x27: ffffffc0005cf500 x26: 0000000000000000
x25: ffffffc000697000 x24: ffffffc000000000
x23: 0000000080000245 x22: ffffffc0004bc384
x21: ffffffc00067fdb0 x20: ffffffc0006c8000
x19: ffffffc0006c84d0 x18: 0000000000000004
x17: 0000000000000040 x16: ffffffc0006d6948
x15: 00000000ffffffff x14: 3030317830206574
x13: 61636f6c6c61206f x12: 742064656c696146
x11: 203a524f52524520 x10: 3a676e69636e7973
x9 : 20746f6e202d2063 x8 : 0000000000000018
x7 : 2073657479622030 x6 : ffffffc0006c9b57
x5 : ffffffc0006ca91c x4 : 0000000000000004
x3 : 0000000000000003 x2 : 0000000000200002
x1 : 0000000000000000 x0 : ffffffc00067fc90

Process swapper (pid: 0, stack limit = 0xffffffc00067c058)
Stack: (0xffffffc00067fc90 to 0xffffffc000680000)
fc80:                                     00000057 00000000 00000057 00000000
fca0: 00200002 00000000 00000003 00000000 00000004 00000000 006ca91c ffffffc0
fcc0: 006c9b57 ffffffc0 79622030 20736574 00000018 00000000 202d2063 20746f6e
fce0: 636e7973 3a676e69 52524520 203a524f 6c696146 74206465 6c61206f 61636f6c
fd00: 30206574 30303178 ffffffff 00000000 006d6948 ffffffc0 00000040 00000000
fd20: 00000004 00000000 006c84d0 ffffffc0 006c8000 ffffffc0 00000000 00000000
fd40: 00000000 00000000 006c8000 ffffffc0 00000000 ffffffc0 00697000 ffffffc0
fd60: 00000000 00000000 005cf500 ffffffc0 00000000 00000000 0067fdb0 ffffffc0
fd80: 004bc380 ffffffc0 0067fdb0 ffffffc0 004bc384 ffffffc0 80000245 00000000
fda0: 006c9b2c ffffffc0 5d3e6336 61747320 0067fe70 ffffffc0 00655110 ffffffc0
fdc0: 00000000 00000000 00001000 00000000 006c8000 ffffffc0 00000018 00000000
fde0: ffffffff ffffff7f 00000000 ffffffc0 0067fe70 ffffffc0 0067fe70 ffffffc0
fe00: 0067fe30 ffffffc0 ffffffc8 00000000 0067fe70 ffffffc0 0067fe70 ffffffc0
fe20: 0067fe30 ffffffc0 ffffffc8 00000000 0067fe60 ffffffc0 00001000 00000000
fe40: 00000000 00000000 006979e8 ffffffc0 0067fe28 ffffffc0 0067fe30 ffffffc0
fe60: 00000000 00000000 ffffffff 00000000 0067fe90 ffffffc0 0065512c ffffffc0
fe80: 40000000 00000040 006d6948 ffffffc0 0067fea0 ffffffc0 0064d6d0 ffffffc0
fea0: 0067fec0 ffffffc0 0064db54 ffffffc0 40000000 00000040 006ecba8 ffffffc0
fec0: 0067ff40 ffffffc0 0064b75c ffffffc0 006c80c0 ffffffc0 00080000 ffffffc0
fee0: 0067ffe8 ffffffc0 0068a000 ffffffc0 00697000 ffffffc0 006c8000 ffffffc0
ff00: 006fb000 00000040 006fd000 00000040 000804a0 ffffffc0 00000000 00000080
ff20: 0067ff40 ffffffc0 0064b758 ffffffc0 006c80c0 ffffffc0 00080000 ffffffc0
ff40: 0067ffa0 ffffffc0 00649670 ffffffc0 0066e910 ffffffc0 006c8000 ffffffc0
ff60: 006c8000 ffffffc0 00000000 00000000 0068a000 00000040 00000000 00000040
ff80: 006fb000 00000040 006fd000 00000040 00000080 00000000 00700000 00000040
ffa0: 00000000 00000000 00080284 00000040 00094da0 00000040 00000e12 00000000
ffc0: 00700000 00000040 500f0000 00000000 0068a000 00000040 00000000 00000000
ffe0: 00000000 00000000 0066e910 ffffffc0 00000000 00000000 00000000 00000000
Call trace:
[<          (null)>]           (null)
[<ffffffc00065510c>] memblock_alloc_base+0x2c/0x3c
[<ffffffc000655128>] memblock_alloc+0xc/0x18
[<ffffffc00064d6cc>] early_alloc.constprop.5+0x14/0x4c
[<ffffffc00064db50>] paging_init+0x124/0x1b8
[<ffffffc00064b758>] setup_arch+0x2a8/0x464
[<ffffffc00064966c>] start_kernel+0x88/0x38c
Code: bad PC value
Bad mode in Synchronous Abort handler detected, code 0x86000005
CPU: 0 PID: 0 Comm: swapper Tainted: G      D        3.17.0-rc4+ #12
task: ffffffc000688460 ti: ffffffc00067c000 task.ti: ffffffc00067c000
PC is at 0x0
LR is at el1_irq+0x64/0xd0
pc : [<0000000000000000>] lr : [<ffffffc000083da4>] pstate: 600001c5
sp : ffffffc00067f960
x29: ffffffc00067fa80 x28: 0000000000000000
x27: ffffffc0005cf500 x26: 0000000000000000
x25: ffffffc000697000 x24: 0000000000000021
x23: 0000000060000145 x22: ffffffc000087f00
x21: ffffffc00067fa80 x20: 0000000000000000
x19: ffffffc00067fb70 x18: 0000000000000004
x17: 0000000000000040 x16: ffffffc0006d6948
x15: 00000000ffffffff x14: 0ffffffffffffffe
x13: 0000000000000020 x12: 0101010101010101
x11: 000000000000006d x10: 0000000000000002
x9 : 0000000000000000 x8 : 000000000000006e
x7 : 0000000000000024 x6 : ffffffc0006c9b12
x5 : ffffffc0006cc108 x4 : 0000000000000008
x3 : 0000000000000080 x2 : 0000000000000080
x1 : 0000000000000000 x0 : ffffffc00067f960

--Arun






> Can you figure out what this corresponds to in your kernel image?
>
> Thanks,
> Mark.
