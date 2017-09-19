From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Sep 2017 16:43:18 +0200
Subject: [PATCH 1/2] bus: mbus: fix window size calculation for 4GB windows
In-Reply-To: <20170828152517.24506-2-jlu@pengutronix.de> (Jan Luebbe's message
 of "Mon, 28 Aug 2017 17:25:16 +0200")
References: <20170828152517.24506-1-jlu@pengutronix.de>
 <20170828152517.24506-2-jlu@pengutronix.de>
Message-ID: <87wp4urbp5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,
 
 On lun., ao?t 28 2017, Jan Luebbe <jlu@pengutronix.de> wrote:

> At least the Armada XP SoC supports 4GB on a single DRAM window. Because
> the size register values contain the actual size - 1, the MSB is set in
> that case. For example, the SDRAM window's control register's value is
> 0xffffffe1 for 4GB (bits 31 to 24 contain the size).
>
> The MBUS driver reads back each window's size from registers and
> calculates the actual size as (control_reg | ~DDR_SIZE_MASK) + 1, which
> overflows for 32 bit values, resulting in other miscalculations further
> on (a bad RAM window for the CESA crypto engine calculated by
> mvebu_mbus_setup_cpu_target_nooverlap() in my case).
>
> This patch changes the type in 'struct mbus_dram_window' from u32 to
> u64, which allows us to keep using the same register calculation code in
> most MBUS-using drivers (which calculate ->size - 1 again).
>

Your patch looks good, but as it is a fix we should also apply it on
stable, could you provide the commit to fix?

Thanks,

Gregory

> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  drivers/bus/mvebu-mbus.c | 2 +-
>  include/linux/mbus.h     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index c7f396903184..70db4d5638a6 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -720,7 +720,7 @@ mvebu_mbus_default_setup_cpu_target(struct mvebu_mbus_state *mbus)
>  			if (mbus->hw_io_coherency)
>  				w->mbus_attr |= ATTR_HW_COHERENCY;
>  			w->base = base & DDR_BASE_CS_LOW_MASK;
> -			w->size = (size | ~DDR_SIZE_MASK) + 1;
> +			w->size = (u64)(size | ~DDR_SIZE_MASK) + 1;
>  		}
>  	}
>  	mvebu_mbus_dram_info.num_cs = cs;
> diff --git a/include/linux/mbus.h b/include/linux/mbus.h
> index 0d3f14fd2621..4773145246ed 100644
> --- a/include/linux/mbus.h
> +++ b/include/linux/mbus.h
> @@ -31,8 +31,8 @@ struct mbus_dram_target_info
>  	struct mbus_dram_window {
>  		u8	cs_index;
>  		u8	mbus_attr;
> -		u32	base;
> -		u32	size;
> +		u64	base;
> +		u64	size;
>  	} cs[4];
>  };
>  
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
