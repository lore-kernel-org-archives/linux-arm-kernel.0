From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 17 Oct 2017 20:53:53 -0500
Subject: [PATCH v5 3/3] drivers/irqchip: gicv3: add workaround for
 Synquacer pre-ITS
In-Reply-To: <20171017165556.30250-4-ard.biesheuvel@linaro.org>
References: <20171017165556.30250-1-ard.biesheuvel@linaro.org>
 <20171017165556.30250-4-ard.biesheuvel@linaro.org>
Message-ID: <CAL_Jsq+814HWD6D=FTDJBbgQuMCrkkdWo7qhH3TL6LYgGNQjaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 11:55 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The Socionext Synquacer SoC's implementation of GICv3 has a so-called
> 'pre-ITS', which maps 32-bit writes targeted at a separate window of
> size '4 << device_id_bits' onto writes to GITS_TRANSLATER with device
> ID taken from bits [device_id_bits + 1:2] of the window offset.
> Writes that target GITS_TRANSLATER directly are reported as originating
> from device ID #0.
>
> So add a workaround for this. Given that this breaks isolation, clear
> the IRQ_DOMAIN_FLAG_MSI_REMAP flag as well.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt |  4 ++

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm64/Kconfig                                                    |  8 +++
>  drivers/irqchip/irq-gic-v3-its.c                                      | 72 +++++++++++++++++++-
>  3 files changed, 82 insertions(+), 2 deletions(-)
