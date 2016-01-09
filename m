From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 8 Jan 2016 17:50:02 -0800
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
In-Reply-To: <20160109012912.GS19062@n2100.arm.linux.org.uk>
References: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
 <20160108225032.GO19062@n2100.arm.linux.org.uk>
 <CANMBJr6DR=y2oOqnEyUAxhzhXn1twXozGacOpcVRx8NcWf-mfw@mail.gmail.com>
 <20160108234432.GQ19062@n2100.arm.linux.org.uk>
 <CANMBJr6o=kwa_jm1wXFUrOdK+raAO5A505Z27jDqNM1bWOh0ag@mail.gmail.com>
 <20160109000709.GR19062@n2100.arm.linux.org.uk>
 <CANMBJr4yijtDy1H24ofhHTt1pKacRRk+hx88-z8i=H+Me3Yx7Q@mail.gmail.com>
 <CANMBJr7+X0nj8-DLQ7vLLEowj1SbZxqqikHDBUP-GawZAG0a6w@mail.gmail.com>
 <20160109012912.GS19062@n2100.arm.linux.org.uk>
Message-ID: <CANMBJr7t00a1k1wyG4iL7eS4GBQbpxzZyziCKCexk1O1naEXfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2016 at 17:29, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 08, 2016 at 04:58:05PM -0800, Tyler Baker wrote:
>> On 8 January 2016 at 16:21, Tyler Baker <tyler.baker@linaro.org> wrote:
>> > I agree, and in my last reply I stated I did this. To be very
>> > specific, I used "initrd=0x4000000,10M" which still did not work. Give
>> > me a moment to reconfigure the scripts and I'll post and updated boot
>> > log.
>>
>> Here is the boot log when using "initrd=0x4000000,10M" [1]. Obviously,
>> it does resolve the 'RAMDISK: EOF while reading compressed data'
>> error, but still fails to mount.
>
> Okay, thanks.  Things are better - there's another change in there.
> We've gone from:
>
> [    0.156295] Trying to unpack rootfs image as initramfs...
> [    0.990981] rootfs image is not initramfs (read error); looks like an initrd
>
> note the "read error" because we hit EOF while trying to read the
> initramfs, which now has become:
>
> [    0.156226] Trying to unpack rootfs image as initramfs...
> [    0.993838] rootfs image is not initramfs (junk in compressed archive); looks like an initrd
>
> I suspect the kernel has always complained about this, the difference
> is that with BLK_DEV_RAM enabled, we will clean the initial rootfs,
> which will return it to a pristine state after failed initramfs unpack.

I took a look at the boot logs from mainline and your suspicion is
correct, it does complain about the 'junk in compressed' archive. As
far back as I have logs, this appears to be the case.

> Either way, turning off BLK_DEV_RAM doesn't _actually_ fix the problem -
> it merely masks that the initramfs failed to properly unpack.
>
> This is because unpack_to_rootfs() wants to consume all the data in the
> passed image, so if you say it's 10MB in size, it will want 10MB of data.

I did not realize this, but it seems like very rational behavior.

> So, I think the only proper solution is to set
> "initrd=0x4000000,<actual-size>" and not "something that's larger"
> which will prevent unpack_to_rootfs() reporting an error.

Good suggestion, tomorrow I'll update my scripts to pass the actual
file size and report back.

> To prove this, if you look at a successful boot log from a kernel without
> BLK_DEV_RAM enabled, I suspect you'll see:
>
> Unpacking initramfs...
> Initramfs unpacking failed: junk in compressed archive
>
> in your log, which is just another symptom of the incorrect size being
> passed.

Thanks for the help debugging this, I appreciate it.
