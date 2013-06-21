From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 21 Jun 2013 12:08:10 +0200
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130621093311.GD6983@mudshark.cambridge.arm.com>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
 <20130621093311.GD6983@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu8FTXC9XSE4DJ2LQueJ3FKjdjv8=sjDjTETH7fq+ruNGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2013 11:33, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Jun 08, 2013 at 04:09:56AM +0100, Nicolas Pitre wrote:
>> On Fri, 7 Jun 2013, Will Deacon wrote:
>> > What's the earliest toolchain we claim to support nowadays? If that can't
>> > deal with the intrinsics then we either need to bump the requirement, or
>> > write this using hand-coded asm. In the case of the latter, I don't think
>> > the maintenance overhead of having two implementations is worth it.
>>
>> We have many different minimum toolchain version requirements attached
>> to different features being enabled already, ftrace being one of them if
>> I remember correctly.  For these Neon optimizations the minimum gcc
>> version is v4.6.
>>
>> Given that this is going to be interesting mostly to server systems, and
>> given that ARM server deployments are rather new, I don't see the point
>> of compiling a new server environment using an older gcc version.
>
> I've mulled over this, had some discussions with our toolchain guys and
> have concluded the following:
>
>   - The intrinsics are actually ok. I was sceptical at first, but I've been
>     assured that they should do a reasonable job (echoing your performance
>     figures).
>
>   - The current approach is targetting servers and isn't (yet) suitable for
>     mobile.
>
> So, given that the patches do the right thing wrt GCC version, the only
> remaining point is that we need to keep an eye out for people trying to
> re-use this stuff for mobile (likely crypto, as I mentioned earlier). When
> that happens, we should consider revisiting the benchmark/power figures.
>

OK, so a number of points have been raised in this discussion, let me
address them one by one:

Should we allow NEON to be used in the kernel?

The consensus is not to allow floating point. However, NEON is
different, as the performance gains are considerable and there is no
dependency on support code, which makes it not as hairy as
conventional (pre-v3) VFP. Also, managing the vfpstates is easily
doable if NEON is only used outside interrupt context and with
preemption disabled.


Does my series implement it correctly?

I have addressed Russell's first round of comments. Happy to take
another round if necessary.


Should we allow NEON intrinsics in the kernel?
Should we allow GCC-generated NEON in the kernel?

Only if the implementation is clear on which minimum version of GCC it
requires. We could use my examples to set a precedent on what is a
suitable way to use NEON intrinsics or the vectorizer in kernel code
(which includes coding it such that it can be reused for arm64 with no
modifications)


Is kernel mode NEON suitable for mobile?

To me, it is unclear why kernel and userland are so different in this
respect. However, kernel mode NEON is separately configurable from
Kconfig so it can be disabled at will.


Is there a point to doing a boot time benchmark to select the optimal
implementation of an algorithm?

Perhaps not but unrelated to kernel mode NEON.


Code is here
http://git.linaro.org/gitweb?p=people/ardbiesheuvel/linux-arm.git;a=shortlog;h=refs/heads/for-rmk


Regards,
Ard.
