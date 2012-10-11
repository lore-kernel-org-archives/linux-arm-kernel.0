From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 11 Oct 2012 03:27:24 +0100
Subject: alignment faults in 3.6
In-Reply-To: <507619FA.6080001@jonmasters.org> (Jon Masters's message of "Wed,
 10 Oct 2012 20:59:38 -0400")
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com>
 <20121005140556.GQ4625@n2100.arm.linux.org.uk>
 <506EEFBB.3060705@gmail.com> <507619FA.6080001@jonmasters.org>
Message-ID: <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Masters <jonathan@jonmasters.org> writes:

> Hi everyone,
>
> On 10/05/2012 10:33 AM, Rob Herring wrote:
>> On 10/05/2012 09:05 AM, Russell King - ARM Linux wrote:
>>> On Fri, Oct 05, 2012 at 07:24:44AM -0500, Rob Herring wrote:
>>>> On 10/05/2012 03:24 AM, Russell King - ARM Linux wrote:
>>>>> Does it matter?  I'm just relaying the argument against adding __packed
>>>>> which was used before we were forced (by the networking folk) to implement
>>>>> the alignment fault handler.
>>>>
>>>> It doesn't really matter what will be accepted or not as adding __packed
>>>> to struct iphdr doesn't fix the problem anyway. gcc still emits a ldm.
>>>> The only way I've found to eliminate the alignment fault is adding a
>>>> barrier between the 2 loads. That seems like a compiler issue to me if
>>>> there is not a better fix.

This turns out to be caused by pointers being typecast to normal
(aligned) types.

>>> Even so, please test the patch I've sent you in the sub-thread - that
>>> needs testing whether or not GCC is at fault.  Will's patch to add the
>>> warnings _has_ uncovered a potential issue with the use of __get_user()
>>> in some parts of the ARM specific kernel, and I really need you to test
>>> that while you're experiencing this problem.
>> 
>> I've tested your patch and it appears to fix things. Thanks!

[...]

>> Now on to getting rid of faults on practically every single received IP
>> packet:
>> 
>> Multi:          9871002
>> 
>> RX packets:9872010 errors:0 dropped:0 overruns:0 frame:0
>
> This will still be a problem, indeed. At least we can be aware we're
> taking a large number of faults and hope for a netdev solution.

There are exactly two possible solutions:

1. Change the networking code so those structs are always aligned.  This
   might not be (easily) possible.
2. Mark the structs __packed and fix any typecasts like the ones seen in
   this thread.  This will have an adverse effect in cases where the
   structs are in fact aligned.

Both solutions lie squarely in the networking code.  It's time to
involve that list, or we'll never get anywhere.

-- 
M?ns Rullg?rd
mans at mansr.com
