From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 17:13:44 +0100
Subject: [PATCH] staging: goldfish: use div64_s64 instead of do_div
In-Reply-To: <20160201145457.7879d53f@lxorguk.ukuu.org.uk>
References: <1676170.0qik6mzm6D@wuerfel>
 <20160201145457.7879d53f@lxorguk.ukuu.org.uk>
Message-ID: <2123401.bK87U6BMYJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 February 2016 14:54:57 One Thousand Gnomes wrote:
> On Mon, 01 Feb 2016 11:33 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The goldfish nand driver divides a signed 64-bit number (loff_t)
> > in multiple places using the do_div() function. This has always
> > been unreliable but now produces a compiler warning (since 4.5-rc1):
> > 
> > goldfish/goldfish_nand.c: In function 'goldfish_nand_erase':
> > goldfish/goldfish_nand.c:107:91: error: comparison of distinct pointer types lacks a cast [-Werror]
> > goldfish/goldfish_nand.c: In function 'goldfish_nand_read_oob':
> > goldfish/goldfish_nand.c:145:91: error: comparison of distinct pointer types lacks a cast [-Werror]
> > 
> > This changes the code to the equivalent div_s64{,_rem} that
> > works correctly for negative numbers (which we should never
> > get here).
> 
> We can't get negatives as you say so surely the right fix is a cast or to
> fix mtd->writesize ?

A cast won't work because the first argument to the do_div() macro is
both input and output.

It's not the mtd->writesize argument that is the problem here, but the
'ofs' argument that comes from the loff_t argument in mtdchar_read()
and others (ultimately from the lseek/pread/pwrite/...)

We could change all the function prototypes in struct mtd_info to use
u64 instead of loff_t, but that involve change all MTD drivers and the
subsystem.

	Arnd
