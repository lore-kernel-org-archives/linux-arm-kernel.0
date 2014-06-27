From: dianders@chromium.org (Doug Anderson)
Date: Fri, 27 Jun 2014 09:45:45 -0700
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <53AD978D.8060703@wwwdotorg.org>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
 <53ABED5B.8010506@samsung.com>
 <CAD=FV=Vwgdis6FzJ8MHDwfuohB1kN8Mf--2N=rxGNeAfKjJMig@mail.gmail.com>
 <53AD60D7.4040404@gmail.com> <53AD978D.8060703@wwwdotorg.org>
Message-ID: <CAD=FV=UUFARvreHdWNsB1O1dEW6nX_E_C92t8Nma0vL=nAT5Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Fri, Jun 27, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Surely there's a driver (or could be a driver) for the TPM chip, and
> that driver should have a reset-mask-gpios property, so the driver can
> call gpio_get() and gpio_set_output() on the GPIO?
>
> Faking this out via a not-really-a-regulator or pinctrl hogs seems like
> an abuse of those features to me.

This totally doesn't belong in the TPM chip driver.  This is an
unabashed HACK at the board level.  Without a hog we need a board
driver for this.

To be more specific:

* The TPM needs to be reset when the full system gets reset.  This
unlocks the TPM and allows certain types of updates by the firmware.
The firmware then locks the TPM before jumping to the kernel.

* The TPM is hooked up to the "reset out" line of the CPU so that when
the system does a warm reset it will reset the TPM.

* Unfortunately the CPU asserts the "reset out" line when it's
sleeping (because, of course, sleep is a reset).  This would allow the
kernel to unlock the TPM which it's not supposed to be able to do.

* To solve the problem, it's up to the kernel to "mask" out the reset
line before going to sleep.  Then it's up to the read only firmware to
validate that the kernel properly masked the reset before resuming
from sleep.  If the firmware finds that the kernel cheated and didn't
mask the reset then it will not resume to the kernel and will instead
restart the system.


The above is not beautiful in the least sense.  Getting suspend/resume
working happened very late in the exynos5250-snow project and the
above workaround was the best that we could come up with without
slipping schedules.  It also had the side effect of being less
expensive than other solutions.  Given that the solution was "proven
out" for exynos5250-snow, it was kept in place for similar products.

-Doug
