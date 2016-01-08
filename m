From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 8 Jan 2016 15:59:16 -0800
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
In-Reply-To: <20160108234432.GQ19062@n2100.arm.linux.org.uk>
References: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
 <20160108225032.GO19062@n2100.arm.linux.org.uk>
 <CANMBJr6DR=y2oOqnEyUAxhzhXn1twXozGacOpcVRx8NcWf-mfw@mail.gmail.com>
 <20160108234432.GQ19062@n2100.arm.linux.org.uk>
Message-ID: <CANMBJr6o=kwa_jm1wXFUrOdK+raAO5A505Z27jDqNM1bWOh0ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2016 at 15:44, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 08, 2016 at 03:17:19PM -0800, Tyler Baker wrote:
>> On 8 January 2016 at 14:50, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Jan 08, 2016 at 02:33:39PM -0800, Tyler Baker wrote:
>> >> After a bit of investigation, I determined that CONFIG_BLK_DEV_RAM was
>> >> causing the issue and disabling it fixed the boot issue. Essentially,
>> >> the kernel cannot find the initrd that has been loaded into memory by
>> >> CFE bootloader with this option enabled as I inject the following
>> >> command line into the DT before it's loaded over tftp.
>> >>
>> >> Loaded in CFE by: 'load -raw -tftp -addr=0x4000000 -max=0x900000
>> >> 192.168.2.2:tmpqC9zOv/ramdisk.cpio.gz'
>> >>
>> >> Kernel arguments injected into DT: 'console=ttyS0,115200
>> >> initrd=0x4000000,8M root=/dev/ram0 ip=dhcp'
>> >
>> > What is the problem that the kernel is reporting?
>>
>> The kernel complaining that there is no file system to mount, and
>> panics. Here is a plain text version of the issue if you want to have
>> a look[1].
>
> Thanks.
>
> The error is:
>
> [   16.557922] RAMDISK: EOF while reading compressed data
>
> which is not surprising given:
>
> initrd=0x4000000,8M
>
> is given on the kernel command line, but:
>
> Loader:raw Filesys:tftp Dev:eth0 File:192.168.2.2:tmpd9L7xr/ramdisk.cpio.gz Options:(null)
> ... 8450989 bytes read
>
> the actual ramdisk is larger than 8M.  8M would've been 8388608 bytes,
> but you're about 64k over that.

Right, this was my initial reaction when I saw this issue. I've
attempted increase initrd limit passed to the kernel, the load size in
the bootloader (10MB+) and still the same issue occurs when I do this.
I am suspicious that the CFE bootloader may have some limitation on
initrd size it will load, even though it does not complain when I
increase the size. I was hoping Hauke or Rafal might be able help us
understand a bit more here, as they are maintainers of this platform.

Cheers,

Tyler
