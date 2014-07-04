From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 14:31:35 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704125615.CC2E2C40A89@trevor.secretlab.ca>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
 <20140703183055.GC32514@n2100.arm.linux.org.uk>
 <20140704085745.GB16404@arm.com>
 <20140704092519.GC21766@n2100.arm.linux.org.uk>
 <20140704125615.CC2E2C40A89@trevor.secretlab.ca>
Message-ID: <20140704133135.GH21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 01:56:15PM +0100, Grant Likely wrote:
> On Fri, 4 Jul 2014 10:25:19 +0100, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Fri, Jul 04, 2014 at 09:57:45AM +0100, Catalin Marinas wrote:
> > > On Thu, Jul 03, 2014 at 07:30:55PM +0100, Russell King - ARM Linux wrote:
> > > > Even with SWP_EMULATE enabled and with the debug problem fixed... does
> > > > it help warn people?  Only if you're running on a CPU with virtualisation
> > > > extensions, because it silently continues to work on CPUs without.
> > > 
> > > Some clarification here. The virtualisation extensions made SWP
> > > _optional_ (i.e. it may not be present at all). The ARMv7
> > > multiprocessing extensions introduced the possibility to disable/trap
> > > SWP via the SCTLR.SW bit because it was no longer atomic. So basically
> > > native SWP only works (as expected, atomically) on ARMv7 UP and earlier.
> > 
> > Yes, but we've cocked this up - on ARMv7 SMP, we don't force SWP to be
> > enabled.  So, you may have SWP in hardware, which may not be atomic,
> > but as everyone seems to have SWP_EMULATE /disabled/ we don't know
> > whether the instruction even exists in any programs or libraries.
> > 
> > It may be that it's been completely eliminated, but we don't know that,
> > because we've never had the trapping enabled for SMP systems.
> > 
> > On the flip side (as I mentioned to Will) I don't think the situation is
> > quite as serious as Grant makes it out to be for Android.
> > 
> > There, the user base is already used to apps which don't work with new
> > Android devices.  For example, despite Android scaling the graphics to
> > the screen size, there are apps that don't work merely because the screen
> > is bigger, and the play store knows this and doesn't offer them.  However,
> > it /is/ still possible to install them (and some people have) by
> > downloading the .apk file and putting that on SD card.  In this case,
> > the app (a game) worked perfectly except that the game controls were at
> > an absolute screen position rather than a scaled position, which is why
> > the game was no longer offered for the later devices.
> 
> I don't think I'm wrong about how serious the issue is. Read through
> Colin's email again. He is talking about exactly the situation that I
> described.
> 
> Nor do I think that "the user base is already used to app which don't
> work" is even remotely a good justification for allowing things to
> continue to suck. Android has matured a lot since the early days, and
> the compatibility problems that plagued the early devices don't happen
> so much anymore.

My points are based upon a lengthy discussion last night with a friend who
is on the front line support of a major retailer of mobiles and tablets,
whom I've known for a number of years.

There's lots of cases where apps are not presented for later devices,
and this is the standard model there.

While we can say that it shouldn't happen, that's not reality.  As I
pointed out, apps can become incompatible just because your device has
a different sized screen.  Would you really argue that the screen is
part of the ABI and thus should never change because it might break
some Android app?

What I'm pointing out is that the Linux philosophy is a good one (and
don't get me wrong, it's something that we /should/ strive for -
especially as we haven't done enough to warn people about SWP going
away), it doesn't appear to translate to the Android space.

I'm pretty sure that there will be a whole truck load of issues which
will stop apps working on an ARMv8 phone, and the lack of SWP is
going to be soo drowned out in the noise of everything else.

Also, as we haven't forced SWP_EMULATE to be enabled on SMP, if there
/are/ users of the instruction on SMP kernels, they're already broken
(though, the instruction may still execute, it won't execute
atomically there, and so is useless for locking or atomic exchanging
purposes.)

I'm about to push a number of changes out today though:

1. save where the last kernel misaligned fault happened (we have a
   64-bit one one in nsm_init_private) and report via /proc/cpu/alignment.

2. ensure that SWP_EMULATE is forced on for SMP configurations.

3. log and save SWP emulation use via kernel log and /proc/cpu/swp_emulate.

4. kill HWCAP_SWP when we don't want people using the SWP instruction.

(4) is pretty worthless anyway, because we haven't done that from the
start - which means userspace can't make decisions based upon that
hwcap whether they can or can't use this instruction.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
