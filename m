From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:30:31 +0200
Subject: [PATCH 3/6] ARM: ux500: Enable support for RPMB and Reliable
 Write for eMMC
In-Reply-To: <1369314830-3727-4-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <1369314830-3727-4-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbcQNAUNYnHwLRm2f+LdRmQZY=U9PBk8CPPxONmQFtXmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 3:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> By adding MMC_CAP_CMD23 for the eMMC devices, we can support RPMB
> and Reliable Write. Additionally it will mean CMD12 will not be sent
> to end a successful data transfer.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to ux500-core, thanks,
but Houston, we have a problem:

I wanted to enable this also for the device tree boot
path. But currently there are no bindings to state in the
DT boot that CMD23 is supported.

Could you create another patch that:

- Add bindings to Documentation/devicetree/bindings/mmc/mmc.txt
  for indicating that a host controller supports CMD23
- Patch the ux500 DTS files to enable it.
- Write a patch to mmci.c to augment
  mmci_dt_populate_generic_pdata() to read the binding and
  augment the caps from the device tree.

There is also a complicated refactoring that need to happen any
of these days:

- Augment the MMC core and all drivers using DT boots to
  parse any standard caps from the device tree insteaf of
  putting code like mmci_dt_populate_generic_pdata() into
  every driver.

Yours,
Linus Walleij
