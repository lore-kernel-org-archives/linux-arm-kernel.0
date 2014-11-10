From: dyoung@redhat.com (Dave Young)
Date: Mon, 10 Nov 2014 15:17:52 +0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
Message-ID: <20141110071752.GC6960@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/14 at 09:43pm, Arun Chandran wrote:
> On Thu, Nov 6, 2014 at 8:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Nov 06, 2014 at 12:16:12PM +0000, Arun Chandran wrote:
> >> Hi Geoff,
> >>
> >> I am trying this on my hardware (apm-mustang.dtb)
> >>
> >> On Fri, Oct 24, 2014 at 4:40 AM, Geoff Levand <geoff@infradead.org> wrote:
> >> > Hi All,
> >> >
> >> > This series adds the core support for kexec re-boots on arm64.  I have tested
> >> > with the ARM VE fast model, the ARM Base model and the ARM Foundation
> >> > model with various kernel config options for both the first and second stage
> >> > kernels.
> >> >
> >> > To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> >> > kexec-tools [2], which have not yet been merged upstream, are needed.
> >> >
> >> > Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
> >> > routine the ability to switch exception levels from EL1 to EL2 for kernels that
> >> > were entered in EL2.
> >> >
> >> > Patches 5 and 6 convert the use of device tree /memreserve/ to device tree
> >> > reserved-memory nodes.
> >> >
> >> > Patch 7 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
> >> > dcache_line_size macro it defines can be uesd by kexec's relocate kernel
> >> > routine.
> >> >
> >> > Patches 8-10 add the actual kexec support.
> >> >
> >> > Please consider all patches for inclusion.  Any comments or suggestions on how
> >> > to improve are welcome.
> >> >
> >> > [1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
> >> > [2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git
> >> >
> >> > Several things are known to have problems on kexec re-boot:
> >> >
> >> > spin-table
> >> > ----------
> >> >
> >> > PROBLEM: The spin-table enable method does not implement all the methods needed
> >> > for CPU hot-plug, so the first stage kernel cannot be shutdown properly.
> >> >
> >> > WORK-AROUND: Upgrade to system firmware that provides PSCI enable method
> >> > support, OR build the first stage kernel with CONFIG_SMP=n, OR pass 'maxcpus=1'
> >> > on the first stage kernel command line.
> >>
> >> I have CONFIG_SMP=n
> >>
> >> >
> >> > FIX: Upgrade system firmware to provide PSCI enable method support.
> >> >
> >> > KVM
> >> > ---
> >> >
> >> > PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
> >> > resources on shutdown, so the first stage kernel cannot be shutdown properly.
> >> >
> >> > WORK-AROUND:  Build the first stage kernel with CONFIG_KVM=n.
> >>
> >> KVM also disabled.
> >>
> >> /root at genericarmv8:~# usr/local/sbin/kexec --lite -l vmlinux
> >> --dtb=apm-mustang.dtb --command-line=
> >> "root=/dev/nfs rw
> >> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
> >>  ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
> >> earlyprintk=uart8250-32bit,0x1c020000"
> >>
> >> kexec version: 14.10.21.16.36-ga38e0a6
> >> arch_process_options:85: command_line: root=/dev/nfs rw
> >> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
> >> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
> >> earlyprintk=uart8250-32bit,0x1
> >> c020000
> >> arch_process_options:87: initrd: (null)
> >> arch_process_options:88: dtb: apm-mustang.dtb
> >> arch_process_options:89: lite: 1
> >> kernel: 0x7f756e7010 kernel_size: 0x488a308
> >> Modified cmdline: root=/dev/nfs
> >> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
> >> from purgatory is diabled
> >> get_memory_ranges_dt:638: node_1516 memory
> >> get_memory_ranges_dt:664:  RAM: 0000004000000000 - 0000004400000000
> >> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
> >> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
> >> get_memory_ranges_dt:659: SKIP: 0000000000000000 - 0000000000000000
> >> get_memory_ranges_dt:678: Success
> >> elf_arm64_load: PE format: yes
> >> p_vaddr: ffffffc000080000
> >> virt_to_phys: ffffffc000080000 -> 0000004000080000
> >> add_segment_phys_virt: 0000007f756f7010 - 0000007f75d3cf70 (00645f60)
> >> -> 0000004000080000 - 00000040006fb000 (0067b000)
> >> elf_arm64_load: text_offset: 0000000000080000
> >> elf_arm64_load: image_size:  000000000067f000
> >> elf_arm64_load: page_offset: ffffffc000000000
> >> elf_arm64_load: memstart:    0000004000000000
> >> virt_to_phys: ffffffc000080000 -> 0000004000080000
> >> elf_arm64_load: e_entry:     ffffffc000080000 -> 0000004000080000
> >> virt_to_phys: ffffffc000080000 -> 0000004000080000
> >> Modified cmdline:root=/dev/nfs rw
> >> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
> >> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
> >> earlyprintk=uart8250-32bit,0x1c020000
> >> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
> >> from purgatory is diabled
> >> read_cpu_info: dtb_1 cpu-0 (/cpus/cpu at 000): hwid-0, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-1 (/cpus/cpu at 001): hwid-1, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-2 (/cpus/cpu at 100): hwid-100, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-3 (/cpus/cpu at 101): hwid-101, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-4 (/cpus/cpu at 200): hwid-200, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-5 (/cpus/cpu at 201): hwid-201, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-6 (/cpus/cpu at 300): hwid-300, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_1 cpu-7 (/cpus/cpu at 301): hwid-301, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-0 (/cpus/cpu at 000): hwid-0, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-1 (/cpus/cpu at 001): hwid-1, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-2 (/cpus/cpu at 100): hwid-100, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-3 (/cpus/cpu at 101): hwid-101, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-4 (/cpus/cpu at 200): hwid-200, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-5 (/cpus/cpu at 201): hwid-201, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-6 (/cpus/cpu at 300): hwid-300, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> read_cpu_info: dtb_2 cpu-7 (/cpus/cpu at 301): hwid-301, 'spin-table',
> >> cpu-release-addr 400000fff8
> >> check_cpu_properties: hwid-0: OK
> >> check_cpu_properties: hwid-1: OK
> >> check_cpu_properties: hwid-100: OK
> >> check_cpu_properties: hwid-101: OK
> >> check_cpu_properties: hwid-200: OK
> >> check_cpu_properties: hwid-201: OK
> >> check_cpu_properties: hwid-300: OK
> >> check_cpu_properties: hwid-301: OK
> >> dtb:    base 4000700000, size 221ch (8732)
> >> add_segment_phys_virt: 0000000024c14c90 - 0000000024c16eac (0000221c)
> >> -> 0000004000700000 - 0000004000703000 (00003000)
> >> kexec_load: entry = 0x4000080000 flags = 0xb70000
> >> nr_segments = 2
> >> segment[0].buf   = 0x7f756f7010
> >> segment[0].bufsz = 0x645f60
> >> segment[0].mem   = 0x4000080000
> >> segment[0].memsz = 0x67b000
> >> segment[1].buf   = 0x24c14c90
> >> segment[1].bufsz = 0x221c
> >> segment[1].mem   = 0x4000700000
> >> segment[1].memsz = 0x3000
> >>
> >> root at genericarmv8:~# /usr/local/sbin/kexec --lite -e
> >> kexec version: 14.10.21.16.36-ga38e0a6
> >> arch_process_options:85: command_line: (null)
> >> arch_process_options:87: initrd: (null)
> >> arch_process_options:88: dtb: (null)
> >> arch_process_options:89: lite: 1
> >> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >> kexec: Starting new kernel
> >> Bye!
> >>
> >> It fails to come up.  In debugger I can see
> >>
> >>     Core number       : 0
> >>     Core state        : debug (AArch64 EL1)
> >>     Debug entry cause : External Debug Request
> >>     Current PC        : 0xffffffc000083200
> >
> > That's a kernel virtual address, and it looks to be somewhere early in
> > the boot path, given it's close to PAGE_OFFSET + TEXT_OFFSET.
> >
> Yes. My earlyconsole setting was wrong that is why I did not see
> anything in console for the kexec rebooting.
> 
> With correct earlycon setting I can see

Arun, could you share how did you get the working earlycon? We might have
same problem.. 

Thanks
Dave
