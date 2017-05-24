From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 May 2017 09:07:45 -0700
Subject: [RFC PATCH v2 0/2] Simplify kernel-mode NEON
In-Reply-To: <20170524155431.GN3559@e103592.cambridge.arm.com>
References: <1495636986-30515-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu-QoRkJysYpnzw-=fmEkuajDcFY77T28CLE0JjwogQWnA@mail.gmail.com>
 <20170524155431.GN3559@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_YjxgYGQjG4tip8Y2ZSWrQHjeo47douTLeXSUSfO6Z=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2017 at 08:54, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, May 24, 2017 at 08:29:06AM -0700, Ard Biesheuvel wrote:
>> On 24 May 2017 at 07:42, Dave Martin <Dave.Martin@arm.com> wrote:
>> > This series aims to simplify kernel-mode NEON.
>> >
>> > The main motivation for these changes is that supporting kernel-mode
>> > NEON alongside SVE is tricky with the current framework: the current
>> > partial save/restore mechanisms would need additional porting to
>> > save/restore the extended SVE vector bits, and this renders the cost
>> > saving of partial save/restore rather doubtful -- even if not all vector
>> > registers are saved, the save/restore cost will still grow with
>> > increasing vector length.  We could get the mechanics of this to work in
>> > principle, but it doesn't feel like the right thing to do.
>> >
>> > If we withdraw kernel-mode NEON support for hardirq context, accept some
>> > extra softirq latency and disable nesting, then we can simplify the code
>> > by always saving the task context directly into task_struct and
>> > deferring all restore to ret_to_user.  Previous discussions with Ard
>> > Biesheuvel suggest that this is a feasible approach and reasonably
>> > aligned with other architectures.
>> >
>> > The main impact on client code is that callers must check that
>> > kernel-mode NEON is usable in the current context and fall back to a
>> > non-NEON when necessary.  Ard has already done some work on this. [1]
>> >
>> > The interesting changes are all in patch 2: the first patch just adds a
>> > header inclusion guard that I noted was missing.
>> >
>> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git kernel-mode-neon
>> >
>> >
>> > I've only build-tested so far.
>> >
>> > Ard, do you have any suggestions for how to test these changes
>> > effectively?
>> >
>>
>> IIRC, a zd1211 based USB wifi stick will use the mac80211 crypto
>
> Do you have one of those?
>

Yes, I should still have one. I am currently travelling but I will
take a look when I get back.

>> routines that execute in softirq context (and I am sure there are
>> others). If you run a VPN over that, and only enable a single CPU, I
>> would expect most code paths to get exercised when pushing a lot of
>> data over that. In userland, you can run something like 'openssl speed
>> -evp aes-128-ctr' in a loop to exercise the userland part, although it
>> would be better to check the correctness as well (which 'speed' will
>> not do for you)
>
> Another approach would be to hack up a softirq irritator that just does
>
>         kernel_neon_begin()
>
>         /* write garbage to FPSIMD regs */
>
>         kernel_neon_end()
>
> alongside some userspace test that will spot corruption.
>
>
> Writing softirq handlers seems to be a bit of a black art though...
> I was wondering whether it would make sense to hack something into
> the timer softirq code, but I'm not well clued-up on how that stuff
> works.
>

That should work as well, I suppose.
