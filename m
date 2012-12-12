From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Dec 2012 09:31:03 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <50C7A25A.2090602@gmail.com>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net>
 <50C681B0.4030801@gmail.com> <20121211161557.6819daa9@skate>
 <50C7A25A.2090602@gmail.com>
Message-ID: <20121212093103.2f29494d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bernd,

On Tue, 11 Dec 2012 22:15:06 +0100, Bernd wrote:

> Thanks, that did the trick! Now the kernel boots OK until it can't find
> the root filesystem (I know the reason for that).
> 
> It appears that there is a bug in
> 
> $ make ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- uImage
> 
> The command it uses to create the uImage is (got it from
> arch/arm/boot/.uImage.cmd):
> 
> /bin/sh /home/bernd/mirabox-dev/marvell-boards/scripts/mkuboot.sh -A arm
> -O linux -C none  -T kernel -a  -e  -n 'Linux-3.7.0-rc7-00250-g0c0029c'
> -d arch/arm/boot/zImage arch/arm/boot/uImage
> 
> So no value given for parameters -a and -e.

Indeed "make uImage" is broken for any multiplatform capable platform,
because zreladdr is not defined (in order to be multiplatform, the
multiplatform kernel use AUTO_ZRELADDR, so there is no fixed zreladdr).
Since you're building a multiplatform kernel, there is no "one" entry
point address and load address: it depends on which platform you are
going to boot the kernel into.

I am not sure what is the plan forward. Maybe boot zImages directly
from U-Boot? Let people build their uImage manually?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
