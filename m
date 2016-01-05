From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jan 2016 17:43:47 -0600
Subject: [PATCH 2/2] ARM: versatile: fix MMC/SD interrupt assignment
In-Reply-To: <1451984370-16932-1-git-send-email-linus.walleij@linaro.org>
References: <1451984370-16932-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_Jsq+8JOSpUefSUMakAsESbjFgfGFpFsH=7utZWP_H6HPM6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 5, 2016 at 2:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Commit 0976c946a610d06e907335b7a3afa6db046f8e1b
> "arm/versatile: Fix versatile irq specifications"
> has an off-by-one error on the Versatile AB that has
> been regressing the Versatile AB hardware for some time.
>
> However it seems like the interrupt assignments have
> never been correct and I have now adjusted them according
> to the specification. The masks for the valid interrupts
> made it impossible to assign the right SIC interrupt
> for the MMCI, so I went in and fixed these to correspond
> to the specifications, and added references if anyone
> wants to double-check.
>
> Due to the Versatile PB including the Versatile AB
> as a base DTS file, we need to override and correct
> some values to correspond to the actual changes in the
> hardware.
>
> For the Versatile PB I don't think the IRQ line
> assignment for MMCI has ever been correct for either of
> the two MMCI blocks. It would be nice if someone with the
> physical PB board could test this.
>
> Patch tested on the Versatile AB, QEMU for Versatile AB
> and QEMU for Versatile PB.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: stable at vger.kernel.org
> Fixes: 0976c946a610 ("arm/versatile: Fix versatile irq specifications")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC people: please apply this directly for fixes if
> you find it OK.
> ---
>  arch/arm/boot/dts/versatile-ab.dts | 10 +++++++---
>  arch/arm/boot/dts/versatile-pb.dts | 20 +++++++++++++++++++-
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
> index 01f40197ea13..3279bf1a17a1 100644
> --- a/arch/arm/boot/dts/versatile-ab.dts
> +++ b/arch/arm/boot/dts/versatile-ab.dts
> @@ -110,7 +110,11 @@
>                         interrupt-parent = <&vic>;
>                         interrupts = <31>; /* Cascaded to vic */
>                         clear-mask = <0xffffffff>;
> -                       valid-mask = <0xffc203f8>;
> +                       /*
> +                        * Valid interrupt lines mask according to
> +                        * table 4-36 page 4-50 of ARM DUI 0225D
> +                        */
> +                       valid-mask = <0x0760031b>;

I never really liked valid-mask in the first place. Valid interrupts
are the ones specified by devices and we don't need this extra data.
If we do, then *every* interrupt controller needs this property.
Perhaps the driver should just ignore it. But you've already done the
work here, so this is okay too.

Rob
