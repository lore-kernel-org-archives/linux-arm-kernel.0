From: atull@opensource.altera.com (atull)
Date: Tue, 26 May 2015 16:40:35 -0500
Subject: [PATCH v4 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <20150525124133.GF9943@amd>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
 <20150525124133.GF9943@amd>
Message-ID: <alpine.DEB.2.02.1505261638190.19205@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 May 2015, Pavel Machek wrote:

> Hi!
> 
> > Suspend-to-RAM and EDAC support are mutually exclusive on SOCFPGA
> > platforms.  CONFIG_SOCFPGA_SUSPEND enables suspend-to-RAM and
> > prevents selecting CONFIG_EDAC_ALTERA_MC.
> 
> Do we went to have the dependency at the .config time? We would like
> to do generic kernels booting on many machines, this kind of breaks
> that...
> 

Hi Pavel,

Thanks for the feedback.

Yes I agree.

One possibility is that I could add a suspend function to EDAC that
always fails with a helpful message like "Suspend with EDAC not
supported."  If someone wants to suspend, they'll have to take the
EDAC out of the device tree so its probe will bomb out.  I'm not
sure how normal it is to have suspend functions in the kernel
that always fail, though.


> > +	/*
> > +	 * This code assumes that the bootloader has already
> > +	 * properly configured the sdram controller:
> 
> Which bootloaders can do that? 

Whatever bootloader is configuring the sdram controller for the
board.

> 
> > +	 * sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> > +	 * sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> > +	 * sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> 
> Would it make sense to configure it in Linux?
> 
> Thanks,
> 									Pavel

The bootloader is responsible for configuring the sdram
controller with parameters appropriate for whatever vendor's DDR
is on the board, so that's where this must go.

Now I realize I should make this message more general, since it is
true for the socfpga cyclone5 devkit, but may need to be adjusted
for other boards.

Alan
