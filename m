From: cjb@laptop.org (Chris Ball)
Date: Thu, 21 Jun 2012 03:27:00 -0400
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <1339512111-11172-1-git-send-email-robherring2@gmail.com> (Rob
 Herring's message of "Tue, 12 Jun 2012 09:41:47 -0500")
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
Message-ID: <87bokd15x7.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jun 12 2012, Rob Herring wrote:
> This series defines clock bindings for Device-Tree and adds kernel
> support using the common clock infrastructure. The last patch enables
> DT clock support for the Calxeda Highbank platform.
>
> I'm posting this again to solicit further review. There has been some
> discussion[1], but no definite path forward. This series is not changed
> from the last post other than rebasing to v3.5-rc2.

This is a very useful patchset, thanks!  Mitch Bradley and I have been
hooking up the mach-mmp ARM subarchitecture to it and we needed to
make a few changes, mainly because mach-mmp doesn't use COMMON_CLK.
The changes are:

1) Remove the COMMON_CLK dependency that the of_clk_* functions have by
   moving them into a new file, drivers/clk/clk-of.c.  The OF functions
   in drivers/clk/clk.c aren't dependent on anything else in clk.c
   (since you pass them a struct clk) so they can be moved out easily.
   The of_clk_* entries in clk-provider.h move to clk.h.

2) Use alloc_bootmem() instead of kzalloc() in of_clk_add_provider(),
   because we need to set up clocks during .init_early on ARM (which
   happens pre-slab) so that they are available for platform init.

I'll send our patches in a reply to this mail.  Are you okay with these
changes, and would you like to include them in your patchset?

Thanks very much,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
