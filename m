From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Nov 2014 16:10:14 +0000
Subject: [PATCH v4] clocksource: arch_timer: Fix code to use physical
 timers when requested
In-Reply-To: <1412753937-29343-1-git-send-email-sonnyrao@chromium.org>
References: <1412753937-29343-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <20141120161013.GB5447@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 08:38:57AM +0100, Sonny Rao wrote:
> This is a bug fix for using physical arch timers when
> the arch_timer_use_virtual boolean is false.  It restores the
> arch_counter_get_cntpct() function after removal in
> 
> 0d651e4e "clocksource: arch_timer: use virtual counters"
> 
> We need this on certain ARMv7 systems which are architected like this:
> 
> * The firmware doesn't know and doesn't care about hypervisor mode and
>   we don't want to add the complexity of hypervisor there.
> 
> * The firmware isn't involved in SMP bringup or resume.
> 
> * The ARCH timer come up with an uninitialized offset between the
>   virtual and physical counters.  Each core gets a different random
>   offset.
> 
> * The device boots in "Secure SVC" mode.
> 
> * Nothing has touched the reset value of CNTHCTL.PL1PCEN or
>   CNTHCTL.PL1PCTEN (both default to 1 at reset)
> 
> One example of such as system is RK3288 where it is much simpler to
> use the physical counter since there's nobody managing the offset and
> each time a core goes down and comes back up it will get reinitialized
> to some other random value.
> 
> Fixes: 0d651e4e65e9 ("clocksource: arch_timer: use virtual counters")
> Cc: stable at vger.kernel.org
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Acked-by: Olof Johansson <olof@lixom.net>
[...]
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -135,6 +135,16 @@ static inline void arch_timer_evtstrm_enable(int divider)
>  #endif
>  }
>  
> +static inline u64 arch_counter_get_cntpct(void)
> +{
> +	u64 cval;
> +
> +	isb();
> +	asm volatile("mrs %0, cntpct_el0" : "=r" (cval));
> +
> +	return cval;
> +}

Sorry but I have to NAK the arm64 changes here. If the firmware is
broken and does not initialise CNTVOFF properly, please fix it (at least
on ARMv8 hardware). Also, on arm64 the vdso gettimeofday()
implementation relies on using the virtual counter, so correct
initialisation of CNTVOFF is essential.

-- 
Catalin
