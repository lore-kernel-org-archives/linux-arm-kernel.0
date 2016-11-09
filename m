From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Nov 2016 15:47:27 +0000
Subject: [PATCH] mfd: qcom-pm8xxx: Clean up PM8XXX namespace
In-Reply-To: <1477487453-15801-1-git-send-email-linus.walleij@linaro.org>
References: <1477487453-15801-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161109154727.GG13127@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Oct 2016, Linus Walleij wrote:

> The Kconfig and file naming for the PM8xxx driver is totally
> confusing:
> 
> - Kconfig options MFD_PM8XXX and MFD_PM8921_CORE, some in-kernel
>   users depending on or selecting either at random.
> - A driver file named pm8921-core.c even if it is indeed
>   used by the whole PM8xxx family of chips.
> - An irqchip named pm8xxx since it was (I guess) realized that
>   the driver was generic for all pm8xxx PMICs.
> 
> As I may want to add support for PM8901 this is starting to get
> really messy. Fix this situation by:
> 
> - Remove the MFD_PM8921_CORE symbol and rely solely on MFD_PM8XXX
>   and convert all users, including LEDs Kconfig and ARM defconfigs
>   for qcom and multi_v7 to use that single symbol.
> - Renaming the driver to qcom-pm8xxx.c to fit along the two
>   other qcom* prefixed drivers.
> - Rename functions withing the driver from 8921 to 8xxx to
>   indicate it is generic.
> - Just drop the =m config from the pxa_defconfig, I have no clue
>   why it is even there, it is not a Qualcomm platform. (Possibly
>   older Kconfig noise from saveconfig.)
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I do NOT think it is a good idea to try to split this commit up,
> I rather prefer that Lee simply merge it into MFD.
> 
> The reason is that files like qcom_defconfig already contain both
> the right symbols, but the MFD_PM8921_CORE symbol cannot be removed
> until this rename has happened, whereas multi_v7_defconfig needs
> it added etc, and this is just a clean nice cut.
> 
> Jacek, ARM SoC person: please ACK this patch to get merged into
> MFD.
> ---
>  arch/arm/configs/multi_v7_defconfig          |  2 +-
>  arch/arm/configs/pxa_defconfig               |  1 -
>  arch/arm/configs/qcom_defconfig              |  1 -
>  drivers/leds/Kconfig                         |  2 +-
>  drivers/mfd/Kconfig                          | 14 ++++------
>  drivers/mfd/Makefile                         |  2 +-
>  drivers/mfd/{pm8921-core.c => qcom-pm8xxx.c} | 42 ++++++++++++++--------------

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  7 files changed, 29 insertions(+), 35 deletions(-)
>  rename drivers/mfd/{pm8921-core.c => qcom-pm8xxx.c} (92%)

How many more Acks do we need?

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
