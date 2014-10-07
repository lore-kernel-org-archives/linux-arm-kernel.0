From: geoff@infradead.org (Geoff Levand)
Date: Tue, 07 Oct 2014 13:07:42 -0700
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20141007180954.GH27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141007180954.GH27464@redhat.com>
Message-ID: <1412712462.32313.127.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Tue, 2014-10-07 at 14:09 -0400, Vivek Goyal wrote:
> I tried and I get following.
> 
> [root at apm-mustang-ev3-06 sbin]# ./kexec -l /root/git/sa2/vmlinux
> --initrd=/boot/initramfs-3.17.0-rc7+.img
> --append="BOOT_IMAGE=/vmlinuz-3.17.0-rc5+
> root=/dev/mapper/fedora_dhcp--17--165-root ro
> rd.lvm.lv=fedora_dhcp-17-165/root rd.lvm.lv=fedora_dhcp-17-165/swap
> vconsole.font=latarcyrheb-sun16 console=tty0 console=ttyS0,115200
> LANG=en_US.UTF-8 crashkernel=160M earlyprintk=ttyS0,115200"
> kexec version: 14.10.02.15.58-g706fbeb
> Modified cmdline: root=/dev/mapper/rhsfadp_apm--mustang--ev3--06-root 
> Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from
> purgatory is diabled
> get_memory_ranges_dt:756: Invalid /proc/device-tree.
> kexec: kexec/arch/arm64/kexec-arm64.c:625: virt_to_phys: Assertion
> `arm64_mem.memstart' failed.
> Aborted

I added a kexec-tools fix for this failed assertion.  Could you pull
my latest and send me the output with the kexec --debug option added?

I guess you are trying to boot the kernel as a UEFI application,
which I have not yet done, so not supported.  You need to use a
UEFI kernel loader.

> What's "Modified cmdline" ? That seems to have truncated everything I 
> passed in.

The kexec-tools fs2dt code prints out the Modified cmdline when a node
is added to the DT.  In this case it is OK, since the arm64 code first
adds other nodes.  Your new cmdline is added later, but you did not
get there do to the failed assertion.

-Geoff
