From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Aug 2012 20:08:56 +0100
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
Message-ID: <20120806190856.GA1120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 01:40:26PM -0500, Matt Sealey wrote:
> Maybe we could implement a shiny new zImage magic value, I'm not sure
> if 0x016f2818 might have some sentimental value, but there's nothing
> to say that 0x016f2819 wouldn't also be valid and indicate that it's
> an ARM zImage with a Thumb2 entrypoint?

No.  That magic value is a bloody pain in the backside from my point
of view.  I've had soo many problems with it with boot loaders its
untrue.

For example, the Skiff (SA110 platform produced by Compaq) using
bootldr.  It detects the value in the kernel image after loading
the kernel at 0x8000 into RAM, and then proceeds to move the entire
kernel image to RAM location 0, and then calls it at 0x8000 !

Naturally, that action corrupts the ATAG list etc.

To work around that, I've ended up doing some weird and wonderful
tricks like pre-pending 32K of zeros, and copying the first 128
bytes of the kernel image to the start of the image file to fool
the boot loader.  Still results in a corrupted ATAG list but it is
bootable.

There's other boot loaders around too which change their behaviour
in weird and wonderful ways depending on magic values in the loaded
image file.

What this all means is that stuff like this is at the mercy of the
boot loader folk, and when problems happen, it's hard to work around
them, because you have no way to tell the boot loader to do something
different.

Instead, lets not continue this broken idea.  Instead, let's be able
to _tell_ the boot loader what we want it to do, rather than have it
magically decipher what _it_ thinks might be a good idea to do.
