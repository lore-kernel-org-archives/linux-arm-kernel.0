From: rbernd@gmail.com (Bernd)
Date: Tue, 11 Dec 2012 22:15:06 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <20121211161557.6819daa9@skate>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net> <50C681B0.4030801@gmail.com>
 <20121211161557.6819daa9@skate>
Message-ID: <50C7A25A.2090602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thanks, that did the trick! Now the kernel boots OK until it can't find
the root filesystem (I know the reason for that).

It appears that there is a bug in

$ make ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- uImage

The command it uses to create the uImage is (got it from
arch/arm/boot/.uImage.cmd):

/bin/sh /home/bernd/mirabox-dev/marvell-boards/scripts/mkuboot.sh -A arm
-O linux -C none  -T kernel -a  -e  -n 'Linux-3.7.0-rc7-00250-g0c0029c'
-d arch/arm/boot/zImage arch/arm/boot/uImage

So no value given for parameters -a and -e.

Best regards,

Bernd


On 2012-12-11 16:15, Thomas Petazzoni wrote:
> Dear Bernd,
> 
> On Tue, 11 Dec 2012 01:43:28 +0100, Bernd wrote:
> 
>> Data Size:    1885555 Bytes = 1841.36 kB = 1.80 MB
>> Load Address: fffffff2
>> Entry Point:  fffffff2
> 
> Those Load address and Entry Point are incorrect.
> 
> I think this is due to the fact that mach-mvebu is now part of the
> ARCH_MULTIPLATFORM thing and therefore no longer defines its own
> zreladdr-y, but I'm not sure. In any case, what I'm doing here is:
> 
> ./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x00008000 -e
> 0x00008000 -n 'Linux-marvell' -d myzImage-with-dtb-appended myuImage.
> 
> Best regards,
> 
> Thomas
> 
