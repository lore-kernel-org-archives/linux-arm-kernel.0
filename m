From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sat, 10 Dec 2011 19:27:09 +0400
Subject: [PATCH v5 5/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
 <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
Message-ID: <4EE37A4D.8060204@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-12-2011 23:03, Pawel Moll wrote:

> If twd_base is not set, try to map the TWD registers from
> "arm,smp-twd" Device Tree node (compatible value as used in
> Highbank's DT).

> Signed-off-by: Pawel Moll<pawel.moll@arm.com>
> ---
>   arch/arm/plat-versatile/localtimer.c |   12 ++++++++++++
>   1 files changed, 12 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
> index 0fb3961..e3da322 100644
> --- a/arch/arm/plat-versatile/localtimer.c
> +++ b/arch/arm/plat-versatile/localtimer.c
[...]
> @@ -21,6 +23,16 @@
>    */
>   int __cpuinit local_timer_setup(struct clock_event_device *evt)
>   {
> +#if defined(CONFIG_OF)
> +	if (!twd_base) {
> +		struct device_node *np = of_find_compatible_node(NULL,
> +				NULL, "arm,smp-twd");
> +
> +		twd_base = of_iomap(np, 0);
> +		if (!twd_base)
> +			return -ENXIO;

    -ENOMEM.

WBR, Sergei
