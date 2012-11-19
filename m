From: aniyas15@gmail.com (niyas mydeen)
Date: Mon, 19 Nov 2012 08:15:16 +0530
Subject: Add PI/robust mutexes support for SMP kernels
Message-ID: <CADoAD8LgrJsryfgktSVejO3mmQj_cZ1WtjR-CPFuZ-iwMS2B1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We have Linux running on our ARM Cortex-a9 (SMP) based platform.
Test setup : Linux-2.6.35
GLIBC : 2.11.

Test Scenario : We observed with our User application that the system is
getting hanged at some point of time while keep doing power reset (with
some delay).

1. Earlier we applied "Add PI/robust mutexes support for SMP kernels" to
have PI-futex support on our kernel.
http://lists.infradead.org/*pi*permail/linux-*arm*
-kernel/2010-June/017374.html<http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017374.html>

2. Found a problem while using pthread_mutex_lock, and it seems like at
error occurrence, the status of mutex management data is getting corrupted.
The error part of libpthread source
(glibc-2.11/nptl/pthread_mutex_lock.c)is pasted below
        /* Check whether we already hold the mutex.  */
        if (__builtin_expect ((oldval & FUTEX_TID_MASK) == id, 0))
          {
            if (kind == PTHREAD_MUTEX_ERRORCHECK_NP)
              {
                THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending,
NULL);


IMA_RESETLOG(0xA0,oldval,id,mutex->__data.__owner,0x3)        //err point
code 03
                return EDEADLK;
              }

at this point the value of mutex->__data.__owner becomes 0 or some other
value.

 3. So we decided to apply Catalin's patch ie "ARM: Remove the domain
switching on ARMv6k/v7 CPUs"  from "
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/016997.html".
But there is some confusion in using this patch as it is because our system
has TLS_REG so the macro CPU_USE_DOMAIN automatically get disabled. And
with this patch we observe different behavior of the system.

4. Our concern here is do you have any patch related to User Ro Kernel Ro
alone so that we can try it out that patch.

Any valuable feedback will help us to solve this issue.

Thanks & Regards,
A. Mydeen.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/573dd348/attachment-0001.html>
