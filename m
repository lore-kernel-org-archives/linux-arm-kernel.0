From: katsuki.uwatoko@toshiba.co.jp (katsuki.uwatoko at toshiba.co.jp)
Date: Thu, 10 Jan 2013 03:06:56 +0000
Subject: [PATCH] ARM: sched_clock: fix the timing of reading current
 clock cycles in cyc_to_sched_clock.
In-Reply-To: <A6CD60A5D6958Ckatsuki.uwatoko@toshiba.co.jp>
References: <A6CD60A5D6958Ckatsuki.uwatoko@toshiba.co.jp>
Message-ID: <F3B6523425E7914AA6214ED358D820AF25D74921@TGXML316.toshiba.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I sent the attached patch six months ago and I did not get any responses, 
but still I think that this is a bug.

If any mistakes, please let me know.

Regards,
-- 
UWATOKO Katsuki

> From:     UWATOKO Katsuki <katsuki.uwatoko@toshiba.co.jp>
> To:       linux-arm-kernel at lists.infradead.org
> Cc:       linux at arm.linux.org.uk
> Subject:  [PATCH] ARM: sched_clock: fix the timing of reading current clock cycles in cyc_to_sched_clock.
> Date:     Fri, 13 Jul 2012 12:16:04 +0900
> 
> 
> The current clock cycle (cyc) must be read after epoc_cyc and epoch_ns
> are fixed.  The calculation result gets invalid when epoch_cyc is
> updated after cyc is determined, because the result of (cyc -
> epoch_cyc) is unsigned int.
> 
> Signed-off-by: UWATOKO Katsuki <katsuki.uwatoko@toshiba.co.jp>
> ---
>  arch/arm/kernel/sched_clock.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 27d186a..ab08671 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -44,7 +44,7 @@ static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>  	return (cyc * mult) >> shift;
>  }
>  
> -static unsigned long long cyc_to_sched_clock(u32 cyc, u32 mask)
> +static unsigned long long cyc_to_sched_clock(u32 (*read)(void), u32 mask)
>  {
>  	u64 epoch_ns;
>  	u32 epoch_cyc;
> @@ -63,7 +63,8 @@ static unsigned long long cyc_to_sched_clock(u32 cyc, u32 mask)
>  		smp_rmb();
>  	} while (epoch_cyc != cd.epoch_cyc_copy);
>  
> -	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, cd.mult, cd.shift);
> +	return epoch_ns + cyc_to_ns((read() - epoch_cyc) & mask, cd.mult,
> +				    cd.shift);
>  }
>  
>  /*
> @@ -150,8 +151,7 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
>  
>  unsigned long long notrace sched_clock(void)
>  {
> -	u32 cyc = read_sched_clock();
> -	return cyc_to_sched_clock(cyc, sched_clock_mask);
> +	return cyc_to_sched_clock(read_sched_clock, sched_clock_mask);
>  }
>  
>  void __init sched_clock_postinit(void)
> -- 
> 1.7.4.1
> 
