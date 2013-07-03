From: javier.picorel@epfl.ch (javier.picorel at epfl.ch)
Date: Wed, 03 Jul 2013 22:32:55 +0200
Subject: ARM Cortex A9: LL counters
Message-ID: <20130703223255.15536gmsbwonw5fb@webmail.epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

It seems that there is no mapping between any ARM Cortex A9 counter to  
the L2 (Last Level) access or misses event.

arch/arm/kernel/perf_event_v7.c

  [C(LL)] = {
  293                [C(OP_READ)] = {
  294                        [C(RESULT_ACCESS)]      = CACHE_OP_UNSUPPORTED,
  295                        [C(RESULT_MISS)]        = CACHE_OP_UNSUPPORTED,
  296                },
  297                [C(OP_WRITE)] = {
  298                        [C(RESULT_ACCESS)]      = CACHE_OP_UNSUPPORTED,
  299                        [C(RESULT_MISS)]        = CACHE_OP_UNSUPPORTED,
  300                },
  301                [C(OP_PREFETCH)] = {
  302                        [C(RESULT_ACCESS)]      = CACHE_OP_UNSUPPORTED,
  303                        [C(RESULT_MISS)]        = CACHE_OP_UNSUPPORTED,
  304                },
  305        },

Looking at ARM's reference manual and OProfile's event list on A9, I  
see the following two counters:

CO_LF_MISS: (counter: 1, 2, 3, 4, 5, 6)
         Number of coherent linefill requests which miss in all other  
CPUs, meaning that the request
         is sent to external memory (min count: 500)
CO_LF_HIT: (counter: 1, 2, 3, 4, 5, 6)
         Number of coherent linefill requests which hit in another  
CPU, meaning that the linefill
         data is fetched directly from the relevant cache (min count: 500)

It seems that the first counter refers to the L2 Misses and the second  
one to the L2 Hits (Last Level Cache in this architecture). I'm not sure
whether we should do something about this or nor. Thanks!

Best Regards,
Javier
