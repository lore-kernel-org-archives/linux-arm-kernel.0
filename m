From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jan 2014 11:09:16 +0000
Subject: mainline build: 11 warnings 0 failures (mainline/v3.13-rc8)
In-Reply-To: <52d274b2.aa13450a.77fb.ffffe540@mx.google.com>
References: <52d274b2.aa13450a.77fb.ffffe540@mx.google.com>
Message-ID: <20140112110916.GR15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 02:55:46AM -0800, Olof's autobuilder wrote:
> Warnings:
>       1 drivers/leds/leds-pwm.c:88:22: warning: unused variable 'node' [-Wunused-variable]
>       1 drivers/net/ethernet/ti/cpsw.c:2140:2: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t' [-Wformat=]
>       1 drivers/net/ethernet/ti/davinci_cpdma.c:182:3: warning: passing argument 3 of 'dma_alloc_attrs' from incompatible pointer type [enabled by default]
>       1 drivers/net/ethernet/ti/davinci_cpdma.c:222:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       1 drivers/net/ethernet/ti/davinci_cpdma.c:223:8: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       1 drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'resource_size_t' [-Wformat=]
>       1 drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t' [-Wformat=]
>       2 drivers/mtd/nand/gpmi-nand/gpmi-nand.c:123:13: warning: 'set_geometry_by_ecc_info' defined but not used [-Wunused-function]
>       2 net/netfilter/ipvs/ip_vs_sync.c:1640:8: warning: unused variable 'ret' [-Wunused-variable]

Every time I look at these build reports, I see these same old warnings
time and time again, which no one is addressing.  Some warnings are more
serious than others.  In this case:

warning: format 'XX' expects argument of type 'unsigned int', but argument X has type 'resource_size_t' [-Wformat=]

is a serious warning that's a real bug and really needs fixing.  Why?

It means that format expects to see a 32-bit argument, but has been passed
a potential 64-bit argument instead.

Firstly, remember that on EABI, 64-bit arguments need natural alignment in
memory and in registers.  So, if the 32-bit argument would've been in r1,
it actually gets passed in r2/r3 and r1 is unused.  The result will be
that we will print r1.

Secondly, any following arguments are not correctly accessed.  If any of
the following arguments are a pointer which we're going to dereference (eg,
due to a %s format or one of these new fangled %p formats), we will not
dereference the pointer that we think we should be - taking the above
example, the next argument will be r2, rather than the first stacked
argument.

All these resource_size_t warnings need to be fixed, and stay fixed.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
