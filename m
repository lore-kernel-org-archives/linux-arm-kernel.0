From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Apr 2013 11:35:10 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <20130417101906.GX14496@n2100.arm.linux.org.uk>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAFEAcA-1HAG0pY-j-rqU=QmSoep3Di-KNPATvuou8ghRn3SaqA@mail.gmail.com>
 <516810F7.7040601@arm.com> <20130417101906.GX14496@n2100.arm.linux.org.uk>
Message-ID: <516E7ADE.5090601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/13 11:19, Russell King - ARM Linux wrote:
> On Fri, Apr 12, 2013 at 02:49:43PM +0100, Marc Zyngier wrote:
>> On 12/04/13 14:40, Peter Maydell wrote:
>>> On 12 April 2013 14:24, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> Nak. The fact that one of the CPUs seem to hang is a sure sign that
>>>> something is severely broken, and you definitely want to fix that issue,
>>>> instead of blindly ignoring it.
>>>>
>>>> Additionally, it seems you're just papering over the issue. You should
>>>> be able to exclude the A7 processors, but not completely deny KVM from
>>>> running on the hardware.
>>>
>>> Well that might be nice, as would fully supporting big.LITTLE
>>> systems. But until somebody actually does that work it seems
>>> like a better idea to fail gracefully rather than having a 50%
>>> chance of failing gracefully and a 50% chance of going weird.
>>
>> Nothing prevents the kernel (or even the user) from forcing the affinity
>> of the CPU threads to the A15s. I'm not saying we should ignore the
>> problem either. Just that the proposed approach is wrong.
> 
> But nothing guarantees that you get that affinity.  If you offline all
> A15 CPUs, then you will find those threads running on whatever is left.
> Affinity is just a hint, nothing more.

I completely agree with you. But if we're left with only CPUs we can't
run on, we're screwed and must abort.

It's the same story as the RealView PB-X, where only one of the two A9
has NEON. If the NEON-capable core is down, any process using NEON is
virtually dead.

Should that be a reason to completely disable the HW (in this case the 3
A7s)? I'm not sure...

	M.
-- 
Jazz is not dead. It just smells funny...
