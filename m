From: robherring2@gmail.com (Rob Herring)
Date: Sat, 5 Jul 2014 16:26:42 -0500
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140702161649.GF24879@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk> <20140702100133.GE18731@arm.com>
 <CAMbhsRSm_o78X-+2mfgUfR7pwgaDob75Lcvjfck50kHcagX=cQ@mail.gmail.com>
 <20140702161649.GF24879@arm.com>
Message-ID: <CAL_JsqJ__Op1FmDCW1o-UuUqHbH858Yzx8bEhxL1wgvnbbsE=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 11:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Colin,
>
> On Wed, Jul 02, 2014 at 04:48:07PM +0100, Colin Cross wrote:
>> On Wed, Jul 2, 2014 at 3:01 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Wed, Jul 02, 2014 at 12:48:00AM +0100, Mark Brown wrote:
>> > > On Tue, Jul 01, 2014 at 04:42:01PM -0700, Olof Johansson wrote:
>> > > > On Tue, Jul 1, 2014 at 4:06 PM, Colin Cross <ccross@google.com> wrote:
>> > > > > Would you consider taking support for SWP emulation, enabling CP15
>> > > > > barriers (CP15BEN bit only until there's a real device that needs
>> > > > > emulation, also requires clearing COMPAT_PSR_E_BIT in
>> > > > > compat_setup_return) and enabling SETEND, all behind a default-off
>> > > > > CONFIG_DEPRECATED_ARMV7_COMPAT?
>> > >
>> > > > It sounds really silly to push back against this, since it's actually
>> > > > needed by so many platforms out there.
>> >
>> > The big problem with emulating instructions that don't even appear in the
>> > hardware anymore is that we end up creating baggage which we can *never*
>> > remove.
>> >
>> > I'm against SWP emulation in the kernel for a number of reasons:
>> >
>> >   (1) The hardware doesn't have the instruction at all. If we start
>> >       emulating it, then we'll always have to emulate it and it doesn't
>> >       encourage software migration.
>> >
>> >   (2) I'm not convinced that it can't be handled in userspace by trapping
>> >       the SIGILL and emulating there (admittedly, this sounds difficult).
>> >
>> >   (3) The usual uses of SWP are in homebrew locking implementations and
>> >       are almost certainly a _bug_. For those v7 CPUs that could do SWP,
>> >       it's not even guaranteed to be atomic iirc. Trapping and emulating
>> >       is also bad for performance (although I note that Colin made an
>> >       argument that it was acceptable).
>> >
>> >   (4) This only affects legacy binaries. Should we also try to support OABI?
>> >       How about misaligned ldm/stm? We have to draw the line somewhere.
>>
>> The problem is that we (Android) have to draw the line somewhere else
>> - there are too many highly visible apps in the app store that still
>> use these instructions.  When we add them back to our kernels, then we
>> are no longer ABI compatible with an upstream kernel.
>
> For an ARMv7 kernel, this is still controlled by CONFIG_SWP_EMULATE, so
> you would have the exact same issues with kernels where that has been turned
> off. You assumedly have a bunch of patches on top of mainline for Android; I
> don't understand why this one is any different.

So we don't want any vendor patches either since they already have
other patches in their kernels? Avoiding more patches for Android is a
good thing. And don't worry, we will find something else for John S to
do.

>> > The CP15 barriers are a more interesting case, as the CPUs can *currently*
>> > support those if we flip a bit in the SCTLR. However, I see that as a
>> > slippery slope to emulation if CPUs stop supporting those instructions in
>> > the future (they almost certainly will).
>>
>> I agree that this will likely lead to emulation when a CPU
>> manufacturer eventually decides to leave out hardware support,
>> although hopefully they won't if they see that the bit is set in SCTLR
>> on all Android devices.
>
> ... and what if/when people start building AArch64-only CPUs? Are we going to
> emulate the entire AArch32 instruction set in the kernel? Or just the
> deprecated/obsolete subset of that ;)

That is requirement on Si vendors, not application developers. They
are different orders of magnitude. I imagine if this was a matter of
fixing 10 apps, then this would not be being discussed.

Rob
