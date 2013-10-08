From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 Oct 2013 16:06:59 +0100
Subject: [PATCH 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <52541EA3.7010403@linux.vnet.ibm.com>
References: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
 <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
 <CAC4Lta14xZNnEUXxZiaF4=PQQTjq4efjsNDAK2oBH4-Uqh_d0A@mail.gmail.com>
 <5253FDDD.6050008@arm.com> <52541EA3.7010403@linux.vnet.ibm.com>
Message-ID: <52541F93.4070503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/13 16:02, Raghavendra K T wrote:
> [...]
>>>> +               kvm_vcpu_on_spin(vcpu);
>>>
>>> Could you also enable CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT for arm and
>>> check if ple handler logic helps further?
>>> we would ideally get one more optimization folded into ple handler if
>>> you enable that.
>>
>> Just gave it a go, and the results are slightly (but consistently)
>> worse. Over 10 runs:
>>
>> Without RELAX_INTERCEPT: Average run 3.3623s
>> With RELAX_INTERCEPT: Average run 3.4226s
>>
>> Not massive, but still noticeable. Any clue?
> 
> Is it  a 4x overcommit? Probably we would have hit the code
> overhead if it were small guests.

Only 2x overcommit (dual core host, quad vcpu guests).

> RELAX_INTERCEPT is worth enabling for large guests with
> overcommits.

I'll try something more aggressive as soon as I get the time. What do
you call a large guest? So far, the hard limit on ARM is 8 vcpus.

	M.
-- 
Jazz is not dead. It just smells funny...
