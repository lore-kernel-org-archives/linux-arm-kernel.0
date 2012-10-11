From: jonathan@jonmasters.org (Jon Masters)
Date: Wed, 10 Oct 2012 20:59:38 -0400
Subject: alignment faults in 3.6
In-Reply-To: <506EEFBB.3060705@gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk> <506ED18C.3010009@gmail.com>
 <20121005140556.GQ4625@n2100.arm.linux.org.uk> <506EEFBB.3060705@gmail.com>
Message-ID: <507619FA.6080001@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

On 10/05/2012 10:33 AM, Rob Herring wrote:
> On 10/05/2012 09:05 AM, Russell King - ARM Linux wrote:
>> On Fri, Oct 05, 2012 at 07:24:44AM -0500, Rob Herring wrote:
>>> On 10/05/2012 03:24 AM, Russell King - ARM Linux wrote:
>>>> Does it matter?  I'm just relaying the argument against adding __packed
>>>> which was used before we were forced (by the networking folk) to implement
>>>> the alignment fault handler.
>>>
>>> It doesn't really matter what will be accepted or not as adding __packed
>>> to struct iphdr doesn't fix the problem anyway. gcc still emits a ldm.
>>> The only way I've found to eliminate the alignment fault is adding a
>>> barrier between the 2 loads. That seems like a compiler issue to me if
>>> there is not a better fix.
>>
>> Even so, please test the patch I've sent you in the sub-thread - that
>> needs testing whether or not GCC is at fault.  Will's patch to add the
>> warnings _has_ uncovered a potential issue with the use of __get_user()
>> in some parts of the ARM specific kernel, and I really need you to test
>> that while you're experiencing this problem.
> 
> I've tested your patch and it appears to fix things. Thanks!

Ok. I'm looking for a short term solution in the Fedora kernel because
we've been bitten by this bug (I've been following this thread). I
considered just reverting Will's patch, but that only sweeps the issue
under the rug back to where we were in our 3.4 kernel. So, should we
pull in rmk's fix? It seems there are two problems here:

1). Missaligned access fault handling atomicity in general
2). Assumptions around struct alignment that turn out not to be true at
runtime due to the way that the structs are actually then aligned.

> Now on to getting rid of faults on practically every single received IP
> packet:
> 
> Multi:          9871002
> 
> RX packets:9872010 errors:0 dropped:0 overruns:0 frame:0

This will still be a problem, indeed. At least we can be aware we're
taking a large number of faults and hope for a netdev solution.

Jon.
