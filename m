From: will.deacon@arm.com (Will Deacon)
Date: Sat, 18 Dec 2010 17:44:47 +0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <20101218171039.GK9937@n2100.arm.linux.org.uk>
References: <007401cb962d$d53d2500$7fb76f00$@deacon@arm.com>
	<20101207171810.GA25839@n2100.arm.linux.org.uk>
	<007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
	<20101218171039.GK9937@n2100.arm.linux.org.uk>
Message-ID: <1292694287.4266.15.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for looking into this.

On Sat, 2010-12-18 at 17:10 +0000, Russell King - ARM Linux wrote:
> Boot time bringup:
> 
[...]

> CPU2 and CPU3 have very similar boot timings, so I'm pretty happy that
> this timing is reliable.
> 
Looks sane.

> Hotplug bringup:
> 
> Booting: 1000                   -> 0ns          0ns             (1us per print)
> Restarting: 3976375             ->              3.976375ms
> cross call: 3976625             -> 3.976625ms
> Up: 4003125                     ->              4.003125ms
> CPU1: Booted secondary processor
> secondary_init: 4022583         ->              4.022583ms
> writing release: 4040750        ->              4.04075ms
> release done: 4051083           ->              4.051083ms
> released: 46509000              -> 4.6509ms
> Boot returned: 51745708         -> 5.1745708ms
> sync'd: 51745875                ->              5.1745875ms
> CPU1: Unknown IPI message 0x1
> Switched to NOHz mode on CPU #1
> Online: 281251041               ->              281.251041ms
> 
> So, it appears to take 4ms to get from just before the call to
> boot_secondary() in __cpu_up() to writing pen_release.
> 
> The secondary CPU appears to run from being woken up to writing the
> pen release in about 40us - and then spends about 1ms spinning on
> its lock waiting for the requesting CPU to catch up.
> 
> This can be repeated every time without exception when you bring a
> CPU back online.
> 
Hmm, this sounds needlessly expensive.

> Looking at that 500us, it seems to be taken up by 'spin_unlock()' in
> boot_secondary:
> 
> 00000000 <boot_secondary>:

[...]

> --spin_unlock--
>   bc:   f57ff05f        dmb     sy
>   c0:   e3a02000        mov     r2, #0  ; 0x0
>   c4:   e59f3020        ldr     r3, [pc, #32]   ; ec <boot_secondary+0xec>
>   c8:   e5832000        str     r2, [r3]
>   cc:   f57ff04f        dsb     sy
>   d0:   e320f004        sev
> ----

One thing that might be worth trying is changing spin_unlock to use
strex [alongside a dummy ldrex]. There could be some QoS logic at L2
which favours exclusive accesses, meaning that the unlock is starved by
the lock. I don't have access to a board at the moment, so this is
purely speculation!

> The CPU being brought online is doing this:
> 
> 00000034 <_raw_spin_lock>:
>   34:   e1a0c00d        mov     ip, sp
>   38:   e92dd800        push    {fp, ip, lr, pc}
>   3c:   e24cb004        sub     fp, ip, #4      ; 0x4
>   40:   e3a03001        mov     r3, #1  ; 0x1
>   44:   e1902f9f        ldrex   r2, [r0]
>   48:   e3320000        teq     r2, #0  ; 0x0
>   4c:   1320f002        wfene
>   50:   01802f93        strexeq r2, r3, [r0]
>   54:   03320000        teqeq   r2, #0  ; 0x0
>   58:   1afffff9        bne     44 <_raw_spin_lock+0x10>
>   5c:   f57ff05f        dmb     sy
>   60:   e89da800        ldm     sp, {fp, sp, pc}
> 
> as it's waiting for the lock to be released.  So... what could be causing
> the above code in boot_secondary()/__cpu_up() to take 500us when the
> system's running?  The dmb, dsb, or sev?  Or the SCU trying to sort out
> the str to release the lock?

Another experiment would be to remove the wfe/sev instructions to see if
they're eating cycles. I think a WFE on the A9 disables a bunch of
clocks, so that could be taking time to do.

<shameless plug>
You could try using perf to identify the most expensive instructions in
the functions above (assuming interrupts are enabled).
</shameless plug>

Cheers,

Will
