From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Fri, 13 Nov 2009 08:50:26 +0100
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe
	bridge?is present
In-Reply-To: <200911121802.10323.dk-arm-linux@gmx.de>
References: <200911121519.42786.dk-arm-linux@gmx.de>
	<p0nts6-gt3.ln1@chipmunk.wormnet.eu>
	<200911121802.10323.dk-arm-linux@gmx.de>
Message-ID: <20091113085026.4099d6eb@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Nov 2009 18:02:10 +0100
Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:

[openrd_base_pci_init]
> > > +       if (base)
> > > +       {
> > > +               cpu_config_reg = readl(base);
> > > +               cpu_config_reg &= ~(1 << 2);
> > > +               writel(cpu_config_reg, base);
> > > +       }
> > > +       iounmap(base);
> > > +
> > >        if (machine_is_openrd_base())
> > >                kirkwood_pcie_init();
> > > -
> > >        return 0;
> > >  }
> > > subsys_initcall(openrd_base_pci_init);
>
> Hm, is this really right? Why is there a function called openrd_base_pci_init() which is inside a file
> called openrd_base-setup.c and this function is called on a sheevaplug?

You can build the kernel with support for multiple boards, let's say
sheevaplug and OpenRD base/client. Since this function is marked as a
subsys_initcall, it will _always_ be called by the kernel when it has
reached far enough into the startup - it doesn't matter which board
support this function resides in.

Thus, even if you run on a sheevaplug board, it will run
openrd_base_pci_init() and clear your bit. Like Alexander, I also did
the same mistake :-)


Of course, in this particular case, it *should* probably be done for
all boards - just not in the openrd_base board support code!

// Simon
