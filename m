From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 8 Jan 2016 16:21:11 -0800
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
In-Reply-To: <20160109000709.GR19062@n2100.arm.linux.org.uk>
References: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
 <20160108225032.GO19062@n2100.arm.linux.org.uk>
 <CANMBJr6DR=y2oOqnEyUAxhzhXn1twXozGacOpcVRx8NcWf-mfw@mail.gmail.com>
 <20160108234432.GQ19062@n2100.arm.linux.org.uk>
 <CANMBJr6o=kwa_jm1wXFUrOdK+raAO5A505Z27jDqNM1bWOh0ag@mail.gmail.com>
 <20160109000709.GR19062@n2100.arm.linux.org.uk>
Message-ID: <CANMBJr4yijtDy1H24ofhHTt1pKacRRk+hx88-z8i=H+Me3Yx7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2016 at 16:07, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 08, 2016 at 03:59:16PM -0800, Tyler Baker wrote:
>> On 8 January 2016 at 15:44, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Jan 08, 2016 at 03:17:19PM -0800, Tyler Baker wrote:
>> >> On 8 January 2016 at 14:50, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Fri, Jan 08, 2016 at 02:33:39PM -0800, Tyler Baker wrote:
>> >> >> After a bit of investigation, I determined that CONFIG_BLK_DEV_RAM was
>> >> >> causing the issue and disabling it fixed the boot issue. Essentially,
>> >> >> the kernel cannot find the initrd that has been loaded into memory by
>> >> >> CFE bootloader with this option enabled as I inject the following
>> >> >> command line into the DT before it's loaded over tftp.
>> >> >>
>> >> >> Loaded in CFE by: 'load -raw -tftp -addr=0x4000000 -max=0x900000
>> >> >> 192.168.2.2:tmpqC9zOv/ramdisk.cpio.gz'
>> >> >>
>> >> >> Kernel arguments injected into DT: 'console=ttyS0,115200
>> >> >> initrd=0x4000000,8M root=/dev/ram0 ip=dhcp'
>> >> >
>> >> > What is the problem that the kernel is reporting?
>> >>
>> >> The kernel complaining that there is no file system to mount, and
>> >> panics. Here is a plain text version of the issue if you want to have
>> >> a look[1].
>> >
>> > Thanks.
>> >
>> > The error is:
>> >
>> > [   16.557922] RAMDISK: EOF while reading compressed data
>> >
>> > which is not surprising given:
>> >
>> > initrd=0x4000000,8M
>> >
>> > is given on the kernel command line, but:
>> >
>> > Loader:raw Filesys:tftp Dev:eth0 File:192.168.2.2:tmpd9L7xr/ramdisk.cpio.gz Options:(null)
>> > ... 8450989 bytes read
>> >
>> > the actual ramdisk is larger than 8M.  8M would've been 8388608 bytes,
>> > but you're about 64k over that.
>>
>> Right, this was my initial reaction when I saw this issue. I've
>> attempted increase initrd limit passed to the kernel, the load size in
>> the bootloader (10MB+) and still the same issue occurs when I do this.
>
> Your ramdisk is 8450989 bytes.  You're telling _the kernel_ that it is
> only 8388608 bytes.  The kernel is reporting that it reached the last
> byte of the 8388608 and the decompression was not complete.
>
> You need to tell the kernel that the ramdisk is bigger.  It's not the
> bootloader, it's your "initrd=0x4000000,8M" argument to the kernel that's
> causing the problem.
>
> Increase that ",8M" to the kernel.

I agree, and in my last reply I stated I did this. To be very
specific, I used "initrd=0x4000000,10M" which still did not work. Give
me a moment to reconfigure the scripts and I'll post and updated boot
log.

Cheers,

Tyler
