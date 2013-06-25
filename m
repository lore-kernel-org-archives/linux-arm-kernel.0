From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 01:08:14 +0200
Subject: [GIT PULL] Integrator/AP PCI DT support
In-Reply-To: <201306200133.07315.arnd@arndb.de>
References: <CACRpkdb8J4+QH36SYavgGWbFWaBZDg5JSYyyJELzL=mSZfMnBw@mail.gmail.com>
 <20130615000922.GG18124@quad.lixom.net>
 <CACRpkdZaTDEu8vUx347k1Y5Pht5Pi_mPJXpDsVtAsSYVT60n_Q@mail.gmail.com>
 <201306200133.07315.arnd@arndb.de>
Message-ID: <CACRpkdYqGYq9NA4F7fpy4mO5fqHki38Q4SdXYteBVRfUGWxPYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 1:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> +               ranges = <0x00000000 0 0x61000000 /* config space */
> +                       0x61000000 0 0x00100000 /* 16 MiB @ 61000000 */
> +                       0x01000000 0 0x60000000 /* I/O space */
> +                       0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
> +                       0x02000000 0 0x40000000 /* non-prefectable memory */
> +                       0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
> +                       0x42000000 0 0x50000000 /* prefetchable memory */
> +                       0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
>
> This would not work, you need 0 as the local side address for I/O space
> (unlike memory space) instead of 0x60000000. Your code ignores the
> I/O space at the moment, but the ranges should be set up to let us
> handle it in the future.

Sorry for being totally blank on PCI, probably a copy/paste error.
Made a patch for this.

> For the memory space, you seem to ignore the bus address in the ranges
> at the moment. Please fix that too, either by programming 0x40000000/
> 0x50000000 into V3_LB_MAP0/V3_LB_MAP1,

That was never done before so wouldn't dare trying it...

> or by changing the ranges
> to have 0x00000000/0x10000000 as the local part for non-prefetch/prefetch
> memory.

This is probably preferrable.
Made a patch for this.

> Either way is possible, but please make the DT consistent with
> the code, ideally by using the information from DT to set up the
> windows.

Made a patch for this as well.

> Also, why not just map the I/O space by calling pci_ioremap_io?

Made a patch for this as well.

I don't know if you want to apply all of them directly or pick-and
choose, but sent them to arm at kernel.org directly so you can
decide. I guess they all need to hit the branch next/soc in that
case.

Yours,
Linus Walleij
