From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 30 Jun 2015 22:44:40 +0200
Subject: [PATCH v2] ARM: tegra: paz00: use con_id's to refer GPIO's in
 gpiod_lookup table
In-Reply-To: <1435673759-11996-1-git-send-email-digetx@gmail.com>
References: <1435673759-11996-1-git-send-email-digetx@gmail.com>
Message-ID: <3628722.nhXkFk5ghW@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag 30 Juni 2015, 17:15:50 schrieb Dmitry Osipenko:
> Commit 72daceb9a10a ("net: rfkill: gpio: Add default GPIO driver mappings
> for ACPI") removed possibility to request GPIO by table index for non-ACPI
> platforms without changing it users. As result "shutdown" GPIO request
> will fail if request for "reset" GPIO succeeded or "reset" will be
> requested instead of "shutdown" if "reset" wasn't defined. Fix it by
> making gpiod_lookup_table use con_id's instead of indexes.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: 72daceb (net: rfkill: gpio: Add default GPIO driver mappings for
> ACPI) Cc: <stable@vger.kernel.org> # v3.19+
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

beside a small typo in the commit message (is users -> its users) this looks 
good now. I can confirm that the gpio's are all available now.

Reviewed-by: Marc Dietrich <marvin24@gmx.de>

> ---
> 
> v2: s/GPIO_LOOKUP_IDX/GPIO_LOOKUP/, otherwise "shutdown" GPIO won't be
> requested
> 
>  arch/arm/mach-tegra/board-paz00.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-paz00.c
> b/arch/arm/mach-tegra/board-paz00.c index fbe74c6..49d1110 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -39,8 +39,8 @@ static struct platform_device wifi_rfkill_device = {
>  static struct gpiod_lookup_table wifi_gpio_lookup = {
>  	.dev_id = "rfkill_gpio",
>  	.table = {
> -		GPIO_LOOKUP_IDX("tegra-gpio", 25, NULL, 0, 0),
> -		GPIO_LOOKUP_IDX("tegra-gpio", 85, NULL, 1, 0),
> +		GPIO_LOOKUP("tegra-gpio", 25, "reset", 0),
> +		GPIO_LOOKUP("tegra-gpio", 85, "shutdown", 0),
>  		{ },
>  	},
>  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150630/47b9577a/attachment.sig>
