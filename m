From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 22 Nov 2018 15:10:34 +0000
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <CAKv+Gu9o_2-u6MJf1QLLSbdWfPvq0vqr61K0Nawr-Nob6hsepg@mail.gmail.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <bf872be5-4a56-017b-83b6-544f8d8f528e@arm.com>
 <CAKv+Gu9o_2-u6MJf1QLLSbdWfPvq0vqr61K0Nawr-Nob6hsepg@mail.gmail.com>
Message-ID: <e5c2ebf1-e6c0-505a-699b-681e276444d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/11/18 12:11, Ard Biesheuvel wrote:
> On Thu, 22 Nov 2018 at 12:49, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Hi,
>>
>> On 26/09/18 14:56, Julien Thierry wrote:
>>> Hi,
>>>
>>> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
>>> using it to access memory. When taking an exception, it is possible that
>>> the context during which the exception occured had SP mis-aligned. The
>>> entry code needs to make sure that the stack is aligned before using it to
>>> save the context.
>>>
>>
>> So, as discussed in this thread:
>> https://www.spinics.net/lists/arm-kernel/msg688342.html
>>
>> We might have the compiler provide the guarantee that SP is kept at
>> multiples of 16-bytes throughout C functions. If this is accepted, it
>> avoids the complexity of this series.
>>
> 
> Yes, but we still want the build time sizeof(pt_regs) check and
> perhaps other pieces of this series.
> 

Good point.

>> There is just one case remaining, which is less important as it is
>> mostly a debug concern. If we take an SP alignment fault from EL1 (due
>> to bad implementation) we take recursive exceptions:
>>
>> - Without CONFIG_VMAP_STACK, kernel just freezes always taking SP
>> alignment faults
>> - With CONFIG_VMAP_STACK after taking a number of exceptions, we
>> overflow the stack and the kernel switches to the overflow stack where
>> it finally manages to display a kernel panic message
>>
>> So the question is, do we care about doing something for the above case?
>>
> 
> So in the latter case, it is obvious from the debug output that the
> stack pointer was misaligned? I'd expect so, given that each
> recursively taken exception has the same cause, and so it would be
> clear what happened.
> 

So, it is obvious that the error is a misaligned stack pointer as it is 
described in the ESR and as you said, we are always taking the same kind 
of exception.

However the ELR will get overwritten by the recursive exception and its 
last value will be the first instruction accessing memory through SP in 
the exception handler. Meaning we lost the address where the first 
misaligned stack access happened.

But then I don't know whether this case warrants adding complexity to 
the entry code just in case one day fiddles around with the SP and does 
not align it to 16-bytes before accessing memory (or does it while 
interrupts are enabled).

> So I'm leaning towards just relying on that, given that
> CONFIG_VMAP_STACK is the default, although it is unfortunate that
> KASAN still disables it.

Thanks,

-- 
Julien Thierry
