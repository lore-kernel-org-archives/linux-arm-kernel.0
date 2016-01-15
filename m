From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jan 2016 12:03:43 +0100
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <5698A585.7060007@iommu.org>
References: <9019174.GYajdpGP8V@wuerfel> <4251392.DUmfQyrPag@wuerfel>
 <5698A585.7060007@iommu.org>
Message-ID: <11388611.tVUcx6RgHM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 January 2016 15:53:41 Wan Zongshun wrote:
> 
> >>
> >> Actually, Nuvoton should still leverage this upstream w90x900 codes for
> >> their old and new arm chip BSP, but I am not sure their open source plan
> >> for the new chip now, I will check with Nuvoton for this topic, and give
> >> you feedback here, so please hold on its removal.
> >
> > Ok, sure. Thanks for the quick reply!
> >
> > I've had a look around at the current produce lineup, and it seems that
> > nuc900 (w90x900) is still marketed, and as you say is similar to the n329
> > series.
> >
> > There has been one attempt to do a modern port for n329 in 2014 but
> > it never got submitted. See http://comments.gmane.org/gmane.linux.kernel.kernelnewbies/49077
> > and https://github.com/mpthompson/linux/tree/n329
> >
> > The code looks rather nice, so it's a pity that the effort stalled,
> > but it should not be hard for anyone to start out with Mike's tree
> > and forward-port it to 4.5.
> 
> I will try to get this board you mentioned and try to cowork Mike to 
> submit it into upstream.
> 
> After checking with Nuvoton people, and I will get another board and 
> help them update the latest kernel BSP and also submit new nuc970 chip 
> BSP into upstream.
> 
> spec:
> http://www.nuvoton.com/hq/products/microprocessors/arm9-mpus/nuc900-series/?__locale=en
> 

This sounds great, good to hear!

I see that your last feature contribution to mach-w90x900 was a little over
5 years ago, before we started the current arm-soc process, after that
we only had bug fixes and smaller cleanups.

I don't know to what degree you have been following what the other platforms
have done in the meantime, so let me try to get you up to speed:

* All patches from platform maintainers by default get merged through the
  arm-soc tree at http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git
  Please send patches "To: arm at kernel.org", Cc the relevant mailing lists,
  and split them up to you submit bug fixes, cleanups, and new features
  separately (they go into different branches)

* All actively maintained platforms should use CONFIG_ARCH_MULTIPLATFORM.
  This will take significant work for mach-w90x900, but you don't have to
  do it all at once. As a rule of thumb, I'd expect that for any work
  you do on new features in the platform, an at least equal amount of work
  is spent on getting closer to multiplatform support until you are done.
  This has worked well for most other platforms, and with the work that
  Mike has done it is all complete.

* We have basically stopped taking new board files and moved on to
  using devicetree descriptions of the hardware. It's probably ok to
  add one more board file for the nuc970 reference design here if you
  also work on the cleanup and you don't expect to add multiple other
  machines. Again, Mike's port seems already uses DT.

* The multiplatform work does not require the dts conversion, but it
  does require converting the clock.c file into a driver for drivers/clk/,
  and it requires converting the interrupt handling to use an irqchip
  driver with CONFIG_IRQ_DOMAIN and CONFIG_MULTI_IRQ_HANDLER. These
  are usually not hard to do if you have the hardware for testing, but
  it's not easy otherwise.

* I've merged a patch that moves all mach/*.h headers out of the globally
  visible directory to arch/arm/mach-w90x900/*.h directly unless they are
  used by some driver outside of mach-w90x900. To complete the multiplatform
  work, all remaining headers have to be moved as well, either into the
  driver or into the platform directory.

* I'd suggest you start by looking at n329 code from Mike before you
  submit the nuc970 support. As I think it gets all of the above right
  already, it may even be possible to support the nuc970 through the
  new mach-n329 support, or to share a large portion of the code.

	Arnd
