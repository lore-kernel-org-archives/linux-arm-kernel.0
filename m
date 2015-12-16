From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 16 Dec 2015 13:51:10 -0800
Subject: arm-soc boot: 320 boots: 12 failed,
 308 passed (v4.4-rc3-483-gb48b5ceb7227)
In-Reply-To: <5276296.zVv1bjCjBz@wuerfel>
References: <567128b4.46b71c0a.17f65.7531@mx.google.com>
 <1746045.ErmxH37Pke@wuerfel>
 <CANMBJr6oi5mrUnzTG8J=C69K5ra93MQDjoVP7ef+1oB1RPpGuQ@mail.gmail.com>
 <5276296.zVv1bjCjBz@wuerfel>
Message-ID: <CANMBJr4h3JDJk6eufdirvy9fVxBGZUA4zu5e5mtfGdUF13qLwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2015 at 12:16, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 December 2015 11:34:30 Tyler Baker wrote:
>> > * bcm4708-smartrg-sr400ac doesn't find its rootfs any more
>> >
>> > [   16.670994] No filesystem could mount root, tried:  ext3 ext2 ext4 squashfs vfat msdos ntfs
>> > [   16.679388] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
>> >
>> >   I merged some patches from Florian yesterday, but it could also be a problem with
>> >   the defconfig changes
>>
>> The bisection pointed to b02ec7658c98 ("ARM: multi_v7_defconfig:
>> Enable some drivers for LS1021A")
>>
>> I've rebased my tree with arm-soc for-next, and reverted the commits
>> listed above. Should know shortly if the reverts fix the boot issues.
>
> I've looked at the built-in drivers to see if they might do something
> on unrelated hardware (we've had bugs like that before), but didn't
> find anything: the watchdog and cpufreq drivers all look sane, everything
> else is a loadable module.
>
> One possible explanation would be a buggy bootloader that fails to pass
> a correct initrd and/or dtb if the kernel image gets too big.
>
> Do you know if there is an initrd that is passed on this platform?

There is, and if I disable only CONFIG_BLK_DEV_RAM the
bcm4708-smartrg-sr400ac boots again. This platform runs a CFE
bootloader, and this is these are the kernel arguments injected into
the DT - "console=ttyS0,115200 initrd=0x4000000,8M root=/dev/ram0
ip=dhcp".

I'm still investigating the rk3288 failures, and will report back when
I find something.

Cheers,

Tyler
