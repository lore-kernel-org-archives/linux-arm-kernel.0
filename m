From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 20:15:32 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703171356.GD28175@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com>
Message-ID: <4840595.cpHbY6hJKL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 July 2014 18:13:56 Catalin Marinas wrote:
> > not wanting to pollute their nice clean
> > ARM64 kernel with ARM32 "legacy junk", the fact of the matter is that
> > even the CPU is already polluted with the legacy ARM32 stuff - it
> > supports ARM32 binaries.
> 
> It's not about polluting the kernel (I've seen at least one incarnation
> of such patch and, as you said, it's small), but rather setting some
> limit on how much "legacy" we add to the arm64 kernel and commit to
> maintain long term. Our stance has always been that only non-deprecated
> ARMv7 features are supported by arm64 compat (that's why I don't buy the
> breaking user-space argument). Let's say we allow non-deprecated ARMv5
> features as well (SWP), how far back to we go? I doubt anyone thinks
> ARMv4 and OABI is still needed on an arm64 kernel.

Again, the rule is that we don't break things. The request came from
Android because they have binaries that go back to ARMv5. They don't
have binaries going back to ARMv4, and they never had OABI, so it would
be pointless to go back that far.

For any of the regular non-embedded distros, they seem to be fairly
eager to break backwards compatibility on a binary level already,
so it's also very likely that they'd be interested in ARMv4 or OABI
compatibility.

If a real use case for those came up, we'd probably have to talk
about the trade-offs. I'd assume even if actual users were hurt by
the lack of OABI support on ARMv8 (which I assume they are not),
I would likely still argue that supporting it is too hard. The
security implications of supporting another (rarely used) ABI
should be enough for this.

> > However, we /do/ need the CP15 barrier instructions as well.  We,
> > as kernel developers, have omitted to provide a way to tell userspace
> > whether the CP15 barrier instructions are available, *and* whether
> > the new barrier instructions are there too.  So, like it or not, it
> > is /our/ failing as kernel developers that userspace is running into
> > these issues, and it is /our/ responsibility to make sure that
> > userspace does not break, irrespective of what path is chosed by
> > the raw CPU support.
> 
> Such barriers currently only require an SCTLR_EL1 bit to be set. But
> what do we do in future version of the architecture if they are no
> longer present? I guess we start emulating them (or NAK architectural
> attempts at removing them, though that's not always successful and on
> some occasions for good reasons).

I'd vote for having a kernel option to choose between either leaving the
bit (a) enabled, or (b) leaving it disabled and putting a nasty warning
(e.g. WARN_ON_ONCE()) out on the console or (c) printing that warning
and also aborting the task. There are use cases for all of them.

It might be good to have a sysctl control, at least a global one that
turns all instruction emulation off.

> The main argument on this thread is about how far back in the
> architecture roadmap should the arm64 kernel support/emulate. Do we need
> to have a plan in place for eventually removing such emulation (like
> maybe even making the emulation slower and slower)?

The default answer is "as long as anybody is using it". I had the
same idea with making it gradually slower but in reality that isn't
going to help. I think the best option is to make it easy to find
and debug any application that is using deprecated instructions so
people stop relying on them, and encourage distros to turn the emulation
code off as soon as they are ready.

	Arnd
