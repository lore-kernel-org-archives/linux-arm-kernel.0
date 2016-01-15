From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 15 Jan 2016 09:57:58 -0700
Subject: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
In-Reply-To: <CAPDyKFpj0Gv=5hVwZWjmgmumHPriuYk+LLVBwjEeW9Jfj8p5Kw@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
 <20160114183316.GB1651@linaro.org>
 <CAPDyKFpj0Gv=5hVwZWjmgmumHPriuYk+LLVBwjEeW9Jfj8p5Kw@mail.gmail.com>
Message-ID: <20160115165758.GC1651@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15 2016 at 01:55 -0700, Ulf Hansson wrote:
[...]
>
>> *) Non-IRQ safe parent + IRQ-safe subdomain
>
>Let's name this case 1.
>
>>   Attach subdomain:
>>         - parent mutex held and subdomain spinlocked.
>>   Power-on:
>>         - subdomain assumes parent is always ON or powered on before the
>>         subdomain is powered ON.
>
>As stated above, what do you think of *not* dealing with this case as
>I think it's not a solution but a workaround!
>
>>   Power-off:
>>         - parent is not powered off even if the subdomain was the last
>>         active domain.
>>
>> **) IRQ-safe parent + IRQ-safe subdomain
>
>Let's name this case 2.
>
>>    Attach subdomain:
>>         - parent spinlock held and subdomain spinlocked.
>>    Power-on:
>>         - subdomain may power on the parent.
>>    Power-off:
>>         - last active sub-domain will power off the parent in the same
>>           context.
>
>From a genpd locking point of view, there should be no reason to power
>off in same context. We should be able to deal with this via a
>scheduled work for this case as well, right!?
>
I agree it need not be a requirement. May be we can have an option to
schedule the work. In the case of CPU power management, scheduling a
work is not an option, especially when the domain and the CPUs are
collapsing.

>Although, I realize that it's very useful to power off in the same
>context to minimize latencies in the full blown CPU Cluster Power
>Management solution.
>Perhaps a separate genpd configuration flag could be added to enable
>this method, as I imagine that not *all* IRQ safe domains wants to use
>it.
>
>What do you think?
>
May be we can provide the is_async option as a genpd flag.

>>
>> ***) IRQ-safe parent + non-IRQ-safe subdomain
>
>Let's name this case 3.
>
>>    Attach subdomain:
>>         - parent spinlock held and subdomain **cannot** be mutex locked.
>
>First, attaching shouldn't occur from atomic context.
>
>Second, the important part is that we pick the locks in same order as
>elsewhere in genpd, and of course we must not pick a mutex while
>holding a spinlock.
>
>In all cases when adding subdomains, we should start by fetching the
>subdomains lock *then* the lock for the parent. The current genpd code
>doesn't do that and additionally it uses nested locks.
>I am going to send a patch the changes this behaviour, as I think it's
>wrong and may cause deadlocks!
>
Ah. Makes sense. I wish I had thought of it.

>Following this approach means that case 1 can't be supported, as that
>would mean holding a spinlock while fetching a mutex.
>
>>    Power-on:
>>         - subdomain may power on the parent.
>>    Power-off:
>>         - last active subdomain will be able to power off the domain
>>
>> Except for the last case, we can support the others in addition to the
>> currently available, with the restriction that
>> - IRQ-safe parents can only have IRQ-safe subdomains and devices
>>
>> - Non-IRQ safe parents may have both IRQ-safe and non-IRQ-safe
>>  subdomains and devices and the assumption that
>>         -- IRQ-safe subdomains and devices will not bother to power
>>         on/off their non-IRQ-safe parent.
>>
>
>I think case 2 and case 3 should be okay to support, but I am really
>questioning case 1.
>
With you other patch, it does make sense to have 2 and 3 instead of 1
and 2. 

My only concern is as I view the SoC as a whole, there would be cases
where the parent domain could only be non-IRQ safe (turning off a big
regulator may require some sleep) and the subdomains are quicker and
faster IRQ-safe domains. Putting up this restriction, chops up the
domain hierarchy. Imagine, if you could represent the whole power domain
organization in DT, but because of this restriction, we may not be able
to do that.

Thanks,
Lina
