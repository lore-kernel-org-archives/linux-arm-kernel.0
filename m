From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 26 Sep 2013 08:12:44 +0200
Subject: [PATCH 05/26] ARM: socfgpa: prepare for arch-wide .init_time
 callback
In-Reply-To: <1379526839-14798-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5243D05C.2010509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 07:53 PM, Sebastian Hesselbarth wrote:
> Current socfpga board init calls of_clk_init() from .machine_init. To
> allow consolidation of DT driven .time_init, move of_clock_init() to
> a temporary .time_init that will be removed when arch-wide callback is
> available.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Ping,

Dinh can you please comment on this and patch 21/26?

Thanks!

> ---
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   arch/arm/mach-socfpga/socfpga.c |    9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index bfce964..6df7bb9 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -15,6 +15,7 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   #include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
>   #include <linux/irqchip.h>
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
> @@ -90,6 +91,12 @@ static void __init socfpga_init_irq(void)
>   	socfpga_sysmgr_init();
>   }
>
> +static void __init socfpga_init_time(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}
> +
>   static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
>   {
>   	u32 temp;
> @@ -107,7 +114,6 @@ static void __init socfpga_cyclone5_init(void)
>   {
>   	l2x0_of_init(0, ~0UL);
>   	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -	of_clk_init(NULL);
>   	socfpga_init_clocks();
>   }
>
> @@ -120,6 +126,7 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
>   	.smp		= smp_ops(socfpga_smp_ops),
>   	.map_io		= socfpga_map_io,
>   	.init_irq	= socfpga_init_irq,
> +	.init_time	= socfpga_init_time,
>   	.init_machine	= socfpga_cyclone5_init,
>   	.restart	= socfpga_cyclone5_restart,
>   	.dt_compat	= altera_dt_match,
>
