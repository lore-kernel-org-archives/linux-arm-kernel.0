From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 7 Oct 2014 14:09:54 -0400
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <cover.1411604443.git.geoff@infradead.org>
References: <cover.1411604443.git.geoff@infradead.org>
Message-ID: <20141007180954.GH27464@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> Hi All,
> 
> This series adds the core support for kexec re-boots on arm64.  I have tested
> with the ARM VE fast model using various kernel config options for both the
> first and second stage kernels.
> 
> To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
> 
> This series does not include some re-work of the spin-table CPU enable method
> that is needed to support it, nor does it include some re-work of KVM to support
> CPU soft reset.  A kernel built with these patches will boot and run correctly,
> but will fail to load a kexec kernel if running on a machine with any spin-table
> enabled CPUs and will fail the kexec re-boot if the first stage kernel was built
> with CONFIG_KVM=y.  Work-in-progress patches to support these are in the master
> branch of my linux-kexec repository [1].
> 
> Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
> routine the ability to switch exception levels from EL1 to EL2 for kernels that
> were entered in EL2.
> 
> Patch 5 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
> dcache_line_size macro it defines can be uesd by kexec's relocate kernel
> routine.
> 
> Patches 11 and 12 add the actual kexec support.
> 
> Please consider all patches for inclusion.  Any comments or suggestions on how 
> to improve are welcome.
> 
> [1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
> [2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git
> 

Hi Geoff,

I tried and I get following.

[root at apm-mustang-ev3-06 sbin]# ./kexec -l /root/git/sa2/vmlinux
--initrd=/boot/initramfs-3.17.0-rc7+.img
--append="BOOT_IMAGE=/vmlinuz-3.17.0-rc5+
root=/dev/mapper/fedora_dhcp--17--165-root ro
rd.lvm.lv=fedora_dhcp-17-165/root rd.lvm.lv=fedora_dhcp-17-165/swap
vconsole.font=latarcyrheb-sun16 console=tty0 console=ttyS0,115200
LANG=en_US.UTF-8 crashkernel=160M earlyprintk=ttyS0,115200"
kexec version: 14.10.02.15.58-g706fbeb
Modified cmdline: root=/dev/mapper/rhsfadp_apm--mustang--ev3--06-root 
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from
purgatory is diabled
get_memory_ranges_dt:756: Invalid /proc/device-tree.
kexec: kexec/arch/arm64/kexec-arm64.c:625: virt_to_phys: Assertion
`arm64_mem.memstart' failed.
Aborted


What's "Modified cmdline" ? That seems to have truncated everything I 
passed in.

Thanks
Vivek
