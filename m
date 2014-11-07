From: achandran@mvista.com (Arun Chandran)
Date: Fri, 7 Nov 2014 12:06:55 +0530
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141106183940.GB2052@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
 <20141106183940.GB2052@leverpostej>
Message-ID: <CAFdej03oxyrLv5BbLLdQzv7W031stN4jbHs4Hi3jQHorF=LOiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 7, 2014 at 12:09 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Nov 06, 2014 at 04:13:04PM +0000, Arun Chandran wrote:
>> On Thu, Nov 6, 2014 at 8:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Thu, Nov 06, 2014 at 12:16:12PM +0000, Arun Chandran wrote:
>> >> Hi Geoff,
>> >>
>> >> I am trying this on my hardware (apm-mustang.dtb)
>> >>
>> >> On Fri, Oct 24, 2014 at 4:40 AM, Geoff Levand <geoff@infradead.org> wrote:
>> >> > Hi All,
>> >> >
>> >> > This series adds the core support for kexec re-boots on arm64.  I have tested
>> >> > with the ARM VE fast model, the ARM Base model and the ARM Foundation
>> >> > model with various kernel config options for both the first and second stage
>> >> > kernels.
>> >> >
>> >> > To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
>> >> > kexec-tools [2], which have not yet been merged upstream, are needed.
>> >> >
>> >> > Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
>> >> > routine the ability to switch exception levels from EL1 to EL2 for kernels that
>> >> > were entered in EL2.
>> >> >
>> >> > Patches 5 and 6 convert the use of device tree /memreserve/ to device tree
>> >> > reserved-memory nodes.
>> >> >
>> >> > Patch 7 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
>> >> > dcache_line_size macro it defines can be uesd by kexec's relocate kernel
>> >> > routine.
>> >> >
>> >> > Patches 8-10 add the actual kexec support.
>> >> >
>> >> > Please consider all patches for inclusion.  Any comments or suggestions on how
>> >> > to improve are welcome.
>> >> >
>> >> > [1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
>> >> > [2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git
>> >> >
>> >> > Several things are known to have problems on kexec re-boot:
>> >> >
>> >> > spin-table
>> >> > ----------
>> >> >
>> >> > PROBLEM: The spin-table enable method does not implement all the methods needed
>> >> > for CPU hot-plug, so the first stage kernel cannot be shutdown properly.
>> >> >
>> >> > WORK-AROUND: Upgrade to system firmware that provides PSCI enable method
>> >> > support, OR build the first stage kernel with CONFIG_SMP=n, OR pass 'maxcpus=1'
>> >> > on the first stage kernel command line.
>> >>
>> >> I have CONFIG_SMP=n
>> >>
>> >> >
>> >> > FIX: Upgrade system firmware to provide PSCI enable method support.
>> >> >
>> >> > KVM
>> >> > ---
>> >> >
>> >> > PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
>> >> > resources on shutdown, so the first stage kernel cannot be shutdown properly.
>> >> >
>> >> > WORK-AROUND:  Build the first stage kernel with CONFIG_KVM=n.
>> >>
>> >> KVM also disabled.
>> >>
>> >> /root at genericarmv8:~# usr/local/sbin/kexec --lite -l vmlinux
>> >> --dtb=apm-mustang.dtb --command-line=
>> >> "root=/dev/nfs rw
>> >> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
>> >>  ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
>> >> earlyprintk=uart8250-32bit,0x1c020000"
>> >>
>> >> kexec version: 14.10.21.16.36-ga38e0a6
>> >> arch_process_options:85: command_line: root=/dev/nfs rw
>> >> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
>> >> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
>> >> earlyprintk=uart8250-32bit,0x1
>> >> c020000
>> >> arch_process_options:87: initrd: (null)
>> >> arch_process_options:88: dtb: apm-mustang.dtb
>> >> arch_process_options:89: lite: 1
>> >> kernel: 0x7f756e7010 kernel_size: 0x488a308
>> >> Modified cmdline: root=/dev/nfs
>> >> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
>> >> from purgatory is diabled
>> >> get_memory_ranges_dt:638: node_1516 memory
>> >> get_memory_ranges_dt:664:  RAM: 0000004000000000 - 0000004400000000
>
> Does this look correct to you? That doesn't match what I see in
> apm-mustang.dts in mainline (where memory starts at 0x1_00000000).
>
>> >> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
>> >> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
>> >> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
>
> This looks suspicious, but I haven't investigated the underlying code.
>
>> >> get_memory_ranges_dt:678: Success
>> >> elf_arm64_load: PE format: yes
>> >> p_vaddr: ffffffc000080000
>> >> virt_to_phys: ffffffc000080000 -> 0000004000080000
>> >> add_segment_phys_virt: 0000007f756f7010 - 0000007f75d3cf70 (00645f60)
>> >> -> 0000004000080000 - 00000040006fb000 (0067b000)
>> >> elf_arm64_load: text_offset: 0000000000080000
>> >> elf_arm64_load: image_size:  000000000067f000
>> >> elf_arm64_load: page_offset: ffffffc000000000
>> >> elf_arm64_load: memstart:    0000004000000000
>> >> virt_to_phys: ffffffc000080000 -> 0000004000080000
>> >> elf_arm64_load: e_entry:     ffffffc000080000 -> 0000004000080000
>> >> virt_to_phys: ffffffc000080000 -> 0000004000080000
>
> So we'll load the kernel at this address...
>
> [...]
>
>> root at genericarmv8:~# /usr/local/sbin/kexec --lite -e
>> kexec version: 14.10.21.16.36-ga38e0a6
>> arch_process_options:85: command_line: (null)
>> arch_process_options:87: initrd: (null)
>> arch_process_options:88: dtb: (null)
>> arch_process_options:89: lite: 1
>> sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> kexec: Starting new kernel
>> Bye!
>> Initializing cgroup subsys cpu
>> Linux version 3.17.0-rc4+ (arun at arun-OptiPlex-9010) (gcc version 4.9.1
>> 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro
>> GCC 4.9-2014.05) ) #12 PREEMPT Thu Nov 6 21:38:03 IST 2014
>> CPU: AArch64 Processor [500f0000] revision 0
>> Detected PIPT I-cache on CPU0
>> Ignoring memory block 0x100000000 - 0x180000000
>
> ... then the kernel finds the single memory region described in
> apm-mustang.dts which happens to be below PHYS_OFFSET for your board. So
> the kernel ignores it because it cannot address it ...
>
>> Early serial console at MMIO32 0x1c020000 (options '')
>> bootconsole [uart0] enabled
>> efi: Getting EFI parameters from FDT:
>> efi: UEFI not found.
>> cma: Failed to reserve 16 MiB
>> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.
>
> ... and then explodes because it knows of no memory outside of the kernel
> Image.

Thanks for the nice explanation. Yes with the mainline dtb kexec won't
work. Kexec works when I don't pass dtb to it.

It will work (mainline dtb) only when it passes through the
bootloader. Bootloader does
a lot of modification to the dtb.

For exmple.

Memory node is changed from

        memory {
                device_type = "memory";
                reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by
bootloader */
        };

to

root at genericarmv8:~# hexdump /proc/device-tree/memory/reg
0000000 0000 4000 0000 0000 0000 0400 0000 0000
0000010 0000 0000 0000 0000 0000 0000 0000 0000
*
0000040

--Arun
