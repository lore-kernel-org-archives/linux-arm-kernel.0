From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 17:10:39 +0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
References: <007401cb962d$d53d2500$7fb76f00$@deacon@arm.com>
	<20101207171810.GA25839@n2100.arm.linux.org.uk>
	<007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
Message-ID: <20101218171039.GK9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 05:47:00PM -0000, Will Deacon wrote:
> Hi Russell,
> > What if we fixed the cpu_reset functions for v6 and v7, and when a CPU
> > is taken offline, we actually go through a proper shutdown of that CPU
> > and call the reset vector, re-entering the boot loader?
> 
> This will certainly solve our problem, but people might complain that it's
> too heavyweight :)

Well, I've taken some measurements from the CPU boot, and there appears
to be some interesting behaviour here:

Boot time bringup:

				   boot CPU	CPU1
Booting: 1084			-> 0ns		0ns	(about 1us per print)
cross call: 21750		-> 21.75us
Up: 267167			->		267.167us
CPU1: Booted secondary processor
secondary_init: 297834		->		297.834us
writing release: 310917		->		310.917us
release done: 320334		->		320.334us
released: 327750		-> 327.75us
Boot returned: 342917		-> 342.917us
sync'd: 343167			->		343.167us
CPU1: Unknown IPI message 0x1
Online: 218416334		->		218.416334ms

This looks reasonable - 300us taken to get from requesting the CPU to boot
in __cpu_up() to the CPU marking itself online.

The 218ms will be down to calibrate_delay().

CPU2 and CPU3 have very similar boot timings, so I'm pretty happy that
this timing is reliable.

Hotplug bringup:

Booting: 1000			-> 0ns		0ns		(1us per print)
Restarting: 3976375		->		3.976375ms
cross call: 3976625		-> 3.976625ms
Up: 4003125			->		4.003125ms
CPU1: Booted secondary processor
secondary_init: 4022583		->		4.022583ms
writing release: 4040750	->		4.04075ms
release done: 4051083		->		4.051083ms
released: 46509000		-> 4.6509ms
Boot returned: 51745708		-> 5.1745708ms
sync'd: 51745875		->		5.1745875ms
CPU1: Unknown IPI message 0x1
Switched to NOHz mode on CPU #1
Online: 281251041		->		281.251041ms

So, it appears to take 4ms to get from just before the call to
boot_secondary() in __cpu_up() to writing pen_release.

The secondary CPU appears to run from being woken up to writing the
pen release in about 40us - and then spends about 1ms spinning on
its lock waiting for the requesting CPU to catch up.

This can be repeated every time without exception when you bring a
CPU back online.

Looking at that 500us, it seems to be taken up by 'spin_unlock()' in
boot_secondary:

00000000 <boot_secondary>:
  a0:   ebfffffe        bl      0 <sched_clock>
  a4:   e59f3044        ldr     r3, [pc, #68]   ; f0 <boot_secondary+0xf0>
  a8:   e893000c        ldm     r3, {r2, r3}
  ac:   e0502002        subs    r2, r0, r2
  b0:   e0c13003        sbc     r3, r1, r3
  b4:   e59f004c        ldr     r0, [pc, #76]   ; 108 <boot_secondary+0x108>
  b8:   ebfffffe        bl      0 <printk>	; "released: %llu\n"
--spin_unlock--
  bc:   f57ff05f        dmb     sy
  c0:   e3a02000        mov     r2, #0  ; 0x0
  c4:   e59f3020        ldr     r3, [pc, #32]   ; ec <boot_secondary+0xec>
  c8:   e5832000        str     r2, [r3]
  cc:   f57ff04f        dsb     sy
  d0:   e320f004        sev
----
  d4:   e59f3018        ldr     r3, [pc, #24]   ; f4 <boot_secondary+0xf4>
  d8:   e5933000        ldr     r3, [r3]	; read pen_release
  dc:   e3730001        cmn     r3, #1  ; 0x1	; == -1?
  e0:   13e00025        mvnne   r0, #37 ; 0x25	; != -1 => -ENOSYS
  e4:   01a00002        moveq   r0, r2		; == -1 => 0
  e8:   e99da870        ldmib   sp, {r4, r5, r6, fp, sp, pc}
...
000001d8 <__cpu_up>:
 2dc:   ebfffffe        bl      0 <boot_secondary>
 2e0:   e1a05000        mov     r5, r0
 2e4:   ebfffffe        bl      0 <sched_clock>
 2e8:   e894000c        ldm     r4, {r2, r3}	; boot_start
 2ec:   e0502002        subs    r2, r0, r2	; sched_clock() - boot_start
 2f0:   e0c13003        sbc     r3, r1, r3
 2f4:   e59f0128        ldr     r0, [pc, #296]  ; 424 <__cpu_up+0x24c>
 2f8:   ebfffffe        bl      0 <printk>	; "Boot returned: %llu\n"

So there's not much going on in that path.

The CPU being brought online is doing this:

00000034 <_raw_spin_lock>:
  34:   e1a0c00d        mov     ip, sp
  38:   e92dd800        push    {fp, ip, lr, pc}
  3c:   e24cb004        sub     fp, ip, #4      ; 0x4
  40:   e3a03001        mov     r3, #1  ; 0x1
  44:   e1902f9f        ldrex   r2, [r0]
  48:   e3320000        teq     r2, #0  ; 0x0
  4c:   1320f002        wfene
  50:   01802f93        strexeq r2, r3, [r0]
  54:   03320000        teqeq   r2, #0  ; 0x0
  58:   1afffff9        bne     44 <_raw_spin_lock+0x10>
  5c:   f57ff05f        dmb     sy
  60:   e89da800        ldm     sp, {fp, sp, pc}

as it's waiting for the lock to be released.  So... what could be causing
the above code in boot_secondary()/__cpu_up() to take 500us when the
system's running?  The dmb, dsb, or sev?  Or the SCU trying to sort out
the str to release the lock?
