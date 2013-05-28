From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 28 May 2013 14:15:07 +0200
Subject: [PATCH] ARM: dt: Use the 'model' field for printing the hardware
 revision
In-Reply-To: <1369742670-16305-1-git-send-email-fabio.estevam@freescale.com>
References: <1369742670-16305-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130528121506.GL11166@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 09:04:30AM -0300, Fabio Estevam wrote:
> When booting a device tree kernel, we get the following output from 
> 'cat /proc/cpuinfo': 
> 
> $ cat /proc/cpuinfo 
> processor       : 0
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 531.66
> Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls 
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x2
> CPU part        : 0xc08
> CPU revision    : 5
> 
> Hardware        : Freescale i.MX51 (Device Tree Support)
> Revision        : 0000
> Serial          : 0000000000000000
> 
> The Hardware line does not really describe the hardware type, as it is reading
> the information from the dt 'machine' field.
> 
> In the dt case, read the 'model' field instead, so that we can have a better
> description output as follows:
> 
> Hardware        : Freescale i.MX51 Babbage Board
> 
> The hardware output string is unchanged for the non-dt kernel case.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/include/asm/mach/arch.h |  1 +
>  arch/arm/kernel/devtree.c        | 15 ++++++++-------
>  arch/arm/kernel/setup.c          |  7 ++++++-
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 308ad7d..113d4af 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -23,6 +23,7 @@ struct smp_operations;
>  struct machine_desc {
>  	unsigned int		nr;		/* architecture number	*/
>  	const char		*name;		/* architecture name	*/
> +	const char		*model;		/* architectute model */
s/architectute/architecture/

Is it really needed to add a new field here? Alternatively overwrite
name or do something like:

	if (this_is_a_device_tree_machine)
		seq_printf(m, "Hardware\t: %s\n", get_model_from_dt());
	else
		seq_printf(m, "Hardware\t: %s\n", machine_name);
		
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
