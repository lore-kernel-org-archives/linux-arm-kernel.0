From: minggr@gmail.com (Lin Ming)
Date: Wed, 9 Apr 2014 10:43:32 -0700
Subject: current->sched_class->yield_task is NULL, any hint?
Message-ID: <CAF1ivSbZKbDc+rzd+CUqCzNmSgZmZTE-QeSU-2WmSiuEs-Kw_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

I hit a panic in sys_sched_yield() because(for some unknown reason)
current->sched_class->yield_task is NULL.
It's an ARM embedded board with 3.4-rt kernel.

Could you share any hint for the possible causes?

Panic log attached.

Line 4551 "yield_task" is NULL.

4546 SYSCALL_DEFINE0(sched_yield)
4547 {
4548         struct rq *rq = this_rq_lock();
4549
4550         schedstat_inc(rq, yld_count);
4551         current->sched_class->yield_task(rq);
4552
4553         /*
4554          * Since we are going to call schedule() anyway, there's
4555          * no need to preempt or enable interrupts:
4556          */
4557         __release(rq->lock);
4558         spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
4559         do_raw_spin_unlock(&rq->lock);
4560         sched_preempt_enable_no_resched();
4561
4562         schedule();
4563
4564         return 0;
4565 }

[12889.449746] r3 : 00000000 r2 : 00000001 r1 : 0000ddfc r0 : c0c1d2c0

r3 is NULL, so "blx r3" crashed.

c007a4e8: e12fff33 blx r3

c007a498 <sys_sched_yield>:
c007a498:       e1a0c00d        mov     ip, sp
c007a49c:       e92dd830        push    {r4, r5, fp, ip, lr, pc}
c007a4a0:       e24cb004        sub     fp, ip, #4
c007a4a4:       f10c0080        cpsid   i
c007a4a8:       e1a0300d        mov     r3, sp
c007a4ac:       e3c34d7f        bic     r4, r3, #8128   ; 0x1fc0
c007a4b0:       e3c4403f        bic     r4, r4, #63     ; 0x3f
c007a4b4:       e3012df8        movw    r2, #7672       ; 0x1df8
c007a4b8:       e34c2073        movt    r2, #49267      ; 0xc073
c007a4bc:       e30232c0        movw    r3, #8896       ; 0x22c0
c007a4c0:       e5941014        ldr     r1, [r4, #20]
c007a4c4:       e34c3070        movt    r3, #49264      ; 0xc070
c007a4c8:       e7925101        ldr     r5, [r2, r1, lsl #2]
c007a4cc:       e0835005        add     r5, r3, r5
c007a4d0:       e1a00005        mov     r0, r5
c007a4d4:       eb0d472d        bl      c03cc190 <_raw_spin_lock>
c007a4d8:       e594300c        ldr     r3, [r4, #12]
c007a4dc:       e1a00005        mov     r0, r5
c007a4e0:       e5933030        ldr     r3, [r3, #48]   ; 0x30
c007a4e4:       e593300c        ldr     r3, [r3, #12]
c007a4e8:       e12fff33        blx     r3
c007a4ec:       f57ff05f        dmb     sy
c007a4f0:       e3a03801        mov     r3, #65536      ; 0x10000
c007a4f4:       e1952f9f        ldrex   r2, [r5]
c007a4f8:       e6522f13        uadd16  r2, r2, r3
c007a4fc:       e1851f92        strex   r1, r2, [r5]
c007a500:       e3310000        teq     r1, #0
c007a504:       1afffffa        bne     c007a4f4 <sys_sched_yield+0x5c>
c007a508:       f57ff04f        dsb     sy
c007a50c:       e320f004        sev
c007a510:       e5943004        ldr     r3, [r4, #4]
c007a514:       e2433001        sub     r3, r3, #1
c007a518:       e5843004        str     r3, [r4, #4]
c007a51c:       eb0d44ae        bl      c03cb7dc <schedule>
c007a520:       e3a00000        mov     r0, #0
c007a524:       e89da830        ldm     sp, {r4, r5, fp, sp, pc}

Thanks,
Ming
-------------- next part --------------
A non-text attachment was scrubbed...
Name: panic.log
Type: text/x-log
Size: 20208 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/cce21962/attachment-0001.bin>
