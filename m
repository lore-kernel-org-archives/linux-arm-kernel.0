From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Sep 2010 15:08:35 +0800
Subject: [PATCH v2 2/3] ARM: pxa168/teton bga: added keypad support
In-Reply-To: <1284349896-14545-3-git-send-email-mark.brown314@gmail.com>
References: <1284349896-14545-1-git-send-email-mark.brown314@gmail.com>
	<1284349896-14545-3-git-send-email-mark.brown314@gmail.com>
Message-ID: <AANLkTikjCiwAA_u0YP53KGLLZNiz+-PuodieSpOmsHxT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 11:51 AM, Mark F. Brown <mark.brown314@gmail.com> wrote:
> Support for Matrix keypad ESC, ENTER, LEFT, and RIGHT
>
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>

Applied.

> ---
> ?arch/arm/mach-mmp/teton_bga.c | ? 24 ++++++++++++++++++++++++
> ?1 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
> index 49b746b..2966117 100644
> --- a/arch/arm/mach-mmp/teton_bga.c
> +++ b/arch/arm/mach-mmp/teton_bga.c
> @@ -16,6 +16,8 @@
> ?#include <linux/kernel.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <plat/pxa27x_keypad.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -30,6 +32,27 @@ static unsigned long teton_bga_pin_config[] __initdata = {
> ? ? ? ?/* UART1 */
> ? ? ? ?GPIO107_UART1_TXD,
> ? ? ? ?GPIO108_UART1_RXD,
> +
> + ? ? ? /* Keypad */
> + ? ? ? GPIO109_KP_MKIN1,
> + ? ? ? GPIO110_KP_MKIN0,
> + ? ? ? GPIO111_KP_MKOUT7,
> + ? ? ? GPIO112_KP_MKOUT6,
> +};
> +
> +static unsigned int teton_bga_matrix_key_map[] = {
> + ? ? ? KEY(0, 6, KEY_ESC),
> + ? ? ? KEY(0, 7, KEY_ENTER),
> + ? ? ? KEY(1, 6, KEY_LEFT),
> + ? ? ? KEY(1, 7, KEY_RIGHT),
> +};
> +
> +static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
> + ? ? ? .matrix_key_rows ? ? ? ?= 2,
> + ? ? ? .matrix_key_cols ? ? ? ?= 8,
> + ? ? ? .matrix_key_map ? ? ? ? = teton_bga_matrix_key_map,
> + ? ? ? .matrix_key_map_size ? ?= ARRAY_SIZE(teton_bga_matrix_key_map),
> + ? ? ? .debounce_interval ? ? ?= 30,
> ?};
>
> ?static void __init teton_bga_init(void)
> @@ -38,6 +61,7 @@ static void __init teton_bga_init(void)
>
> ? ? ? ?/* on-chip devices */
> ? ? ? ?pxa168_add_uart(1);
> + ? ? ? pxa168_add_keypad(&teton_bga_keypad_info);
> ?}
>
> ?MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
> --
> 1.7.0.4
>
>
