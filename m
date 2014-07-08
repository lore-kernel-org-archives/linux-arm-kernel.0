From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 09:46:21 +0200
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CACRpkdZrDJ3xoUYGynf0sO4-U7ZVkJ=Mr_pNVSdar8oM85aVgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 11:15 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:

> From: Doug Anderson <dianders@chromium.org>
>
> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
> being reset across sleep/wake.  If we don't set it to anything then
> the TPM will be reset.  U-Boot will detect this as invalid
> and will reset the system on resume time. This GPIO can always be low
> and not hurt anything.  It will get pulled back high again during a
> normal warm reset when it will default back to an input.
>
> To properly preserve the TPM state across suspend/resume and to make
> the chrome U-Boot happy, properly set the GPIO to mask the
> reset to the TPM.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
(...)
> +       /* We need GPX0_6 to be low at sleep time; just keep it low always */
> +       mask_tpm_reset_regulator: mask-tpm-reset-regulator {
> +       compatible = "regulator-fixed";

No matter how the discussion ends up, regulator-fixed is wrong.

Either folding it into the TPM driver or using a separate reset driver
is fine with me.

So what about the generic delayed reset GPIO thing?
http://marc.info/?l=linux-kernel&m=140309916607115&w=2

Yours,
Linus Walleij
