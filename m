From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Feb 2012 17:00:39 +0000
Subject: [GIT PULL] ux500 patches for v3.4
In-Reply-To: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
References: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201202211700.39669.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Linus Walleij wrote:
> 
> Hi Arnd, Olof,
> 
> here are some accumulated patches for ux500 from the mailing
> list, intended for the next (3.4) merge window.
> 
> In order to somewhat make sure that they do not unnecessary
> conflict with other stuff in the tree I pulled the whole
> shebang into a branch off yesterdays linux-next and it worked
> just fine, so it should be orthogonal to other changes.
> 
> The main change is support for a new ASIC variant in the
> families named DB9540 and its platform the U9540.

Hi Linus,

Most of the patches look ok, but since this about a new SoC,
I decided to take a much closer look and found a few issues that
I think you can still fix:

* The handling of the DB9540_ROM adds a number of special cases,
but in the end it looks like this is not used anywhere, so I'd
recomment just removing it. If you get something that needs the
ROM to be mapped, just make that use ioremap.

* You add a new irqs-db9540.h file, but the macros defined in there
are not actually used. Better not add that file then, especially
since the interrupt definitions will soon all move into device
tree for ux500.

* I assume that we will need to add a few changes to make this
actually work together with Lee's series. I would suggest that
I put your series into the next/soc branch and merge it into
the next/soc2 branch as well, which already has his patches.
Then you can add a patch on top that adds the necessary changes,
if any.

	Arnd
