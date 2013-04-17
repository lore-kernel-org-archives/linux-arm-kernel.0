From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Apr 2013 12:30:25 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+gK3nitpN+8ZePRY7n+bsc2t4XbWrz6fbdz0Wjq_kTgM4g@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAFEAcA-1HAG0pY-j-rqU=QmSoep3Di-KNPATvuou8ghRn3SaqA@mail.gmail.com>
 <516810F7.7040601@arm.com>	<20130417101906.GX14496@n2100.arm.linux.org.uk>
 <516E7ADE.5090601@arm.com>
 <CAEDV+gK3nitpN+8ZePRY7n+bsc2t4XbWrz6fbdz0Wjq_kTgM4g@mail.gmail.com>
Message-ID: <516E87D1.5000109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/13 12:07, Christoffer Dall wrote:
> On Wed, Apr 17, 2013 at 3:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 17/04/13 11:19, Russell King - ARM Linux wrote:
>>> On Fri, Apr 12, 2013 at 02:49:43PM +0100, Marc Zyngier wrote:
>>>> On 12/04/13 14:40, Peter Maydell wrote:
>>>>> On 12 April 2013 14:24, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>> Nak. The fact that one of the CPUs seem to hang is a sure sign that
>>>>>> something is severely broken, and you definitely want to fix that issue,
>>>>>> instead of blindly ignoring it.
>>>>>>
>>>>>> Additionally, it seems you're just papering over the issue. You should
>>>>>> be able to exclude the A7 processors, but not completely deny KVM from
>>>>>> running on the hardware.
>>>>>
>>>>> Well that might be nice, as would fully supporting big.LITTLE
>>>>> systems. But until somebody actually does that work it seems
>>>>> like a better idea to fail gracefully rather than having a 50%
>>>>> chance of failing gracefully and a 50% chance of going weird.
>>>>
>>>> Nothing prevents the kernel (or even the user) from forcing the affinity
>>>> of the CPU threads to the A15s. I'm not saying we should ignore the
>>>> problem either. Just that the proposed approach is wrong.
>>>
>>> But nothing guarantees that you get that affinity.  If you offline all
>>> A15 CPUs, then you will find those threads running on whatever is left.
>>> Affinity is just a hint, nothing more.
>>
>> I completely agree with you. But if we're left with only CPUs we can't
>> run on, we're screwed and must abort.
>>
>> It's the same story as the RealView PB-X, where only one of the two A9
>> has NEON. If the NEON-capable core is down, any process using NEON is
>> virtually dead.
>>
>> Should that be a reason to completely disable the HW (in this case the 3
>> A7s)? I'm not sure...
>>
> But we're not talking about disabling the A7's, we're talking about
> disabling KVM/ARM, a quite new feature, on a system where it's not
> well-tested and may cause boot problems or other issues that we
> haven't investigated in depth yet.

Well, it's a choice between disabling KVM or the A7s. Cheese or dessert?
Black death or cholera?

And I go back to my earlier argument: we don't know what's going wrong.
It could be a bug in our init code, it could be the bootloader that
fails to correctly initialize the A7s in HYP mode, it could be something
else.

By disabling the problematic configuration, we just bury our head in the
sand and pretend everything is fine. Yes, this is a new feature. But by
saying "not a supported configuration", while the code *should* support
it, we're only fooling ourselves.

	M.
-- 
Jazz is not dead. It just smells funny...
