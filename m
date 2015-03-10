From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 22:00:14 +0100
Subject: [PATCH v3] mtd: cfi: reduce stack size
In-Reply-To: <20150310194126.GC4124@norris-Latitude-E6410>
References: <2266200.3mx7btcFe5@wuerfel>
 <20150310194126.GC4124@norris-Latitude-E6410>
Message-ID: <201503102200.16344.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015, Brian Norris wrote:
> On Tue, Mar 10, 2015 at 05:48:37PM +0100, Arnd Bergmann wrote:
> > The cfi_staa_write_buffers function uses a large amount of kernel stack
> > whenever CONFIG_MTD_MAP_BANK_WIDTH_32 is set, and that results in a
> > warning on ARM allmodconfig builds:
> > 
> > drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_write_buffers':
> > drivers/mtd/chips/cfi_cmdset_0020.c:651:1: warning: the frame size of 1208 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > It turns out that this is largely a result of a suboptimal implementation
> > of map_word_andequal(). Replacing this function with a straightforward
> > one reduces the stack size in this function by exactly 200 bytes,
> > shrinks the .text segment for this file from 27648 bytes to 26608 bytes,
> > and makes the warning go away.
> 
> Patch looks OK to me, and those results are nice.
> 
> Did you (or anyone else) do any testing?

No runtime tests, I only built them, sorry.

	Arnd
