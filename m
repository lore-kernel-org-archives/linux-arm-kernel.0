From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 2 Feb 2016 16:34:44 +0000
Subject: [PATCH] staging: goldfish: use div64_s64 instead of do_div
In-Reply-To: <1676170.0qik6mzm6D@wuerfel>
References: <1676170.0qik6mzm6D@wuerfel>
Message-ID: <20160202163444.25b73816@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Feb 2016 11:33 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> The goldfish nand driver divides a signed 64-bit number (loff_t)
> in multiple places using the do_div() function. This has always
> been unreliable but now produces a compiler warning (since 4.5-rc1):
> 
> goldfish/goldfish_nand.c: In function 'goldfish_nand_erase':
> goldfish/goldfish_nand.c:107:91: error: comparison of distinct pointer types lacks a cast [-Werror]
> goldfish/goldfish_nand.c: In function 'goldfish_nand_read_oob':
> goldfish/goldfish_nand.c:145:91: error: comparison of distinct pointer types lacks a cast [-Werror]
> 
> This changes the code to the equivalent div_s64{,_rem} that
> works correctly for negative numbers (which we should never
> get here).
> 
> The warning has shown up on ARM allmodconfig builds after the goldfish
> bus driver has become visible on ARM.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: bd2f348db503 ("goldfish: refactor goldfish platform configs")

Acked-by: Alan Cox <alan@linux.intel.com>

Now agree with Arnd's patch.
