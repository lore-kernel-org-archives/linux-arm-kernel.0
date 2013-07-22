From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 22 Jul 2013 14:51:52 +0200
Subject: [PATCH 3/4] arm64: KVM: let other tasks run when hitting WFE
In-Reply-To: <CAC4Lta17bmNjBck6LzziBeU0Xc36F1Jms2tQPv6+GaXvik6Wyg@mail.gmail.com>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-4-git-send-email-marc.zyngier@arm.com>
 <CAC4Lta17bmNjBck6LzziBeU0Xc36F1Jms2tQPv6+GaXvik6Wyg@mail.gmail.com>
Message-ID: <CAMJs5B8Sg1MPHPsRV75mmagnYxkhzA0MKWVkwW2y0WdDVWTSxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2013 10:53, Raghavendra KT <raghavendra.kt.linux@gmail.com> wrote:
> On Fri, Jul 19, 2013 at 7:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> So far, when a guest executes WFE (like when waiting for a spinlock
>> to become unlocked), we don't do a thing and let it run uninterrupted.
>>
>> Another option is to trap a blocking WFE and offer the opportunity
>> to the scheduler to switch to another task, potentially giving the
>> vcpu holding the spinlock a chance to run sooner.
>>
>
> Idea looks to be correct from my experiments on x86. It does bring some
> percentage of benefits in overcommitted guests. Infact,
>
> https://lkml.org/lkml/2013/7/22/41 tries to do the same thing for x86.
> (this results in using ple handler heuristics in vcpu_block pach).

What about the adverse effect in the non-overcommitted case?
