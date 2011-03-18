From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Mar 2011 09:34:39 +0100
Subject: [RFC PATCH 2/5] OMAP2+: add cpu id register to MAC address helper
In-Reply-To: <20110312225047.27728.1835.stgit@otae.warmcat.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
	<20110312225047.27728.1835.stgit@otae.warmcat.com>
Message-ID: <201103180934.39997.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011, Andy Green wrote:
> Introduce a generic helper function that can set a MAC address using
> data from the OMAP unqiue CPU ID register.
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
> 
>  arch/arm/mach-omap2/id.c              |   13 +++++++++++++
>  arch/arm/mach-omap2/include/mach/id.h |    1 +
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..fc69ec5 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -506,3 +506,16 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
>         else
>                 tap_prod_id = 0x0208;
>  }
> +
> +
> +void omap2_die_id_to_mac(u8 *mac, int length)
> +{
> +       struct omap_die_id odi;
> +
> +       omap_get_die_id(&odi);
> +       memcpy(mac, &odi.id_0, length);
> +
> +       /* mark it as not multicast and outside official 80211 MAC namespace */
> +
> +       mac[0] = (mac[0] & ~1) | 2;
> +}

This is a pretty clever trick, but it's not an official globally unique MAC
address, right? Maybe we can ask TI to officially request a MAC address range
for OMAP SoCs and document an official procedure to compute it.

	Arnd
