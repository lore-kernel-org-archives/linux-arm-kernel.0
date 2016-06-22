From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Jun 2016 17:25:03 -0500
Subject: [PATCH] mmc: pwrseq-simple: Add an optional post-power-on-delay
In-Reply-To: <1466618348-32304-1-git-send-email-hdegoede@redhat.com>
References: <1466618348-32304-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAL_JsqJ0XVJb=Q9FT8g_OUTbgZWr-E58xQS0iCR4hv-9EHCcPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 12:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Some devices need a while to boot their firmware after providing clks /
> de-asserting resets before they are ready to receive sdio commands.
>
> This commits adds a post-power-on-delay-ms devicetree property to
> mmc-pwrseq-simple for use with such devices.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>  drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index ce0e767..e254368 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -16,6 +16,8 @@ Optional properties:
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entry:
>    "ext_clock" (External clock provided to the card).
> +- post-power-on-delay-ms : Delay in ms after powering the card and
> +       de-asserting the reset-gpios (if any)

Presumably you need this delay post any reset, not just after power on
if you are waiting for firmware to boot. So the name is not all that
clear. How about a "reset-timing-ms" property that takes 3 values for
pre-assert time (normally 0), assertion time, post assert time. Of
course, I can still think of ways that breaks like when in this
sequence do clocks need to be turned on.

Rob
