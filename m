From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 10:32:28 +0000
Subject: Booting Integrator/AP with ARM920T
In-Reply-To: <AANLkTi=ko-8B=C32e42HsL7vOZa63t_JtmfGKqYht99P@mail.gmail.com>
References: <AANLkTi=ko-8B=C32e42HsL7vOZa63t_JtmfGKqYht99P@mail.gmail.com>
Message-ID: <20110321103228.GA22222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 11:17:19AM +0100, Linus Walleij wrote:
> Does anyone beside me *ever* try to actually boot a recent kernel
> on this thing?
> 
> How do you do it? Do I need patched U-boots etc, or can I just load
> a Z-record image of vmlinux into RAM over the serial console?
> 
> Needless to say, ARM Ltd. has deleted the web pages for official
> support of this thing as far as I can see. I was going to try out a
> few patches affecting mach-integrator...

That's going back quite a few years... and yes, it wasn't trivial.  How
it used to be done was with a boot loader called 'milo' which read the
kernel out of flash - you had to program it and the kernel using 'afu'
via the debugger.

Looking at the various scripts I have around, the other way I did it was
using Angel (and presumably armsd).  I have this .angelrc file:

device /dev/ttyS3
options "9600 8N1"
baud 115200
base 0x00008000
entry 0x00008000
#otherfile ramdisk_img.gz
#otherbase 0xc0800000
r0 0x00
r1 21
exec .start-minicom

and .start-minicom is:
#!/bin/sh
exec ~/bin/start-minicom int

Not sure if any of this helps, but might provide some hints.
