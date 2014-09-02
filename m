From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 2 Sep 2014 12:43:05 -0600
Subject: [PATCH v3 3/4] irq: Allow multiple clients to register for irq
 affinity notification
In-Reply-To: <alpine.DEB.2.10.1408272239190.3323@nanos>
References: <1409170479-29955-1-git-send-email-lina.iyer@linaro.org>
 <1409170479-29955-4-git-send-email-lina.iyer@linaro.org>
 <alpine.DEB.2.10.1408272239190.3323@nanos>
Message-ID: <20140902184305.GB91995@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27 2014 at 14:56 -0600, Thomas Gleixner wrote:
>On Wed, 27 Aug 2014, Lina Iyer wrote:
>
>> PM QoS and other idle frameworks can do a better job of addressing power
>> and performance requirements for a cpu, knowing the IRQs that are
>> affine to that cpu. If a performance request is placed against serving
>> the IRQ faster and if the IRQ is affine to a set of cpus, then setting
>> the performance requirements only on those cpus help save power on the
>> rest of the cpus. PM QoS framework is one such framework interested in
>> knowing the smp_affinity of an IRQ and the change notificiation in this
>> regard. QoS requests for the CPU_DMA_LATENCY constraint currently apply
>> to all cpus, but when attached to an IRQ, can be applied only to the set
>> of cpus that IRQ's smp_affinity is set to. This allows other cpus to
>> enter deeper sleep states to save power. More than one framework/driver
>> can be interested in such information.
>
>All you are describing is the fact, that there is only a single
>notifier possible right now, but you completely miss to describe WHY
>you need multiple ones.
>
>The existing notifier was introduced to tell the driver that the irq
>affinity has changed, so it can move its buffers to the proper NUMA
>node. So if that driver gets this information then it can tell the PM
>QoS code that its affinity changed so that stuff can react
>accordingly, right?
>
With the new PM QoS changes, multiple drivers would now be interested in
knowing the smp_affinity changes of the same IRQ. PM QoS abstracts the
notifier in the framework, so individual drivers dont have to register
for notification themselves and handle affinity notifications. But PM
QoS needs to coexist with NUMA and other arch drivers that need to
modify based on their arch specific needs upon affinity change
notifications.
Modifying the IRQ notifications to list, benefits having a simpler
mechanism to notify all arch drivers and frameworks like PM QoS.


>This is going nowhere unless you provide a proper usecase and
>arguments why this is necessary. Handwaving and I want a pony
>arguments are not sufficient.
>
>Thanks,
>
>	tglx
