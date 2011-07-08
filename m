From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 9 Jul 2011 00:15:30 +0300
Subject: Ooops with 2.6.39.2 on pxa270
In-Reply-To: <20110705101918.GU8286@n2100.arm.linux.org.uk>
References: <201107042158.05767.anarsoul@gmail.com>
	<20110705101918.GU8286@n2100.arm.linux.org.uk>
Message-ID: <201107090015.30583.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011 13:19:18 Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 09:58:05PM +0300, Vasily Khoruzhick wrote:
> > Hi there, I'm getting following oops on my device (Zipit Z2 with PXA270)
> > with 2.6.39.2. And I have no idea what can be wrong :( Ooops is not 100%
> > reproducible, it happens in 50% of cases.
> 
> Short answer is I can't say for certain.  My compiler produces the
> following for get_task_pid:
> 
> 00000248 <get_task_pid>:
>  248:   e1a0c00d        mov     ip, sp
>  24c:   e92dd800        push    {fp, ip, lr, pc}
>  250:   e24cb004        sub     fp, ip, #4      ; 0x4
>  254:   e3510000        cmp     r1, #0  ; 0x0
>  258:   159000e8        ldrne   r0, [r0, #232]
>  25c:   e3a0300c        mov     r3, #12 ; 0xc
>  260:   e0230391        mla     r3, r1, r3, r0
>  264:   e5930104        ldr     r0, [r3, #260]
>  268:   e3500000        cmp     r0, #0  ; 0x0
> 
>  26c:   0a000006        beq     28c <get_task_pid+0x44>
>  270:   e10f2000        mrs     r2, CPSR
>  274:   e3823080        orr     r3, r2, #128    ; 0x80
>  278:   e121f003        msr     CPSR_c, r3
>  27c:   e5903000        ldr     r3, [r0]		 <== faulting insn
> 
>  280:   e2833001        add     r3, r3, #1      ; 0x1
>  284:   e5803000        str     r3, [r0]
>  288:   e121f002        msr     CPSR_c, r2
>  28c:   e89da800        ldm     sp, {fp, sp, pc}
> 
> which is close enough to your code line (except my r3 is your r1).
> 
> We know that the passed r1 value was PIDTYPE_PID, wihch means the ldrne
> wasn't executed.
> 
> My first guess is that something has overwritten task->pids - either
> memory corruption, memory wrap-around due to the kernel thinking it has
> more memory than physically fitted, or a buggy driver stamping over
> memory it shouldn't.

Thanks for hint. Looks like problem is libertas + pxa2xx_spi, pxa2xx_spi 
corrupts memory when it uses DMA for 'null' transfers (libertas calls it 
'dummy writes'). Everything is OK with PIO, still investigating problem...

Regards
Vasily
