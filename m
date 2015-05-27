From: atull@opensource.altera.com (atull)
Date: Wed, 27 May 2015 15:25:24 -0500
Subject: [PATCH v4 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <556479C9.5070208@opensource.altera.com>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
 <556479C9.5070208@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1505271520570.19205@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 May 2015, Dinh Nguyen wrote:

> Hi Alan,
> 
> On 5/22/15 1:02 PM, Alan Tull wrote:
> > Add code that requests that the sdr controller go into
> > self-refresh mode.  This code is run from ocram.
> > 
> > This patch assumes that u-boot has already configured sdr:
> >   sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> >   sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> >   sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> > 
> > Suspend-to-RAM and EDAC support are mutually exclusive on SOCFPGA
> > platforms.  CONFIG_SOCFPGA_SUSPEND enables suspend-to-RAM and
> > prevents selecting CONFIG_EDAC_ALTERA_MC.
> > 
> > How to suspend to ram:
> >  $ echo enabled > \
> > /sys/devices/soc/ffc02000.serial0/tty/ttyS0/power/wakeup
> > 
> >  $ echo -n mem > /sys/power/state
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > Cc: Pavel Machek <pavel@denx.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> > Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> > v2: use Generic on-chip SRAM driver to allocate ocram
> >     rm fncpy_align since generic allocator handles alignment
> >     check __arm_ioremap_exec return code
> >     check for NULL pointers
> >     add a comment regarding sdram controller configuration
> > v3: fix renamed #define
> >     propagate socfpga_setup_ocram_self_refresh error code
> > v4: Kconfig: don't need to select GENERIC_ALLOCATER
> >     add CONFIG_SOCFPGA_SUSPEND
> >     make s2r and EDAC support mutually exclusive
> >     socfpga.c: add sdr_ctl_base_addr
> >     return error if ocram not available in device tree
> >     update copyright years
> > ---
> 
> <snip>
> 
> > +
> > +static int socfpga_pm_suspend(unsigned long arg)
> > +{
> > +	u32 ret;
> > +
> > +	if (!sdr_ctl_base_addr || !socfpga_scu_base_addr)
> > +		return -EFAULT;
> > +
> > +	ret = socfpga_sdram_self_refresh_in_ocram(
> > +		(u32)sdr_ctl_base_addr, (u32)socfpga_scu_base_addr);
> > +
> 
> I had a patch that removed socfpga_scu_base_addr from being a global and
> just a local variable in:
> 
> f6e14376fb20 ARM: socfpga: use of_iomap to map the SCU
> 
> This patch will be in v4.2 and is currently in arm-soc/next or
> at my fork: kernel/git/dinguyen/linux.git socfpga_for_next_arria10
> 
> So you will either need to make socfpga_scu_base_addr global again, or
> you can use the asm instruction to get the SCU base addr.
> 
> Sorry about that..
> 
> Dinh
> 

I can't make socfpga_scu_base_addr a global from platsmp.c since that file
may or may not be compiled in.

That leaves me with the option of adding the code that was removed from
socfpga.c back where it was or taking that same code moving it to pm.c

What's your preference?

Alan
