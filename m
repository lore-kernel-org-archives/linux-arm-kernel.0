From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 29 Jan 2010 11:52:42 +0900
Subject: [PATCH 06/06] sh-sci: Preliminary SuperH Mobile ARM support
In-Reply-To: <20100128124131.8982.21545.sendpatchset@rxone.opensource.se>
References: <20100128124028.8982.16123.sendpatchset@rxone.opensource.se>
	<20100128124131.8982.21545.sendpatchset@rxone.opensource.se>
Message-ID: <20100129025242.GC7396@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 09:41:31PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add preliminary SuperH Mobile ARM support to the sh-sci
> driver. Enough to get serial console working. Needs more
> work. Is really disconnected from the ARM support code
> but is included here for completeness.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/serial/Kconfig  |    2 +-
>  drivers/serial/sh-sci.h |   23 ++++++++++++++++++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> --- 0001/drivers/serial/Kconfig
> +++ work/drivers/serial/Kconfig	2010-01-21 19:55:26.000000000 +0900
> @@ -996,7 +996,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
>  
>  config SERIAL_SH_SCI
>  	tristate "SuperH SCI(F) serial port support"
> -	depends on HAVE_CLK && (SUPERH || H8300)
> +	depends on HAVE_CLK && (SUPERH || H8300 || ARCH_SHMOBILE)
>  	select SERIAL_CORE
>  
>  config SERIAL_SH_SCI_NR_UARTS
> --- 0001/drivers/serial/sh-sci.h
> +++ work/drivers/serial/sh-sci.h	2010-01-21 19:57:10.000000000 +0900
> @@ -174,6 +174,10 @@
>  # define SCSPTR3 0xffc60020		/* 16 bit SCIF */
>  # define SCIF_ORER 0x0001		/* Overrun error bit */
>  # define SCSCR_INIT(port)	0x38	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
> +#elif defined(CONFIG_ARCH_SHMOBILE)
> +# define SCSCR_INIT(port)	0x0030
> +# define SCIF_ONLY
> +# define SCIF_ORER		0x0200
>  #else
>  # error CPU subtype not defined
>  #endif
>        defined(CONFIG_CPU_SUBTYPE_SH7724)

SCIF_ONLY should be killed off, nothing is checking for it these days. I
thought they were all gone already, but it looks like SH7757 snuck one
back in, too..
