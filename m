From: slash.tmp@free.fr (Mason)
Date: Wed, 25 Nov 2015 23:41:49 +0100
Subject: Building an uImage with appended DTB
In-Reply-To: <20151125184556.GP8644@n2100.arm.linux.org.uk>
References: <5655DED0.5000601@free.fr>
 <CACxGe6t0RD-z=duiP+=sbWm_JY7_OjjTmBL7jLZRRuLBSMan6g@mail.gmail.com>
 <20151125184556.GP8644@n2100.arm.linux.org.uk>
Message-ID: <5656392D.8030904@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/2015 19:45, Russell King - ARM Linux wrote:
> On Wed, Nov 25, 2015 at 04:38:35PM +0000, Grant Likely wrote:
>> On Wed, Nov 25, 2015 at 4:16 PM, Mason wrote:
>>> Hello,
>>>
>>> Per Russell's advice (IIRC) I have a script to generate a uImage
>>> of a kernel with an appended DTB:
>>>
>>> export LOADADDR=0x80008000
>>> MAKE="make -j2 ARCH=arm"
>>> $MAKE dtbs zImage && \
>>> cat arch/arm/boot/zImage arch/arm/boot/dts/tango4-vantage-1172.dtb >zImage.tmp && \
>>> mv zImage.tmp arch/arm/boot/zImage && \
>>> $MAKE uImage
>>>
>>> Russell's version uses an explicit mkimage instead of "MAKE uImage"
>>> perhaps in part to get around the following limitation:
>>>
>>> if there is nothing to be done, cat+mv will update arch/arm/boot/zImage
>>> thus the uImage will be rebuilt even when it's not necessary.
>>>
>>> Doesn't the top-level Makefile support a target to build a uImage
>>> with appended DTB?
>>>
>>> (I suppose someone has submitted a patch for that. Was it perhaps
>>> never merged? Or did I just miss the feature?)
>>
>> I don't remember what happened there. That was a long time ago. I
>> think it got nacked, but cannot remember the reason.
> 
> It got nacked because we don't want these special boot loader specific
> formats in the kernel, and it's getting beyond a joke.  It was a mistake
> to merge the uImage target in the first place IMHO.
> 
> Previous to uboot, boot loaders were perfectly happy with zImage.  Today,
> all boot loaders are perfectly happy with a zImage - it's only the old
> legacy uboot versions that insist on uImage now.  There's now even less
> of a reason to think about merging some uImage based DT munging than there
> was several years ago.

Actually, I'm using a fairly recent version of U-Boot (2014.04)
IIUC, bootz should do the trick... But I'm not finding much doc
about it... <confused>

If I pass U-Boot a zImage, where should I load it, and how does
U-Boot know where to relocate it? (LOADADDR?)
And why is LOADADDR 0x80008000 and not 0x80000000 (the start
of the RAM)?

Misc links for my own reference:
https://patchwork.ozlabs.org/patch/146848/
https://stackoverflow.com/questions/22322304/image-vs-zimage-vs-uimage
https://unix.stackexchange.com/questions/122526/how-to-convert-a-zimage-into-uimage-for-booting-with-u-boot
http://lists.denx.de/pipermail/u-boot/2015-March/208551.html
http://www.denx.de/wiki/DULG/Manual

> Just do it in an external script, like I do here for platforms where it's
> necessary.  Absolutely no need to hack around in the kernel with special
> crap, like passing environment variables to make (which, you need a script
> for anyway, because its laborious to have to keep on typing them.)

How do you prevent your script from rebuilding the uImage every
time it is invoked?

> If you're writing a build script so you don't have to remember lots of
> environment variables for the kernel, you might as well write the build
> script to do the mkimage step for you.
> 
> So having it in the kernel is totally pointless and insane.

I understand.

Regards.
