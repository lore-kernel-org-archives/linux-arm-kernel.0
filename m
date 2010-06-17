From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jun 2010 20:33:24 +0100
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <20100611063733.GB10894@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<AANLkTiltifSEFdpXB0avw4ZyDzP_IrDpipafBAJbN17U@mail.gmail.com>
	<20100611063733.GB10894@pengutronix.de>
Message-ID: <20100617193324.GA8805@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 08:37:33AM +0200, Uwe Kleine-K?nig wrote:
> Hello Linus,
> 
> On Fri, Jun 11, 2010 at 12:17:44AM +0200, Linus Walleij wrote:
> > I assume it should be submitted simultaneously with a patch nuking off
> > all Makefile.boot files and that infrastructure then?
> Only when bootp is deleted or fixed not to use these variables.

You can't really "fix" it not to use these variables.  The placement
of things like the ramdisk image is something that can only be
specified with a certain amount of information, such as where the
kernel will be located, how large the decompressed kernel will be,
where the RAM is located, whether there's any platform specific
restrictions on what RAM can be used.

ARM is its own enemy here - not having started out with the memory
architected to be in a certain location like it is on x86 makes all
this very much more complicated, and I doubt that any wrapper around
the kernel which performs in a way like the bootp wrapper could be
made to work reliably without being told explicitly where to place
stuff.

And I'm not in favour of it being deleted; there are boot loaders
out there which can only fetch and boot one image.  Such boot loaders
make it difficult to wrap a ramdisk image with the kernel.  The bootp
wrapper solves that.  It's also not something you want to use ZBOOT=y
with.
