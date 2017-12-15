From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Dec 2017 14:27:32 +0000
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <CAMuHMdWio0KnJc3DQeQyf-MHpDC=tc3cJLNK7MmaL=MdDz45UQ@mail.gmail.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <CAMuHMdWH=3kRmwjDHsTzUVmB7=s5cnY16Ujfroe_B6dawGSDfw@mail.gmail.com>
 <20171214152431.GC12608@e103592.cambridge.arm.com>
 <CAMuHMdXx-8+g5Xf0UtuYu71+K8Pz9CyQe=ifzzOWVRB1KpMGcg@mail.gmail.com>
 <20171215112343.GR22781@e103592.cambridge.arm.com>
 <CAMuHMdWio0KnJc3DQeQyf-MHpDC=tc3cJLNK7MmaL=MdDz45UQ@mail.gmail.com>
Message-ID: <20171215142732.GL25650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 02:30:00PM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 15, 2017 at 12:23 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> > The two important differences here seem to be
> >
> > 1) Staging the state via current->thread.fpsimd_state instead of loading
> > directly:
> >
> > -       fpsimd_load_state(state);
> > +       current->thread.fpsimd_state = *state;
> > +       fpsimd_load_state(&current->thread.fpsimd_state);
> 
> The change above introduces the breakage.

I finally managed to reproduce this, but only by using the exact same
compiler as Geert:

https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/x86_64-gcc-4.9.0-nolibc_aarch64-linux.tar.xz

I then reliably see the problem if I run:

  # /usr/bin/update-ca-certificates

from Debian Jessie.

Note that my normal toolchain (Linaro 7.1.1 build) works fine and also
if I use the toolchain above but disable CONFIG_ARM64_CRYPTO then things
work too.

So there's some toolchain-specific interaction between this change and the
crypto code...

Will
