From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 1 Feb 2013 10:39:22 -0600
Subject: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <20130201153152.GS23505@n2100.arm.linux.org.uk>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-5-git-send-email-dinguyen@altera.com>
 <20130201035040.GE4838@quad.lixom.net>
 <20130201104655.GA3124@amd.pavel.ucw.cz>
 <71B37E0559AC6849A68C5BA94C509FB45A63D4E47D@SJ-ITMSG02.altera.priv.altera.com>
 <20130201153152.GS23505@n2100.arm.linux.org.uk>
Message-ID: <1359736762.2932.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-01 at 15:31 +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 07:27:46AM -0800, Dinh Nguyen wrote:
> > Hi Olof,
> > On Fri, 2013-02-01 at 11:46 +0100, ZY - pavel wrote:
> > > Hi!
> > >
> > > > > Because the CPU1 start address is different for socfpga-vt and
> > > > > socfpga-cyclone5, we add code to use the correct CPU1 start addr.
> > >
> > > > > @@ -72,6 +73,13 @@ void __init socfpga_sysmgr_init(void)
> > > > >   struct device_node *np;
> > > > >
> > > > >   np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
> > > > > +
> > > > > + if (of_property_read_u32(np, "cpu1-start-addr",
> > > > > +                 (u32 *) &cpu1start_addr)) {
> > > > > +         early_printk("Need cpu1-start-addr in device tree.\n");
> > > > > +         panic("Need cpu1-start-addr in device tree.\n");
> > > > > + }
> > > > > +
> > > > >   sys_manager_base_addr = of_iomap(np, 0);
> > > >
> > > > Wouldn't it be easier to diagnose this failure if you just printed the error
> > > > and continued booting without the second CPU? An early panic is usually really
> > > > hard to debug since you might not get early console without extra work.
> > >
> > > I actually thought about that... but could not think of non-ugly way
> > > of doing that. I hope dts will normally be "right" for any production
> > > system...
> > 
> > I think a panic is better just for the reason that if someone is
> > expecting SMP, but missed the warning message, and later finds out that
> > the secondary core never came up, it would save some debugging time.
> > 
> > Since I have to send out a v3 from the 1st patch anyways, let me verify
> > that I can get the early warning.
> 
> The choice is between a panic() at a point where the only way to find
> out is to throw in printascii() or a working printk, and ending up with
> an unbootable kernel, vs continuing the boot and having an almost
> working system which can be logged into and the messages viewed.
> 
> If you have an application which relies on the second CPU coming up,
> why not have it verify that the second CPU came up (it's quite easy
> to do - there's POSIX standard libc calls to get the number of online
> CPUs).

Point taken...thanks Russell.

Dinh
> 
