From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 18 Jan 2018 14:25:52 +0000
Subject: [PATCH v2 0/2] arm64: Run enable method for errata work arounds
 on late CPUs
In-Reply-To: <20180118142125.GM22781@e103592.cambridge.arm.com>
References: <20180117174220.7959-1-suzuki.poulose@arm.com>
 <20180118114540.GL22781@e103592.cambridge.arm.com>
 <5c1945a8-a66d-9306-1c6d-3c1c8febcab2@arm.com>
 <851887b9-974a-6f20-920b-d9149d8122fe@arm.com>
 <20180118142125.GM22781@e103592.cambridge.arm.com>
Message-ID: <806b4c01-9c82-8666-aa05-b1dc5d5afd47@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/18 14:21, Dave Martin wrote:
> On Thu, Jan 18, 2018 at 12:08:43PM +0000, Robin Murphy wrote:
>> On 18/01/18 12:00, Robin Murphy wrote:
>> [...]
>>>> +struct enable_arg {
>>>> +??? int (*enable)(struct arm64_cpu_capabilities const *);
>>>> +??? struct arm64_cpu_capabilities const *cap;
>>>> +};
>>>> +
>>>> +static int __enable_cpu_capability(void *arg)
>>>> +{
>>>> +??? struct enable_arg const *e = arg;
>>>> +
>>>> +??? return e->enable(e->cap);
>>>> +}
>>>
>>> AFAICS, you shouldn't even need the intermediate struct - if you were
>>> instead to call stop_machine(&caps->enable, ...), the wrapper could be:
>>>
>>>  ????<type> **fn = arg;
>>>  ????*fn(container_of(fn, struct arm64_cpu_capabilities, enable));
>>>
>>> (cheaty pseudocode because there's no way I'm going to write a
>>> pointer-to-function-pointer type correctly in an email client...)
>>>
>>> That's certainly a fair bit simpler in terms of diffstat; whether it's
>>> really as intuitive as I think it is is perhaps another matter, though.
>>
>> Ah, right, but then you'd be back to casting away const, and at that point
>> it makes no sense to do the container_of dance instead of just passing the
>> struct pointer itself around...
>>
>> I shall now excuse myself from this discussion, as I'm clearly not helping
>> :)
>>
>> Robin.
> 
> That's what I was about to say... but neat trick.
> 
> However, it does concentrate the type fudge in one place and keeps the
> arm64_cpu_capabilities::enable() prototype correct, so it's still better
> than the original.
> 
> 
> Thinking about it, the following is probably clearer and no worse:
> 
> static int __enable_cpu_capability(void *arg)
> {
> 	struct arm64_cpu_capabilities const *cap = arg;
> 
> 	return cap->enable(cap);
> }
> 
> ...
> 
> stop_machine(__enable_cpu_capability, (void *)caps, cpu_online_mask);
> 
> 
> In your version, the argument would be (void *)&caps->enable, which is
> really just a proxy for (void *)caps, unless I missed something.
> 
> 
> What do you think Suzuki?  I can respin my patch if you fancy picking it
> up.  Either way, it's not urgent.

Thanks for cooking that up Dave & Robin. I prefer your second version.
Please feel free to respin it. As you rightly said, this is not urgent
and could pick it up in my re-writing of the capability infrastructure ;-)

Meanwhile, I would really like some reviews on the original patch and
push it for 4.16 (as a fix at least).

Cheers
Suzuki

> 
> Cheers
> ---Dave
> 
