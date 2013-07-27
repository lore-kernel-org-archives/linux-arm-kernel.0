From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Jul 2013 12:09:20 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <51F3A238.3020505@broadcom.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <CAOesGMhEr3DiFm5uSgoHPFUMY4jWu4HkeTU2UmOGj=dS75Vk+g@mail.gmail.com>
 <20130727050406.GB4221@netboy> <2007664.vYsECFSKrV@flatron>
 <51F39FD8.6080808@broadcom.com> <51F3A238.3020505@broadcom.com>
Message-ID: <20130727110920.GE24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 12:34:32PM +0200, Arend van Spriel wrote:
> Oh, and the reason for my tinkering on dts is here:
>
> http://mid.gmane.org/51E7AA24.6080600 at broadcom.com
>
> Happily using Pandaboard for my driver testing and than *kaboom*.  
> board-omap4panda.c is gone although the device tree does not provide the  
> same functionality. Of course, this is not about DT bindings.

Similar happened to the 4430SDP board - and I took it out of the build
system for over a month because of that.  I knew it would be _painful_
to get DT and running on the board, and I was right, not only because of
the different build process, but also trying to find which kernel config
options need to be added to a previously working configuration for what
is essentially a black box board.

The MMC device for the rootfs magically changed too - which meant finding
out how to tell the kernel which device to use as the rootfs without
giving it an explicit device.  (Using UUIDs, which aren't real UUIDs and
aren't related to the filesystem UUID either - I've still no idea where
this magic number comes from or how to identify it from a running system.)

It's also made a total mess of the boot log.  I've no idea if all the
devices were successfully probed because there's now soo much noise from
the deferred probing that it's like trying to work out if there's any
serious warnings in a kernel build where every file spits out a warning.
It's almost a pen and paper job to work it out.  There's just too much
noise in the kernel boot now that I'm just not going to bother reading
the boot log anymore unless there's something which has noticably failed.

On the plus side, the DT description for the SDP board _may_ have helped
to solve a problem I've had for over two years: that is why the LCDs don't
seem to work on the board.  It seems I need the TWL PWM driver.  I don't
yet know if this has solved the problem or not, because I've not seen the
board boot with that driver in it.  However, it's not clear to me from the
DT description whether that covers both of the LCDs or just one though.
