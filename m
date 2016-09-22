From: atull@opensource.altera.com (atull)
Date: Thu, 22 Sep 2016 14:53:34 -0500
Subject: [PATCH v18 6/6] ARM: socfpga: fpga bridge driver support
In-Reply-To: <20160809160039.GX29630@windriver.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
 <20160712193645.9098-7-atull@opensource.altera.com>
 <CAP=VYLo2jtp57kQe5671xM=4o_ZAU6XG_W1MXU8aPv4Ws7kkDA@mail.gmail.com>
 <alpine.DEB.2.02.1608081416110.11063@linuxheads99>
 <CAAtXAHev2Dytadp-_Hs0agcSXUTyrFhJQxHcsFd7faOReHzr9Q@mail.gmail.com>
 <20160809160039.GX29630@windriver.com>
Message-ID: <alpine.DEB.2.02.1609221451140.4126@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Aug 2016, Paul Gortmaker wrote:

> [Re: [PATCH v18 6/6] ARM: socfpga: fpga bridge driver support] On 08/08/2016 (Mon 13:44) Moritz Fischer wrote:
> 
> > Hi Alan,
> > 
> > On Mon, Aug 8, 2016 at 12:18 PM, atull <atull@opensource.altera.com> wrote:
> > 
> > >> Please don't use module.h in drivers controlled by a bool
> > >> Kconfig setting.
> > >>
> > >> THanks,
> > >> Paul.
> > >>
> > >
> > > Thanks for the feedback.  Can you provide an example of what you
> > > would consider to be proper usage in the kernel?
> > 
> > 
> > I think Paul is suggesting to use
> > 
> > static int __init alt_fpga_bridge_init(void)
> > {
> >         platform_driver_register(&alt_fpga_bridge_driver);
> > }
> > 
> > device_initcall(alt_fpga_bridge_init);
> > 
> > or better:
> > 
> > builtin_platform_driver(&alt_fpga_bridge_driver);
> > 
> > Like for example in: drivers/cpuidle/cpuidle-mvebu-v7.c
> 
> Yes, pretty much that -- if you have a bool Kconfig, you should be using
> builtin registration functions, and have no need for module.h or
> anything MODULE_<xyz> or any module_init/module_exit calls.
> 
> An empty file containing nothing but #include <linux/module.h> will
> cause cpp to emit about 750k of goop, so we really should only be using
> it for drivers that are genuinely modular; i.e. tristate Kconfig.
> 
> Thanks,
> Paul.
> --
> 
> > 
> > Cheers,
> > 
> > Moritz
> 

Thanks for the feedback and explanations!

I've retested my stuff with it all built as modules (mgr, bridged,
and fpga-region) and it all works that way as well as built in.
So I'll fix up the Kconfig as tristates for everybody.  Also
I'll add some dependencies as FPGA_REGION should be dependent
on FPGA_BRIDGE.

Alan
