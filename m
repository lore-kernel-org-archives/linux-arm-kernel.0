From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 23 Jan 2015 10:07:39 +0100
Subject: [RFC] using dt overlays: how to? today?
In-Reply-To: <2F10D177-6F27-4019-8D2D-8F77361BB310@konsulko.com>
References: <20150122150219.GB26928@odux.rfo.atmel.com>
 <2F10D177-6F27-4019-8D2D-8F77361BB310@konsulko.com>
Message-ID: <20150123090739.GD26928@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pantelis,

On Thu, Jan 22, 2015 at 10:54:42PM +0200, Pantelis Antoniou wrote:
> Hi Ludovic,
> 
> > On Jan 22, 2015, at 17:02 , Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> > 
> > Hi,
> > 
> > I have assisted to Pantelis' talk about device tree and overlays at ELCE
> > 2014. Since the patch 'Introduce DT overlay support' is now part of the
> > mainline, I wanted to have a look about it and to use it for our boards.
> > 
> 
> Excellent.
> 
> > Firstly, this is what I want to achieve by using this feature:
> > - manage several revisions of our boards
> > - manage modules we can plug on the board, mainly display modules
> >  (resistive or capacitive one)
> > - manage cpu modules plug on the motherboard
> > - I would like to have all this stuff in the kernel. I don't want a
> >  dependency on the bootloader or the user space.
> > 
> 
> That?s awesome; that?s exactly what I want to use it for. Maybe this thing
> can be used by others as well ;)
> 

It seems quite close from what you want to achieve with cape manager.

> > At the moment, we have many dts files to manage these cases (not all are
> > in mainline). It is becoming a pain.
> > 
> 
> Tell me about it.

You can have a look here:
https://github.com/linux4sam/linux-at91/tree/master/arch/arm/boot/dts

For example, we have up to 6 dts files for a single device:
sama5d36ek.dts, sama5d36ek_hdmi.dts, sama5d36ek_pda4.dts,
sama5d36ek_pda7.dts, sama5d36ek_revc.dts, sama5d36ek_revc_pda4.dts,
sama5d36ek_revc_pda7.dts

Our goal is that customers don't have to care about all this stuff. They
load a single dtb file which can manage all these cases.
The change between revison c and revison d is the i2c device to which
the audio codec is connected. Difference between pda4 and pda7 (which
are display modules with a capacitive touchscreen) can be the irq used
the touch keyboard or the touchscreen.

Information we need are stored in an EEPROM which is accessible through
a one wire bus. As I said, we would like that the customers have no
dependency on other components if possible: bootloader, userspace,
firmware.

> 
> > I wanted to see if we can use device tree fragments as it seems to be
> > closed to be achieved when I had assisted to the talk. I have found a
> > thread about 'DT-Overlay configfs interface'
> > (http://thread.gmane.org/gmane.linux.drivers.devicetree/101871), there
> > are still discussions about security concerns, so it may not be included
> > quickly. I have also found an interesting thread about cape manager for
> > Beaglebone (http://thread.gmane.org/gmane.linux.documentation/8279) but
> > there is no more activity on it, is it canceled or is there a new topic
> > I have missed?
> > 
> > Here are my questions:
> > - Is it acceptable to manage device tree fragments with a driver such as
> >  the cape manager? Or at an other place in the kernel such as
> > arch/arm/mach-at91/board-dt-sama5.c for example?
> > - Is it possible to get access to eeprom from the kernel? Pantelis did
> >  an interface to access it through i2c but it seems it was not
> > accepted. In my case, it will be through the one wire interface.
> > 
> > Thanks for sharing your opinion about this or redirecting me to a
> > similar thread.
> > 
> 
> I?m waiting for 3.19 to go out and I?ll address everything you described
> above.

Do you think it's too early to use it? We are currently trying to
release a new kernel (based on 3.18) with some patches which have not been
sent or accepted yet. Since I could merge easily your patches from Grant
branch, I thought we could try to use it but spending time on a oneshoot
solution is useless. That's why I would like to know what is the status
since it seems only the sysfs part is still in development.

> 
> Feel free to post specific requirement about your use cases, and I?ll try
> to address them.

Thanks so what is the next step? Posting a new patch series or the cape
manager? I mean if you plan to do it, I could have a look on how to
access the EEPROM through one wire.


Regards

Ludovic
