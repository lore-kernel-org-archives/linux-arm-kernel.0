From: john.stultz@linaro.org (John Stultz)
Date: Fri, 5 Aug 2016 10:56:43 -0700
Subject: [PATCH 1/2] ARM: dts: MSM8064 remove flags from SPMI/MPP IRQs
In-Reply-To: <1470386318-17694-2-git-send-email-linus.walleij@linaro.org>
References: <1470386318-17694-1-git-send-email-linus.walleij@linaro.org>
 <1470386318-17694-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CALAqxLVY4DbfEnd3oJ1ZHeEjnTe=NN8R0YBFwpDP=8dGJQw2RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2016 at 1:38 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The Qualcomm PMIC GPIO and MPP lines are problematic: the
> are fetched from the main MFD driver with platform_get_irq()
> which means that at this point they will all be assigned the
> flags set up for the interrupts in the device tree.
>
> That is problematic since these are flagged as rising edge
> and an this point the interrupt descriptor is assigned a
> rising edge, while the only thing the GPIO/MPP drivers really
> do is issue irq_get_irqchip_state() on the line to read it
> out and to provide a .to_irq() helper for *other* IRQ
> consumers.
>
> If another device tree node tries to flag the same IRQ
> for use as something else than rising edge, the kernel
> irqdomain core will protest like this:
>
>   type mismatch, failed to map hwirq-NN for <FOO>!
>
> Which is what happens when the device tree defines two
> contradictory flags for the same interrupt line.
>
> To work around this and alleviate the problem, assign 0
> as flag for the interrupts taken by the PM GPIO and MPP
> drivers. This will lead to the flag being unset, and a
> second consumer requesting rising, falling, both or level
> interrupts will be respected. This is what the qcom-pm*.dtsi
> files already do.
>
> Switched to using the symbolic name IRQ_TYPE_NONE so that
> we get this more readable.
>
> Cc: stable at vger.kernel.org
> Fixes: bce360469676 ("ARM: dts: apq8064: add pm8921 mpp support")
> Fixes: 874443fe9e33 ("ARM: dts: apq8064: Add pm8921 mfd and its gpio node")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Bj?rn Andersson <bjorn.andersson@linaro.org>
> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I vaguely remember John having problems with interrupts
> on the Nexus 7 that could be related to this so involving
> him on these patches.

Yea. Thanks for including me. Unfortunately these patches don't
resolve the problem I'm seeing (I still don't get any interrupts from
the volume/power buttons), and I still have to revert "irqdomain:
Don't set type when mapping an IRQ" to get things working.

thanks
-john
