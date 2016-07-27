From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 27 Jul 2016 12:19:59 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160726175447.GA28376@leverpostej>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
 <20160726175447.GA28376@leverpostej>
Message-ID: <a90e1e01-b0c8-f57b-ada5-835f9d5736bf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/16 18:54, Mark Rutland wrote:
> On Tue, Jul 26, 2016 at 10:50:08AM +0100, Daniel Thompson wrote:
>> On 25/07/16 18:13, Catalin Marinas wrote:
>>> You get more unexpected side effects by not saving/restoring the whole
>>> stack. We looked into this on Friday and came to the conclusion that
>>> there is no safe way for kprobes to know which arguments passed on the
>>> stack should be preserved, at least not with the current API.
>>>
>>> Basically the AArch64 PCS states that for arguments passed on the stack
>>> (e.g. they can't fit in registers), the caller allocates memory for them
>>> (on its own stack) and passes the pointer to the callee. Unfortunately,
>>> the frame pointer seems to be decremented correspondingly to cover the
>>> arguments, so we don't really have a way to tell how much to copy.
>>> Copying just the caller's stack frame isn't safe either since a
>>> callee/caller receiving such argument on the stack may passed it down to
>>> a callee without copying (I couldn't find anything in the PCS stating
>>> that this isn't allowed).
>>
>> The PCS[1] seems (at least to me) to be pretty clear that "the
>> address of the first stacked argument is defined to be the initial
>> value of SP".
>>
>> I think it is only the return value (when stacked via the x8
>> pointer) that can be passed through an intermediate function in the
>> way described above. Isn't it OK for a jprobe to clobber this
>> memory? The underlying function will overwrite whatever the jprobe
>> put there anyway.
>>
>> Am I overlooking some additional detail in the PCS?
>
> I suspect that the "initial value of SP" is simply meant to be relative to the
> base of the region of stack reserved for callee parameters. While it also uses
> the phrase "current stack-pointer value", I suspect that this is overly
> prescriptive.

I don't think so. Whilst writing my reply of yesterday I forced stacked 
arguments by creating a function with nine arguments (rather than large 
values). The ninth argument is, as expected, passed to the callee based 
on the value of the SP.


> In practice, GCC allocates callee parameters *above* the frame record
> for the caller, which is above the SP and FP. e.g. with:
>
> ----
 > <snip>
 > ----
> ----
> 00000000004005d0 <large_func>:
>   4005d0:       f81f0ff3        str     x19, [sp,#-16]!
>   4005d4:       aa0003f3        mov     x19, x0
>   4005d8:       f9400260        ldr     x0, [x19]
>   4005dc:       f84107f3        ldr     x19, [sp],#16
>   4005e0:       d65f03c0        ret
 >   ...
> ----

Thanks for the example.

The large structure is not a stacked argument from the point of view of 
the PCS parameter passing algorithm (which explicitly says how large 
composite types will be allocated). Instead it looks like it has been 
implicitly passed-by-reference and the caller makes this appear as 
call-by-value by allocating from its own stack frame rather than from 
the stacked argument space. The callee joins in by implicitly 
dereferencing the pointer.

It is interesting to note that you force large_func() to stack its 
arguments (by providing 8 dummy int arguments first) then the implicit 
pass-by-reference behavior is still preserved even for a stacked 
argument; large_func() ends up as:

~~~
large_func:
	ldr	x0, [sp]
	ldr	x0, [x0]
	ret
~~~

Only thing is... I *still* haven't found anything in the AArch64 PCS 
which describes this behavior.

I'm coming to believe that this is a mistake and this information (and 
the threshold at which implicit pass-by-reference kicks in) should be 
documented in section 7.

Or if you prefer the short version: I agree 100% with your analysis but 
cannot find the document that supports it.


Daniel.
