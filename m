From: achandran@mvista.com (Arun Chandran)
Date: Fri, 7 Nov 2014 11:56:46 +0530
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <1415298309.12884.45.camel@smoke>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
 <1415298309.12884.45.camel@smoke>
Message-ID: <CAFdej02pbtuM=LqJszdX7tu0ZhsWBwpc--KFr=KinWRMkTaevg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 6, 2014 at 11:55 PM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Thu, 2014-11-06 at 21:43 +0530, Arun Chandran wrote:
>> Initializing cgroup subsys cpu
>> Linux version 3.17.0-rc4+ (arun at arun-OptiPlex-9010) (gcc version 4.9.1
>> 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro
>> GCC 4.9-2014.05) ) #12 PREEMPT Thu Nov 6 21:38:03 IST 2014
>> CPU: AArch64 Processor [500f0000] revision 0
>> Detected PIPT I-cache on CPU0
>> Ignoring memory block 0x100000000 - 0x180000000
>> Early serial console at MMIO32 0x1c020000 (options '')
>> bootconsole [uart0] enabled
>> efi: Getting EFI parameters from FDT:
>> efi: UEFI not found.
>> cma: Failed to reserve 16 MiB
>
> This error comes from cma_declare_contiguous().
>
>> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.
>
> This panic comes from memblock_alloc_base().  I guess something has
> passed in bad values.
>
> I wonder if your dtb is compatible with this platform.  What if you
> don't pass a dtb to kexec?

Yes dtb was the problem. Without dtb it works fine

root at genericarmv8:~# ./usr/local/sbin/kexec --lite -l vmlinux --command-line=
"root=/dev/nfs rw
nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
ip=:::::eth0:dhcp panic=1
console=ttyS0,115200 earlycon=uart8250,mmio32,0x1c020000"


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
Early serial console at MMIO32 0x1c020000 (options '')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
efi: UEFI not found.
cma: Reserved 16 MiB at 40ff000000
/cpus/cpu at 000: unsupported enable-method property: spin-table
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4136960
Kernel command line: root=/dev/nfs rw
nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
earlycon=uart8250,mmio32,0x1c020000
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
....
...
..
.
root at genericarmv8:~#

--Arun
