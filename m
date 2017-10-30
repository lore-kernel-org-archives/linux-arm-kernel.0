From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 14:07:55 +0000
Subject: [PATCH v3 03/12] arm: vdso: inline assembler operations to
 compiler.h
In-Reply-To: <20171027222518.57161-1-salyzyn@android.com>
References: <20171027222518.57161-1-salyzyn@android.com>
Message-ID: <20171030140755.clqmqnyyunodoors@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 27, 2017 at 03:25:10PM -0700, Mark Salyzyn wrote:
> Move compiler-specific code to a local compiler.h file. CONFIG_AEABI
> dependency check. System call fallback functions standardized into
> a DEFINE_FALLBACK macro. Accept that __arch_counter_get_cntvct()
> is the API for aarch64. 

This reads like a stream-of-conciousness, and it's difficult to figure
out which bits are intent and which bits are simply a summary of the
diff.

It would be really helpful to have a sentence or two at the start
explaining the high level idea, and why things must change.

For instance, it's really not clear to me what you mean by:

  Accept that __arch_counter_get_cntvct() is the API for aarch64.

... and whether using a #define for this is the best approach.

>From a scan of v4.14-rc7, there is no __arch_counter_get_cntvct() in the
tree, so I'm very confused here.

[...]

> +#define __arch_counter_get_cntvct() arch_counter_get_cntvct()

> @@ -127,7 +105,7 @@ static notrace u64 get_ns(const struct vdso_data *vd)
>  	u64 cycle_now;
>  	u64 nsec;
>  
> -	cycle_now = arch_counter_get_cntvct();
> +	cycle_now = __arch_counter_get_cntvct();

... and it's difficult to see what the point of these changes is.

Thanks,
Mark.
