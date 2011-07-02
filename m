From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 2 Jul 2011 21:41:31 +0200
Subject: [PATCH 5/6] ARM: convert PCI defines to variables
In-Reply-To: <4E0F11B3.30803@gmail.com>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<201107021121.46701.arnd@arndb.de> <4E0F11B3.30803@gmail.com>
Message-ID: <201107022141.31972.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 July 2011 14:40:19 Rob Herring wrote:
> > Basically, the defaults should clearly be 
> > 
> > unsigned long pcibios_min_io  = 0x1000;
> > unsigned long pcibios_min_mem = 0x01000000;
> > 
> > This just gets us out of the ISA bus range, so an ISA card behind
> > a bridge can use all cards correctly. Most of the ones that
> > currently set both to zero can probably just use those defaults
> > as well, but some architectures have multiple buses or don't start
> > the memory range at zero, so they might need higher values.
> 
> For many platforms, the defaults are 0 for both of these, so I went with
> that. Do you think those are just wrong?

They prevent you from having a VGA card or anything else that uses the
legacy ISA I/O ranges on the PCI bus, so it's a bad default.

However, some platforms may have specific reasons not to use these
values but instead start the address allocation at zero. E.g. the
memory window may be severely limited in some implementations, so
you can't afford to lose the first 16 MB.

I would make the default 0x1000/0x01000000 and specifically set the
platforms that require other values, possibly with a comment questioning
whether that's a good choice.

	Arnd
