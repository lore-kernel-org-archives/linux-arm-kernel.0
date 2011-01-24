From: kevin.pouget@gmail.com (Kevin Pouget)
Date: Mon, 24 Jan 2011 09:34:06 +0100
Subject: Linux ARM SMP kernel for qemu -- jiffies not updated
Message-ID: <AANLkTi=DER1tomNE3bqKco2iWB0HEkf9gHFa6vHQqQNh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks for your answers,

[it seems that] the problem was actually related to the version of
Qemu, v0.12.5 never triggered the jiffies update, as described below
for the record, whereas v0.13 is okay !

thanks,

Kevin

--

> Program received signal SIGINT, Interrupt.
> calibrate_delay () at /home/kevin/travail/srcs/linux-2.6.38-rc2/init/calibrate.c:149
> 149				while (ticks == jiffies)
> 150					/* nothing */;

jiffies are not updated, and the kernel never goes any further ...
(the second CPU is waiting for an interrup --WFI-- before starting)


On Sun, Jan 23, 2011 at 6:44 AM, Rabin Vincent <rabin@rab.in> wrote:
> On Fri, Jan 21, 2011 at 20:47, Kevin Pouget <kevin.pouget@gmail.com> wrote:
>> do you know if it's feasible to compile a Linux kernel to be run by a
>> Qemu SMP ARM machine? after so many hours of tries, I can say that any
>> version of the kernel, any Qemu machine would be okay, provided that
>> the SMP capability is set, and the kernel boots !
>
> Try the kernel from latest git, QEMU from latest git, and the attached
> .config.
>
> The .config is just realview_smp-defconfig with:
> ?- PB11 and ARMv6 disabled
> ?- PBX A9 and ARMv7 enabled
> ?- CONFIG_REALVIEW_HIGH_PHYS_OFFSET disabled
>
> Initramfs support is also enabled. ?You can boot it with this line (you'll
> need an initramfs or initrd to get to userspace):
>
> qemu-system-arm -kernel arch/arm/boot/uImage -nographic \
> ? ? ? ? ? ? ? ?-append "earlyprintk console=ttyAMA0 mem=128M debug" \
> ? ? ? ? ? ? ? ?-M realview-pbx-a9 -m 128M -initrd ~/kernel/root -smp 2
>
