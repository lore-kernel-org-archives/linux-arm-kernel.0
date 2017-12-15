From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Dec 2017 16:56:48 +0100
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <20171215142732.GL25650@arm.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <CAMuHMdWH=3kRmwjDHsTzUVmB7=s5cnY16Ujfroe_B6dawGSDfw@mail.gmail.com>
 <20171214152431.GC12608@e103592.cambridge.arm.com>
 <CAMuHMdXx-8+g5Xf0UtuYu71+K8Pz9CyQe=ifzzOWVRB1KpMGcg@mail.gmail.com>
 <20171215112343.GR22781@e103592.cambridge.arm.com>
 <CAMuHMdWio0KnJc3DQeQyf-MHpDC=tc3cJLNK7MmaL=MdDz45UQ@mail.gmail.com>
 <20171215142732.GL25650@arm.com>
Message-ID: <CAMuHMdW7gxNo=6QwsENid=NBV9PrwcukL2L2tPed8OvyyFvckA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 3:27 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Dec 15, 2017 at 02:30:00PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Dec 15, 2017 at 12:23 PM, Dave Martin <Dave.Martin@arm.com> wrote:
>> > The two important differences here seem to be
>> >
>> > 1) Staging the state via current->thread.fpsimd_state instead of loading
>> > directly:
>> >
>> > -       fpsimd_load_state(state);
>> > +       current->thread.fpsimd_state = *state;
>> > +       fpsimd_load_state(&current->thread.fpsimd_state);
>>
>> The change above introduces the breakage.
>
> I finally managed to reproduce this, but only by using the exact same
> compiler as Geert:
>
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/x86_64-gcc-4.9.0-nolibc_aarch64-linux.tar.xz
>
> I then reliably see the problem if I run:
>
>   # /usr/bin/update-ca-certificates
>
> from Debian Jessie.
>
> Note that my normal toolchain (Linaro 7.1.1 build) works fine and also
> if I use the toolchain above but disable CONFIG_ARM64_CRYPTO then things
> work too.
>
> So there's some toolchain-specific interaction between this change and the
> crypto code...
>
> Will



-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
