From: rbernd@gmail.com (Bernd)
Date: Wed, 12 Dec 2012 21:01:45 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <20121212093103.2f29494d@skate>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net> <50C681B0.4030801@gmail.com>
 <20121211161557.6819daa9@skate> <50C7A25A.2090602@gmail.com>
 <20121212093103.2f29494d@skate>
Message-ID: <50C8E2A9.7020802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thomas,

Having to create the uImage manually is not so bad, IMO. The address
(0x00008000) seems to be a 'magic number', though, so I think the
process of creating a uImage for a particular box should be documented.

Meanwhile, I am struggling with the next issue which is getting the
kernel to recognize and mount any root filesystem on the mirabox.
Preferably I would like to use an SD card in the internal card reader
for it. The factory kernel accesses the card reader via USB, so I assume
I need to get USB working for that in mainline, too. Alternatively, I
would use the built-in flash memory which the factory kernel accesses
via MTD. So far I am out of luck ("Kernel panic - not syncing: VFS:
Unable to mount root fs...") as I don't know whether drivers for any of
the devices are available in mainline already and, if yes, which ones I
need to enable in config for that.

Is this information available somewhere?

Cheers,

Bernd

On 2012-12-12 09:31, Thomas Petazzoni wrote:
> Dear Bernd,
> 
> On Tue, 11 Dec 2012 22:15:06 +0100, Bernd wrote:
> 
>> Thanks, that did the trick! Now the kernel boots OK until it can't find
>> the root filesystem (I know the reason for that).
>>
>> It appears that there is a bug in
>>
>> $ make ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- uImage
>>
>> The command it uses to create the uImage is (got it from
>> arch/arm/boot/.uImage.cmd):
>>
>> /bin/sh /home/bernd/mirabox-dev/marvell-boards/scripts/mkuboot.sh -A arm
>> -O linux -C none  -T kernel -a  -e  -n 'Linux-3.7.0-rc7-00250-g0c0029c'
>> -d arch/arm/boot/zImage arch/arm/boot/uImage
>>
>> So no value given for parameters -a and -e.
> 
> Indeed "make uImage" is broken for any multiplatform capable platform,
> because zreladdr is not defined (in order to be multiplatform, the
> multiplatform kernel use AUTO_ZRELADDR, so there is no fixed zreladdr).
> Since you're building a multiplatform kernel, there is no "one" entry
> point address and load address: it depends on which platform you are
> going to boot the kernel into.
> 
> I am not sure what is the plan forward. Maybe boot zImages directly
> from U-Boot? Let people build their uImage manually?
> 
> Best regards,
> 
> Thomas
