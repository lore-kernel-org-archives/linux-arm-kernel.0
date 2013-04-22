From: andre.przywara@linaro.org (Andre Przywara)
Date: Mon, 22 Apr 2013 12:36:58 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+gL=rbxxBRgYdHxBj_C9ZBFbuORaG0jcSzEUJ7pO9-Fqkg@mail.gmail.com>
References: <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
 <516BCAD0.9000708@linaro.org>
 <CAJRNFKJoBzgt4UhxsH65_LyhcGXPnzB_pg3q-zeYT2OVv59q4A@mail.gmail.com>
 <516BFD13.1000400@linaro.org>
 <20130415134837.GI9827@mudshark.cambridge.arm.com>
 <CAEDV+gJB7Bj9O7pftFqoYQ=goORjdurBnEfQVmC5arDuNJfpBg@mail.gmail.com>
 <32d532438f5b621e40679aea9f5888c7@localhost> <516E586C.5030407@linaro.org>
 <8e0bda3fd84d1b0c5aa55161ca178a8e@localhost>
 <CAEDV+g+3nkdvbLdj0m-ZdDKt0JY2vgzhP2AQA2nf=R3h4yTQmQ@mail.gmail.com>
 <51713F91.5080102@linaro.org>
 <CAEDV+gL=rbxxBRgYdHxBj_C9ZBFbuORaG0jcSzEUJ7pO9-Fqkg@mail.gmail.com>
Message-ID: <517512CA.6070503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 06:13 PM, Christoffer Dall wrote:
> On Fri, Apr 19, 2013 at 5:58 AM, Andre Przywara
> <andre.przywara@linaro.org> wrote:
>> On 04/17/2013 11:12 AM, Christoffer Dall wrote:
>>>
>>>  ...
>>>
>>> You could also try installing a vector handler early and detect faults,
>>> and add an alternative return path from the init function with some
>>> error reporting value in r0 or something like that, just for debugging,
>>> naturally, but that could be a way to detect if we really are taking
>>> recursive faults here.
>>
>>
>> OK, I added code to return earlier on CPUs not from cluster 0.
>> Indeed it hangs in the HSCR write. The two A15s pass this instruction,
>> writing 0x30c5187F into the register.
>> This means all the fixed bits for A15 correctly, C,A,M and I set and WXN,
>> EE, TE cleared. FI was also cleared
>> The A7 wanted to write the very same value. I tried to set bit 21, which
>> kind of the A7 TRM hints to do: but no change.
>> Before the HSCLTR write, the register reads 0x30c50878, with SCTLR being
>> 0x30c5387d.
>> So the code wants to set M, A, C and I in HSCLTR. Interestingly SCTLR has
>> the V bits set, could that be an issue?
>>
> Can you try writing 0x30c50879 into the register instead? Basically
> check to see if enabling caches or alignment checks causes the issue,
> or if it is indeed enabling the MMU that's the issue... If that works,
> start a bisect on the remaining bits. Also, just for fun, could you
> try flushing the entire I-cache before writing into the HSCLTR?

OK, both clearing the I-bit and doing an "isb; ICIALLU" before the "isb; 
write HSCLTR; isb" worked, the kernel boots on and KVM is enabled.

I could easily make a patch, but I am not sure how to proceed from here:

1.) At least I don't have an understanding why this is only a problem on 
A7 and not on A15. I would feel better if we have an explanation for 
this. Mark, Will, Peter: any ideas?

2.) We still do not claim to support A7s. ARM_CPU_PART_CORTEX_A15 is the 
only MIDR content not returning -EINVAL. And there is no coproc_a7.c 
yet. From browsing through coproc_a15.c I sense it looks compatible to 
the A7, only handling L2CTLR[25:24] and ACTLR[SMP] explicitly. On pure 
A7 systems this should work, but in mixed (aka. b.L) systems guests 
would see inconsistent input depending on the current scheduling. This 
looks like we need a real solution, which needs some time and work 
(read: proper b.L support).

3.) Even if we would understand this fix and take it, the kernel 
currently still randomly enables or disables KVM - with only A15 
supported and the check routine running on one of the cores only.
And even if we add A7 to the list, I think we still need to iterate 
through all cores to catch unsupported cores in a different b.L 
configuration.

I suppose it is to late for 3.9 in any case right? Or should we try to 
push at least the ICIALLU fix?

> Why wouldn't the V bit be set in the SCTLR, Linus uses high vectors
> (at 0xffff0000) for exception handling on ARM.

Shame on me, didn't know this. I assumed that those high vectors are 
there for legacy reasons only. Good to know and thanks for telling me.


Regards,
Andre.
