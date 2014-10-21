From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Tue, 21 Oct 2014 09:24:45 +0200
Subject: [PATCH v3 0/2] ARM: EXYNOS: Call regulator suspend prepare/finish
In-Reply-To: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <54460A3D.6010101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2014 23:05, Javier Martinez Canillas wrote:
> Hello,
> 
> This series add support for Exynos platforms to prepare regulators for
> system suspend. The regulator core has a set of helpers functions to be
> used when the system is entering and leaving from a suspend state but
> currently there is only one user in mainline.
> 
> This user is drivers/mfd/sec-core.c but it calls regulator_suspend_prepare()
> from within the driver power-management suspend function. This does not
> seems to be correct since the regulator suspend prepare function affects all
> regulators in the system and not only the ones managed by this device.
> 
> So patch #1 in this series revert the commit that introduced that change and
> patch #2 calls the regulator framework suspend/finish functions from the
> Exynos platform power-management code. The first patch should be queued through
> the mfd tree and the second through the linux-samsung tree.
> 
> Changes since v2:
>  - Check for regulator_suspend_finish() return value for an error.
>    Suggested by Doug Anderson.
> 
> Changes since v1:
>  - Remove the call to regulator_suspend_prepare() from drivers/mfd/sec-core.c
>    as suggested by Doug Anderson.
>  - Call regulator_suspend_prepare() before s3c_pm_check_prepare() as suggested
>    by Doug Anderson.
>  - Added Lee Jones to cc list since there is a change for the mfd framework.
> 
> Javier Martinez Canillas (2):
>   Revert "mfd: sec-core: Prepare regulators for suspend state to reduce
>     power-consumption"
>   ARM: EXYNOS: Call regulator core suspend prepare and finish functions
> 
>  arch/arm/mach-exynos/suspend.c | 23 +++++++++++++++++++++++
>  drivers/mfd/Kconfig            |  1 -
>  drivers/mfd/sec-core.c         | 10 ----------
>  3 files changed, 23 insertions(+), 11 deletions(-)

Patchset tested on Trats2 board (Exynos4412 with max77686 PMIC, modified
DTS to disable buck[134] during suspend to RAM).

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
