From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 17 Apr 2013 10:01:56 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+gKbmbdg-xX2Zf5febaeJv5TzLdLZZ5ZrEX9xGc0zsdZQw@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <1366071996.10931.15.camel@smoke>
 <CAEDV+gKbmbdg-xX2Zf5febaeJv5TzLdLZZ5ZrEX9xGc0zsdZQw@mail.gmail.com>
Message-ID: <516E56F4.1070705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 06:24 PM, Christoffer Dall wrote:
> On Mon, Apr 15, 2013 at 5:26 PM, Geoff Levand <geoff@infradead.org> wrote:
>> On Sun, 2013-04-14 at 21:57 -0700, Christoffer Dall wrote:
>>> On Fri, Apr 12, 2013 at 6:24 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> Nak. The fact that one of the CPUs seem to hang is a sure sign that
>>>> something is severely broken, and you definitely want to fix that issue,
>>>> instead of blindly ignoring it.
>>>>
>>>> Additionally, it seems you're just papering over the issue. You should
>>>> be able to exclude the A7 processors, but not completely deny KVM from
>>>> running on the hardware.
>>>>
>>> Marc, I disagree with this nak. If the current kernel breaks boot on a
>>> Big.Little system, we need to take care of that first, and the
>>> proposed patch is a quick way to do so, and it does not stand in the
>>> way of introducing proper Big.Little support in any way, which I'm
>>> sure is going to open up a lot of other interesting questions.
>>>
>>> I'm going to take this one.
>>
>> Since this problem will cause the 3.9 kernel to hang then a workaround
>> like this should go in.  There isn't enough time to do a proper fix for
>> 3.9, and even if it could be done I think it would be too intrusive to
>> get merged this late.
>>
> That's why I was inclined to take the patch, but as Marc pointed out
> the error message is incorrect, so that should be fixed at the very
> least. Also I don't think we need the counting logic, just bail out if
> we have any CPUs that are not supported.

The counting logic is just to prevent an erroneous hint message. If 
Cluster 0 is A7, the first CPU checked will fail, the counter is 0 and 
KVM outputs the "Target CPU not supported!" message.
But if at least one CPU already passed the test, we have a) a b.L system 
and b) restricting the number of CPUs with maxcpus= would help.
Thus the hint at this point.

But I am OK with removing both the hint message and the counting 
altogether, if you want to have an easier patch.

Regards,
Andre.

> Marc, since you're the strongest opponent of this patch, are you still
> opposed to making sure we don't try to run KVM on Big.Little until
> support is properly introduced?
>
> I also cannot see how we can fix the affinity issue easily from within
> the kernel, do you have a concrete approach in mind you can share?
>
> Note that this is irrespective of the boot delay issue that you guys
> are observing.
>
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
>
