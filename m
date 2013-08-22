From: cminyard@mvista.com (Corey Minyard)
Date: Wed, 21 Aug 2013 21:55:40 -0500
Subject: Conflicting addr value between v6 and v7 for do_PrefetchAbort()
Message-ID: <52157DAC.4000107@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was messing around in this code, talking with someone else about it, 
and I discovered that the addr parameter do do_PrefetchAbort() is 
different on v6 and v7.  For v7 we have:

ENTRY(v7_pabort)
     mrc    p15, 0, r0, c6, c0, 2        @ get IFAR
     mrc    p15, 0, r1, c5, c0, 1        @ get IFSR
     b    do_PrefetchAbort
ENDPROC(v7_pabort)

And for v6:

ENTRY(v6_pabort)
     mov    r0, r4
     mrc    p15, 0, r1, c5, c0, 1        @ get IFSR
     b    do_PrefetchAbort
ENDPROC(v6_pabort)

For v7 that's the address that was accessed to cause the fault.  For v6 
that appears to be the address of the instruction that caused the 
fault.  Am I right here?  Which of these is correct?

I see 
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/001051.html 
which adds this and
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/055019.html 
which sets it to r4 for the v6.  But you get different values in addr 
depending on whether it is v6 or v7.

Thanks,

-corey
