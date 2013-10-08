From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 Oct 2013 17:09:11 +0100
Subject: [PATCH 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <525420FF.30503@linux.vnet.ibm.com>
References: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
 <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
 <CAC4Lta14xZNnEUXxZiaF4=PQQTjq4efjsNDAK2oBH4-Uqh_d0A@mail.gmail.com>
 <5253FDDD.6050008@arm.com> <52541EA3.7010403@linux.vnet.ibm.com>
 <52541F93.4070503@arm.com> <525420FF.30503@linux.vnet.ibm.com>
Message-ID: <52542E27.1030004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/13 16:13, Raghavendra K T wrote:
> On 10/08/2013 08:36 PM, Marc Zyngier wrote:
>>>> Just gave it a go, and the results are slightly (but consistently)
>>>> worse. Over 10 runs:
>>>>
>>>> Without RELAX_INTERCEPT: Average run 3.3623s
>>>> With RELAX_INTERCEPT: Average run 3.4226s
>>>>
>>>> Not massive, but still noticeable. Any clue?
>>>
>>> Is it  a 4x overcommit? Probably we would have hit the code
>>> overhead if it were small guests.
>>
>> Only 2x overcommit (dual core host, quad vcpu guests).
> 
> Okay. quad vcpu seem to explain.
> 
>>
>>> RELAX_INTERCEPT is worth enabling for large guests with
>>> overcommits.
>>
>> I'll try something more aggressive as soon as I get the time. What do
>> you call a large guest? So far, the hard limit on ARM is 8 vcpus.
>>
> 
> Okay. I was referring to guests >= 32 vcpus.
> May be 8vcpu guests with 2x/4x is worth trying. If we still do not
> see benefit, then it is not worth enabling.

I've just tried with the worse case I can construct, which is a 8 vcpu
guest limited to one physical CPU:

Over 10 runs:

Without RELAX_INTERCEPT:
Time: 6.793
Time: 7.619
Time: 6.690
Time: 7.198
Time: 7.659
Time: 7.054
Time: 7.728
Time: 8.546
Time: 7.306
Time: 7.219

Average: 7.381

With RELAX_INTERCEPT:
Time: 6.850
Time: 6.889
Time: 7.170
Time: 6.938
Time: 6.756
Time: 7.341
Time: 6.707
Time: 7.452
Time: 6.617
Time: 8.095

Average: 7.082

We're now starting to see some (small) benefits: slightly faster with
RELAX_INTERCEPT, and less jitter (the heuristic is better at picking the
target vcpu than the default behaviour).

I'll enable it in the next version of the series.

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
