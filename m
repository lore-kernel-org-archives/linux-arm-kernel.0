From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 22:28:53 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211173232.43668ab3@pyramind.ukuu.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121211164608.GT14363@n2100.arm.linux.org.uk>
 <20121211173232.43668ab3@pyramind.ukuu.org.uk>
Message-ID: <201212112228.53720.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 December 2012, Alan Cox wrote:
> > Plus, if you have IO space support, you must have some MMIO region for
> > them to target - doing what many platforms have done to date and targetted
> > ISA IO address 0 at virtual address 0 is just not on because as soon as
> > you build a device driver which probes ISA addresses into your kernel,
> > you will oops.
> 
> There shouldn't really be anything poking around that is modern - this is
> true of some PC stuff too.
> 
> In general however if its because you have a window partly mapped you
> could just catch the exception and load 0xFF for reads (and probably
> whine with a backtrace so you know who to moan at).

The problem that Russell refers to is that some platforms define a window
that is 4GB large and starts at NULL. They then ioremap their PCI
or PCMCIA I/O space window and use the virtual __iomem address as the
offset into the 4GB I/O space window. Any driver (e.g. vgacon, /dev/port
or some legacy alsa sound driver) that tries to access a low port number
then ends up in user space memory, typically in an unmapped area there.

We definitely don't want to catch and fixup those exceptions. The solution
is to change the platforms so they actually use the proper I/O window
at a virtual address that is not used for anything else.

	Arnd
