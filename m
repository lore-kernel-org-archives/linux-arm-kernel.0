From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 May 2011 17:18:21 -0500
Subject: [PATCH 15/19] clocksource: ARM sp804: obtain sp804 timer rate
	via clks
In-Reply-To: <E1QM1cq-0003ED-2X@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1cq-0003ED-2X@rmk-PC.arm.linux.org.uk>
Message-ID: <4DD1A2AD.4040004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2011 12:30 PM, Russell King - ARM Linux wrote:
> This allows platforms to specify the rate of the SP804 clocksource via
> the clk subsystem.  While ARM boards clock these at 1MHz, BCMRing also
> has SP804 timers but are clocked at different rates.
>
> Acked-by: Catalin Marinas<catalin.marinas@arm.com>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/common/timer-sp.c               |   39 +++++++++++++++++++++++++++++-
>   arch/arm/mach-integrator/integrator_cp.c |    7 +++++
>   arch/arm/mach-realview/core.c            |    9 ++++++-
>   arch/arm/mach-versatile/core.c           |    9 ++++++-
>   arch/arm/mach-vexpress/ct-ca9x4.c        |    8 ++++++
>   arch/arm/mach-vexpress/v2m.c             |    8 ++++++
>   6 files changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> index f6b9011..45a5eb8 100644
> --- a/arch/arm/common/timer-sp.c
> +++ b/arch/arm/common/timer-sp.c
> @@ -18,8 +18,10 @@
>    * along with this program; if not, write to the Free Software
>    * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>    */
> +#include<linux/clk.h>
>   #include<linux/clocksource.h>
>   #include<linux/clockchips.h>
> +#include<linux/err.h>
>   #include<linux/interrupt.h>
>   #include<linux/irq.h>
>   #include<linux/io.h>
> @@ -32,8 +34,43 @@
>   #define TIMER_FREQ_KHZ	(1000)
>   #define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
>
> +static long __init sp804_get_clock_rate(const char *name)
> +{
> +	struct clk *clk;
> +	long rate;
> +	int err;
> +
> +	clk = clk_get_sys("sp804", name);
> +	if (IS_ERR(clk)) {
> +		pr_err("sp804: %s clock not found: %d\n", name,
> +			(int)PTR_ERR(clk));
> +		return PTR_ERR(clk);
> +	}
> +
> +	err = clk_enable(clk);
> +	if (err) {
> +		pr_err("sp804: %s clock failed to enable: %d\n", name, err);
> +		clk_put(clk);
> +		return err;
> +	}
> +
> +	rate = clk_get_rate(clk);
> +	if (rate<  0) {
> +		pr_err("sp804: %s clock failed to get rate: %ld\n", name, err);

err should be rate.

Rob
