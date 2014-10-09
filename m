From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Oct 2014 23:43:15 +0200
Subject: arm64 non-SMP build error in latest upstream kernel
In-Reply-To: <20141009213427.GA27232@roeck-us.net>
References: <20141009213427.GA27232@roeck-us.net>
Message-ID: <40742923.rBODTfznrZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 14:34:27 Guenter Roeck wrote:
> Configuration: arm64 defconfig, -SMP
> 
> Error:
> 
> In file included from ./arch/arm64/include/asm/irq_work.h:4:0,
>                  from include/linux/irq_work.h:46,
>                  from include/linux/perf_event.h:49,
>                  from include/linux/hw_breakpoint.h:4,
>                  from arch/arm64/kernel/process.c:43:
> ./arch/arm64/include/asm/smp.h:24:3: error: #error "<asm/smp.h> included in non-SMP build"
>  # error "<asm/smp.h> included in non-SMP build"
>    ^
> ./arch/arm64/include/asm/smp.h:27:0: warning: "raw_smp_processor_id" redefined [enabled by default]
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
>  ^
> In file included from include/linux/sched.h:34:0,
>                  from ./arch/arm64/include/asm/compat.h:25,
>                  from ./arch/arm64/include/asm/stat.h:23,
>                  from include/linux/stat.h:5,
>                  from include/linux/compat.h:10,
>                  from arch/arm64/kernel/process.c:23:
> include/linux/smp.h:129:0: note: this is the location of the previous definition
>  #define raw_smp_processor_id()   0
> 
> This is just one example; the error is seen multiple times.
> 
> Let me know if you need me to bisect.

It must be caused by 3631073659d0a ("arm64: Tell irq work about self
IPI support"), which recently added the asm/irq_work.h file. 

Reverting that patch makes it build again.

	Arnd
