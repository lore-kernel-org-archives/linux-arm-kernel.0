From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Mar 2013 18:03:28 +0000
Subject: [PATCH v2 1/2] ARM: vexpress: Enable regulator framework when
 MMCI is in use
In-Reply-To: <1363629655-28917-1-git-send-email-pawel.moll@arm.com>
References: <20130315181614.GY4977@n2100.arm.linux.org.uk>
 <1363629655-28917-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130318180328.GJ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 06:00:55PM +0000, Pawel Moll wrote:
> The MMCI driver, when used with a Device Tree described device, relies
> on the "vmmc" voltage regulator supply to set the OCR register voltage bits,
> using MMC core's mmc_regulator_get_supply() function.
> 
> Without the regulator framework present there are no valid operating
> voltages reported and the device initialisation fails:
> 
> mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 41,42 (pio)
> mmc0: host doesn't support card's voltages
> mmc0: error -22 whilst initialising MMC card

Okay, this isn't going to work, because this means it's broken on a whole
load of platforms.  What it means is that this commit:

commit 599c1d5c750ddf528c7c6d3cdc466708f0502e66
Author: Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon Jan 7 16:22:50 2013 +0100

    ARM: 7620/1: mmc: mmci: Convert to use mmc_regulator_get_supply
    
    By using the mmc_regulator_get_supply API we are able to do some
    cleanups of the regulator code. Additionally let the regulator
    API handle the error printing.
    
    Cc: Chris Ball <cjb@laptop.org>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

is actually wrong and probably needs reverting.
