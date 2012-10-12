From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2012 11:05:09 +0000
Subject: [PATCH v2 5/8] clk: don't mark clkdev_add_table as init
In-Reply-To: <20121012091535.GD21164@n2100.arm.linux.org.uk>
References: <1349813638-4617-1-git-send-email-arnd@arndb.de>
 <1349813638-4617-6-git-send-email-arnd@arndb.de>
 <20121012091535.GD21164@n2100.arm.linux.org.uk>
Message-ID: <201210121105.09517.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 October 2012, Russell King - ARM Linux wrote:
> On Tue, Oct 09, 2012 at 10:13:55PM +0200, Arnd Bergmann wrote:
> > s3c2440_clk_add is a subsys_interface method and calls clkdev_add_table,
> > which means we might be calling it after the __init section is
> > discarded.
> > 
> > Without this patch, building mini2440_defconfig results in:
> > 
> > WARNING: vmlinux.o(.text+0x9848): Section mismatch in reference from the function s3c2440_clk_add() to the function .init.text:clkdev_add_table()
> > The function s3c2440_clk_add() references
> > the function __init clkdev_add_table().
> > This is often because s3c2440_clk_add lacks a __init
> > annotation or the annotation of clkdev_add_table is wrong.
> 
> I'm not sure this is the right thing to do.  I suspect this comes from the
> stupidly complex samsung code, and that this is actually safe - I suspect
> that s3c2440_clk_add() needs to be appropriately marked, but then you end
> up having to trace its call path through various structures etc.

Yes, you are right. I have verified now that the only code path into
s3c2440_clk_add() is from "int __init s3c2440_init(void)", so 
s3c2440_clk_add can be marked __init_refok.

I'll follow up with a new patch to replace this one.

	Arnd
