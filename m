From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Mon, 29 Feb 2016 21:28:28 -0800
Subject: [PATCH] target/cxgbit: add INET dependency
In-Reply-To: <1456744504-3011977-1-git-send-email-arnd@arndb.de>
References: <1456744504-3011977-1-git-send-email-arnd@arndb.de>
Message-ID: <1456810108.19657.187.camel@haakon3.risingtidesystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, 2016-02-29 at 12:14 +0100, Arnd Bergmann wrote:
> The newly added cxgbit driver directly calls functions of the
> IPv4 network stack, which fails if that is disabled:
> 
> ERROR: "ip_route_output_flow" [drivers/target/iscsi/cxgbit/cxgbit.ko] undefined!
> ERROR: "__ip_dev_find" [drivers/target/iscsi/cxgbit/cxgbit.ko] undefined!
> 
> This adds a Kconfig dependency to ensure we can't enable this
> driver without the complete network stack it needs.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b7ca3321e114 ("cxgbit: add Kconfig and Makefile")
> ---
>  drivers/target/iscsi/cxgbit/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/target/iscsi/cxgbit/Kconfig b/drivers/target/iscsi/cxgbit/Kconfig
> index cf335b4dbb4e..ce6f5cca315d 100644
> --- a/drivers/target/iscsi/cxgbit/Kconfig
> +++ b/drivers/target/iscsi/cxgbit/Kconfig
> @@ -1,6 +1,7 @@
>  config ISCSI_TARGET_CXGB4
>  	tristate "Chelsio iSCSI target offload driver"
>  	depends on ISCSI_TARGET && CHELSIO_T4
> +	depends on INET
>  	select CHELSIO_T4_UWIRE
>  	---help---
>  	To compile this driver as module, choose M here: the module

Odd, ISCSI_TARGET already depends on NET, but I guess that's not enough
for cxgbit..  ;)

Varun, please pick this up and fold it into the original commit, with
proper credit to Arnd for finding this in the commit log.
