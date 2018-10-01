From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 1 Oct 2018 20:15:28 +0200 (CEST)
Subject: RESEND [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
In-Reply-To: <20181001175845.168430-12-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <20181001175845.168430-12-salyzyn@android.com>
Message-ID: <alpine.DEB.2.21.1810012009010.32062@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Oct 2018, Mark Salyzyn wrote:
>  
> +static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
> +{
> +	u32 seq, mult, shift;
> +	u64 nsec, cycle_last;
> +	vdso_wtm_clock_nsec_t wtm_nsec;
> +
> +	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
> +	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
> +	ts->tv_nsec = nsec;
> +
> +	return 0;
> +}
> +

Instead of adding yet another copy of the same code you might want to look
at the rework I did for the x86 vdso in order to support CLOCK_TAI w/o
running into the issue of the clock switch case being compiled into a jump
table and then the compile asking for retpoline.

  http://lkml.kernel.org/r/20180917124533.329334911 at linutronix.de

Thanks,

	tglx
