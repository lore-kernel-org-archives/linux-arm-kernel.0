From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 6 Jul 2015 17:57:06 +0200
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <559AA02A.6060703@linaro.org>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <559A7425.4050506@redhat.com> <559AA02A.6060703@linaro.org>
Message-ID: <559AA552.3010400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/2015 17:35, Eric Auger wrote:
>>> diff --git a/kernel/irq/bypass.c b/kernel/irq/bypass.c
>>> >> index 5d0f92b..efadbe5 100644
>>> >> --- a/kernel/irq/bypass.c
>>> >> +++ b/kernel/irq/bypass.c
>>> >> @@ -19,6 +19,42 @@ static LIST_HEAD(producers);
>>> >>  static LIST_HEAD(consumers);
>>> >>  static DEFINE_MUTEX(lock);
>>> >>  
>>> >> +/* lock must be hold when calling connect */
>> > 
>> > If a lock must be held while callbacks are called, you have to document
>> > that producers and consumers must _not_ call back into the IRQ bypass
>> > manager.  (If they have to, you have to document explicitly "This
>> > function can be called from producer and consumer callbacks" whenever
>> > relevant).
> OK Thanks

Also, please document on functions that take the irq bypass mutex that
they can sleep.  In fact irq_bypass_{,un}register_{producer,consumer}
need kerneldoc comments.

The good thing is that this helps a bit forming a lock hierarchy across
the subsystems, for example irq bypass mutex outside vfio_platform_irq
spinlock, because you cannot have a spinlock inside the mutex.  I think
that all of your six callbacks are fine.

Paolo
