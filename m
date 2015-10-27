From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 27 Oct 2015 01:41:53 +0100
Subject: [RFC PATCH] clocksource: dw_apb_timer_of: support timer-based
 delay
In-Reply-To: <1445328672-581-1-git-send-email-jszhang@marvell.com>
References: <1445328672-581-1-git-send-email-jszhang@marvell.com>
Message-ID: <562EC851.3080500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 10:11 AM, Jisheng Zhang wrote:
> Implement an ARM delay timer to be used for udelay(). This allows us to
> skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
> platforms. And after this patch, udelay() will be unaffected by CPU
> frequency changes.
>
> But, this driver is not only used on ARM platforms, so I dunno how to
> handle other platforms which don't have the register_current_timer_delay
> That's the reason I mark this patch as RFC.
>
> Any suggestions are appreciated.

hmm, may be a dt-binding makes sense...


> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/clocksource/dw_apb_timer_of.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index a19a3f6..09dbf9c 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -16,6 +16,7 @@
>    * You should have received a copy of the GNU General Public License
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
> +#include <linux/delay.h>
>   #include <linux/dw_apb_timer.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> @@ -130,6 +131,15 @@ static void __init init_sched_clock(void)
>   	sched_clock_register(read_sched_clock, 32, sched_rate);
>   }
>
> +static unsigned long dw_apb_delay_timer_read(void)
> +{
> +	return ~readl_relaxed(sched_io_base);
> +}
> +
> +static struct delay_timer dw_apb_delay_timer = {
> +	.read_current_timer = dw_apb_delay_timer_read,
> +};
> +
>   static int num_called;
>   static void __init dw_apb_timer_init(struct device_node *timer)
>   {
> @@ -142,6 +152,8 @@ static void __init dw_apb_timer_init(struct device_node *timer)
>   		pr_debug("%s: found clocksource timer\n", __func__);
>   		add_clocksource(timer);
>   		init_sched_clock();
> +		dw_apb_delay_timer.freq = sched_rate;
> +		register_current_timer_delay(&dw_apb_delay_timer);
>   		break;
>   	default:
>   		break;
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
