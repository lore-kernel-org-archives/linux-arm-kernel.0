From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 22:04:22 +0200
Subject: [PATCH 3/3] ARM: integrator: pciv3: do not remap IO so early
In-Reply-To: <CACRpkdaSwgPws=G+PcmT6DsQqD-EAQkvKO1PMEVOs9KniJ6xrA@mail.gmail.com>
References: <1372201560-26015-1-git-send-email-linus.walleij@linaro.org>
 <201306261712.28981.arnd@arndb.de>
 <CACRpkdaSwgPws=G+PcmT6DsQqD-EAQkvKO1PMEVOs9KniJ6xrA@mail.gmail.com>
Message-ID: <201306262204.22653.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Linus Walleij wrote:
> On Wed, Jun 26, 2013 at 5:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 26 June 2013, Russell King - ARM Linux wrote:
> >> On Wed, Jun 26, 2013 at 01:06:00AM +0200, Linus Walleij wrote:
> >> > Instead of remapping the IO memory very early with
> >> > pci_map_io_early(), use pci_ioremap_io() when setting
> >> > up resources as most PCI bridges do. Also request this
> >> > resource properly.
> >>
> >> What impact does this have with a VGA card plugged in?
> >
> > It probably won't work. It's my fault for misreading the driver:
> > I saw it didn't do the pci_ioremap_io, but didn't remember the
> > *_early call being present in the platform.
> 
> I haven't got the VGA working (hacking on the biosemu in
> U-boot from time to time, will get there I hope). So keep this
> patch out for now.
> 
> However I don't see how the VGA console is using iospace?
> We set vga_base to the start of non-prefetched memory, and
> assume the first slot is the VGA card, then it goes poking into
> the screen memory or something... but maybe it's poking the
> ioports in some runpath I can't see :-P
> 

I think you are looking for vga_io_w()/vga_io_r() in case of
vga16fb. vgacon uses inb_p/outb_p directly.

	Arnd
