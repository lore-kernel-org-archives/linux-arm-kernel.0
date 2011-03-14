From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Mar 2011 17:21:51 +0100
Subject: [PATCH 2/7] davinci: eliminate use of IO_ADDRESS() on sysmod
In-Reply-To: <1300110947-16229-1-git-send-email-manjunath.hadli@ti.com>
References: <1300110947-16229-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <201103141721.52033.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 March 2011, Manjunath Hadli wrote:
> Current devices.c file has a number of instances where
> IO_ADDRESS() is used for system module register
> access. Eliminate this in favor of a ioremap()
> based access.
> 
> Consequent to this, a new global pointer davinci_sysmodbase
> has been introduced which gets initialized during
> the initialization of each relevant SoC
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

The change looks good, it's definitely a step in the right
direction.

Acked-by: Arnd Bergmann <arnd@arndb.de>


I think you can go even further:

* A straightforward change would be to move davinci_sysmodbase
  into a local variable of the davinci_setup_mmc function,
  which I believe is the only user. Then you can ioremap
  and iounmap it directly there.

* If you need to access sysmod in multiple places, a nicer
  way would be to make the virtual address pointer static,
  and export the accessor functions for it, rather than
  having a global pointer.

	Arnd
