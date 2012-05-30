From: takuo.koguchi.sw@hitachi.com (takuo.koguchi.sw at hitachi.com)
Date: Thu, 31 May 2012 00:37:00 +0900
Subject: =?ISO-8859-1?B?UmVbM106IHYzLjQgYm9vdCBmYWlsdXJlIG9uIHFlbXUtc3k=?=
 =?ISO-8859-1?B?c3RlbS1hcm0gLU0gdmVyc2F0aWxlcGI=?=
References: <XNM1$5$0$1$$3$9$0$A$8005401U4fc38a01@hitachi.com>
 <4FC52B61.2000604@gmail.com>
 <XNM1$5$0$1$$3$9$0$A$8005413U4fc5e967@hitachi.com>
Message-ID: <XNM1$5$0$1$$3$9$0$A$8005415U4fc63e90@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

I am sorry that it seems I gave you wrong information.

It turned out that the config I used was not versatile_defconfig.
I have tried to reproduce with versatile_defconfig and found that IO_SPACE_LIMIT modification has no effect, ie. it cannot mount root=/dev/sdb even if IO_SPACE_LIMIT is 0xffffffff. I suppose it misses the driver to read /dev/sdb.

Actual config I used derived from buildroot tool's board/qemu/arm-versatile/linux-3.3.config. ( It works fine for linux-3.3 )
I attached my .config.
As for this config, #define IO_SPACE_LIMIT ((resource_size_t)0xffffffff) works for linux-3.4 to mount /dev/sdb as rootfs.

The command line I used was as follows,  
$ sudo qemu-system-arm -M versatilepb -kernel ~/linux/arch/arm/boot/zImage -net nic,vlan=0 -net tap,vlan=0,ifname=tap0,script=no,downscript=no -hda output/images/rootfs.ext2 -append "console=ttyAMA0 root=/dev/sda ip=192.168.7.3::192.168.7.1:255.255.255.0"

Best Regards,

Takuo Koguchi

----
>Hi Rob,
>
>Thank you for your attention.
>
>>What config are you using, and what is your kernel command line?
>
>I used versatile_defconfig.
>And I invoked qemu as follows,
>$ sudo qemu-system-arm -machine versatilepb -kernel ~/linux/arch/arm/boot/zImage -net nic,vlan=0 -net tap,vlan=0,ifname=tap0,script=no,downscript=no -hda output/images/rootfs.ext2 -append "console=ttyAMA0 root=0x0800 ip=192.168.7.3::192.168.7.1:255.255.255.0 raid=noautodetect"
>
>The result is the same even if root=/dev/sda.
>
>currently __io(a) is defined in arch/arm/include/asm/io.h
>#define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
>...
>
>As CONFIG_PCI is defined in the config, IO_SPACE_LIMIT is defined as 0xffff and failed to boot.
>The kernel can mount rootfs when I defined IO_SPACE_LIMIT as follows,
>#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
>
>It may be related only to qemu and not to real versatile board.
>
>Takuo Koguchi
>
>
>
>
>
>>Adding linux-arm-kernel...
>>
>>On 05/28/2012 09:22 AM, takuo.koguchi.sw at hitachi.com wrote:
>>> Hi,
>>> 
>>> I found linux-3.4 kernel fails to mount the rootfs on
>>> "qemu-system-arm -M versatile."
>>> 
>>> Git bisect shows commit c334bc1 cause this first.
>>> 
>>> So I tried to revert it by putting
>>> arch/arm/mach-versatile/include/mach/io.h and adding select
>>> NEED_MACH_IO_H in the section of ARCH_VERSATILE in arch/arm/Kconfig,
>>> then the kernel can mount the rootfs.
>>> 
>>> Can someone confirm and fix this?
>>> 
>>
>>What config are you using, and what is your kernel command line?
>>
>>Rob
>>
>>> Takuo Koguchi
>>> 
>>> 
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: qemu-arm_versatile_config
Type: application/octet-stream
Size: 46667 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/3ee9c625/attachment-0001.obj>
