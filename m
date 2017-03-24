From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 12:02:05 -0700
Subject: [PATCH 3/9] arm64: mm: install SError abort handler
In-Reply-To: <20170324183051.GD10746@leverpostej>
References: <20170324144632.5896-1-opendmb@gmail.com>
 <20170324144632.5896-4-opendmb@gmail.com>
 <20170324151654.GD29588@leverpostej> <58D54DE8.9020707@gmail.com>
 <20170324173515.GB10746@leverpostej>
 <710c4142-ae20-9715-3e51-910a2073a64e@gmail.com>
 <20170324183051.GD10746@leverpostej>
Message-ID: <b6090e54-a1f8-701a-6f86-6968d3effcf8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2017 11:31 AM, Mark Rutland wrote:
> Hi Florian,
> 
> On Fri, Mar 24, 2017 at 10:53:48AM -0700, Florian Fainelli wrote:
>> On 03/24/2017 10:35 AM, Mark Rutland wrote:
>>> On Fri, Mar 24, 2017 at 09:48:40AM -0700, Doug Berger wrote:
>>>> On 03/24/2017 08:16 AM, Mark Rutland wrote:
>>>>> On Fri, Mar 24, 2017 at 07:46:26AM -0700, Doug Berger wrote:
>>>
>>>> If you would consider an alternative implementation where we scrap
>>>> the SError handler (i.e. maintain the ugliness in our downstream
>>>> kernel) in favor of a more gentle user mode crash on SError that
>>>> allows the kernel the opportunity to service the interrupt for
>>>> diagnostic purposes I could try to repackage that.
>>>
>>> If this is just for diagnostic purposes, I believe you can register a
>>> panic notifier, which can then read from the bus. The panic will occur,
>>> but you'll have the opportunity to log some information to dmesg.
>>
>> And crash the kernel? That sounds awful, FWIW the ARM/Linux kernel is
>> able to recover just fine from user-space accessing e.g: invalid
>> physical addresses in the GISB register space, bringing the same level
>> of functionality to ARM64/Linux sounds reasonable to me.
> 
> I disagree, given that:
> 
> (a) You cannot determine the (HW) origin of the SError in an
>     architecturally portable way. i.e. when you take an SError, you have
>     no way of determining what asynchronous event caused it.
> 
> (b) SError is effectively an edge-triggered interrupt for fatal system
>     errors (e.g. it may be triggered in resonse to ECC errors,
>     corruption detected in caches, etc). Even if you can determine that
>     the GISB triggered *an* SError, this does not tell you that this was
>     the *only* SError.

Correct, which is why Doug's changes allow chaining of handlers.

> 
>     If you take an SError, something bad has already happened. Your data
>     may already have been corrupted, and worse, you don't know when or
>     where specifically this occurred (nor how many times).

Sure, but that still allows you to send the correct signal to a faulting
application (unless I am missing something here).

>     
> (c) You cannot determine the (SW) origin of an SError without relying
>     upon implementation details. This cannot be written in a way that
>     does not rely on microarchitecture, integration, etc, and would need
>     to be updated for every future system with this misfeature.

Which is exactly what is being done here, with the help of platform
specific information (we would not load brcmstb_gisb.c if we were not on
a platform where it makes sense to use that HW).

> 
> (d) Even if you can determine the (SW) origin of an SError by relying on
>     IMPLEMENTATION DEFINED details, your handler needs to be intimately
>     familiar with the arch in question in order to attempt to recover.
> 
>     For example, the existing code tries to skip an ARM instruction in
>     some cases. For arm64 there are three cases that would need to be
>     handled (AArch64 A64, AArch32 A32/ARM, AArch32 T32/Thumb).
> 
>     Further, it appears to me that the existing code is broken given
>     that it doesn't handle Thumb, and given that it's skipping an
>     instruction in response to an asynchronous event -- i.e. some
>     arbitrary instruction after the one which triggered the abort.

OK, that could presumably be fixed though.

> 
> For better or worse, SError *must* be treated as fatal.

I disagree here, since this is a platform specific SError exception that
we can actually handle correctly there is a chance to actually not take
down the system on something that can be made non fatal and informative
at the same time.

> 
> As Doug stated:
> 
>     The main benefit is to help debug user mode code that accidentally
>     maps a bad address since we would never make such an egregious error
>     in the kernel ;)
> 
> This is just one of many ways a userspace application with direct HW
> access can bring down the system. I see no reason to treat it any
> differently, especially given the above points.

Partially disagree, in the absence of a way to specifically deal with
the exception, I would almost agree, but this is not the case here, we
have a piece of HW that can help us locate the problem, display an
informative message, and send a SIGBUS to the faulting application.

Anyway, I won't argue much further than that, but I certainly don't
think taking down an entire system is going to prove itself useful when
you need to deploy such a kernel to hundreds of people who have no clue
what so ever what their actual problem is in the first place. Taking a
SIGBUS and printing a message can at least allow us to say: read more
carefully, it say exactly what's wrong.
-- 
Florian
