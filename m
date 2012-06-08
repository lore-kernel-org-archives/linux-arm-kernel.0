From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Jun 2012 20:43:17 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <1339177361.9569.23.camel@linaro1.home>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
 <201206081534.13261.arnd@arndb.de> <20120608164255.GB674@lunn.ch>
 <1339177361.9569.23.camel@linaro1.home>
Message-ID: <20120608184317.GD674@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > However, all current systems have either SPI FLASH or NAND, since that
> > is how these devices boot. So, under normal conditions, this clock is
> > always used, and so never gets turned off as being unused.
> 
> What if your filesystems are on devices other than flash (I use an SD
> card on my Sheevaplugs). In that case flash isn't used at all by the
> Linux kernel and could be safely turned off. I'm not saying that this is
> worth the hassle, just pointing out that flash may be unused by Linux on
> some systems.

The current sheevaplug code sets up the nand driver and mtd
partitions. That is sufficient to ensure the clock is kept on. It does
not matter if a partitions are used or not.

I in fact use a similar system to you. I typically use kirkwood
devices which are NAS boxes and i have the root file system on the
disk and i tftpboot the kernel. The SPI flash is unused, but its still
made available via mtd.

Problems will however come when somebody creates a box which really
does boot from disk and skips NAND and SPI-FLASH in the DT description
of the device. That is why i like claiming this clock in the core
code, just to say there is something in the CPU core using it. 

     Andrew
