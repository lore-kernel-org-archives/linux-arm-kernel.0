From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 25 Nov 2014 21:10:54 +0000
Subject: [PATCH 3.18-rc3 v9 1/5] irqchip: gic: Finer grain locking for
 gic_raise_softirq
In-Reply-To: <alpine.LFD.2.11.1411251510231.11690@knanqh.ubzr>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1416936401-5147-1-git-send-email-daniel.thompson@linaro.org>
 <1416936401-5147-2-git-send-email-daniel.thompson@linaro.org>
 <5474BF19.3040707@arm.com> <alpine.LFD.2.11.1411251510231.11690@knanqh.ubzr>
Message-ID: <5474F05E.90401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/14 20:17, Nicolas Pitre wrote:
> On Tue, 25 Nov 2014, Marc Zyngier wrote:
> 
>> Hi Daniel,
>>
>> On 25/11/14 17:26, Daniel Thompson wrote:
>>> irq_controller_lock is used for multiple purposes within the gic driver.
>>> Primarily it is used to make register read-modify-write sequences atomic.
>>> It is also used by gic_raise_softirq() in order that the big.LITTLE
>>> migration logic can figure out when it is safe to migrate interrupts
>>> between physical cores.
>>>
>>> The second usage of irq_controller_lock is difficult to discern when
>>> reviewing the code because the migration itself takes place outside
>>> the lock.
>>>
>>> This patch makes the second usage more explicit by splitting it out into
>>> a separate lock and providing better comments.
>>
>> While we're at it, how about an additional patch that would make this
>> lock disappear entirely when the big-little stuff is not compiled in,
>> which is likely to be the case on a lot of (dare I say most?) systems?
>> That will save expensive barriers that we definitely could do without.
> 
> For the record, I reviewed and ACKed a patch doing exactly that a while 
> ago:
> 
> http://lkml.org/lkml/2014/8/13/486

Well remembered! That patch had a different motivation but is very
similar to mine... so much so I might steal bit of it.

I'll make sure I put Stephen on Cc: when I respin with the changes Marc
requested.
