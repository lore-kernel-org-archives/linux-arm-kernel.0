From: rabin@rab.in (Rabin Vincent)
Date: Fri, 3 Dec 2010 09:42:21 +0530
Subject: [PATCH] ux500: minor revision to the eMMC/SD config
In-Reply-To: <1291327501-8047-1-git-send-email-linus.walleij@stericsson.com>
References: <1291327501-8047-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTinZXGfr=PLMgC4KorLo1d6+H-hG+Y1ZKVEvF8ty@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 3, 2010 at 3:35 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This properly adds the missing external sdi0 interface and a small

I don't see this patch adding any missing interfaces.

> fixup for the v1(.0) ASIC.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ?arch/arm/mach-ux500/board-mop500-sdi.c | ? 11 ++++++++++-
> ?1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
> index be5e8cc..4b99667 100644
> --- a/arch/arm/mach-ux500/board-mop500-sdi.c
> +++ b/arch/arm/mach-ux500/board-mop500-sdi.c
> @@ -137,12 +137,21 @@ static struct mmci_platform_data mop500_sdi4_data = {
> ? ? ? ?.gpio_wp ? ? ? ?= -1,
> ?};
>
> -void mop500_sdi_init(void)
> +void __init mop500_sdi_init(void)
> ?{
> ? ? ? ?nmk_config_pins(mop500_sdi_pins, ARRAY_SIZE(mop500_sdi_pins));
>
> + ? ? ? /*
> + ? ? ? ?* sdi0 will finally be added when the TC35892 initializes and calls
> + ? ? ? ?* mop500_sdi_tc35892_init() above.
> + ? ? ? ?*/
> +
> + ? ? ? /* PoP:ed eMMC */
> ? ? ? ?if (!cpu_is_u8500ed()) {
> ? ? ? ? ? ? ? ?nmk_config_pins(mop500_sdi2_pins, ARRAY_SIZE(mop500_sdi2_pins));
> + ? ? ? ? ? ? ? /* POP eMMC on v1.0 has problems with high speed */
> + ? ? ? ? ? ? ? if (!cpu_is_u8500v10())
> + ? ? ? ? ? ? ? ? ? ? ? mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
> ? ? ? ? ? ? ? ?db8500_add_sdi2(&mop500_sdi2_data);
> ? ? ? ?}
>
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
