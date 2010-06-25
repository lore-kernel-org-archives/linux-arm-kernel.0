From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 25 Jun 2010 12:22:32 +0100
Subject: [PATCH] MMC: remove regulator refcount fiddling in mmc core
In-Reply-To: <1277392337-27627-1-git-send-email-linus.walleij@stericsson.com>
References: <1277392337-27627-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100625112232.GA21217@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 05:12:17PM +0200, Linus Walleij wrote:

> Currently the mmc_regulator_set_ocr() fiddles with the regulator
> refcount by selectively calling regulator_[enable|disable]
> depending on the state of the regulator. This will confuse the
> reference count if case the regulator is for example shared with
> other MMC slots or user for other stuff than the MMC card.

> Push regulator_[enable|disable] out into the MMC host drivers
> and remove this from the MMC core so the reference count can be
> trusted.

So, the feedback from folks at the time this was originally written was
that the MMC code was unable to cope with sharing regulators since it
really needs to be able to set specific voltages.  This needn't be a
showstopper since people can force a single voltage in the constraints
but it does need to be considered here.
