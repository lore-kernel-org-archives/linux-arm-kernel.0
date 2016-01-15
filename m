From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 15 Jan 2016 10:03:29 -0800
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <9019174.GYajdpGP8V@wuerfel>
References: <9019174.GYajdpGP8V@wuerfel>
Message-ID: <20160115180329.GU109450@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 10:38:08PM +0100, Arnd Bergmann wrote:
> The nuc900_nand driver has always passed an incorrect register
> address in its nuc900_check_rb() function, which cannot possibly
> work, and in some configurations gives us a build warning:
> 
> drivers/mtd/nand/nuc900_nand.c: In function 'nuc900_check_rb':
> drivers/mtd/nand/nuc900_nand.c:27:23: warning: passing argument 1 of '__raw_readl' makes pointer from integer without a cast [-Wint-conversion]
>  #define REG_SMISR     0xac
> drivers/mtd/nand/nuc900_nand.c:118:20: note: in expansion of macro 'REG_SMISR'
>   val = __raw_readl(REG_SMISR);
> 
> This makes sure we actually read from the register rather than
> from (void *)0x000000ac in user space.
> 
> I suspect nobody noticed this before because the nuc900_nand_devready()
> function never gets called, or nobody uses this driver on an upstream
> kernel. Possibly even both.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Pushed to l2-mtd.git. Thanks.
