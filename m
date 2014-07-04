From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 10:25:19 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704085745.GB16404@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
 <20140703183055.GC32514@n2100.arm.linux.org.uk>
 <20140704085745.GB16404@arm.com>
Message-ID: <20140704092519.GC21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 09:57:45AM +0100, Catalin Marinas wrote:
> On Thu, Jul 03, 2014 at 07:30:55PM +0100, Russell King - ARM Linux wrote:
> > Even with SWP_EMULATE enabled and with the debug problem fixed... does
> > it help warn people?  Only if you're running on a CPU with virtualisation
> > extensions, because it silently continues to work on CPUs without.
> 
> Some clarification here. The virtualisation extensions made SWP
> _optional_ (i.e. it may not be present at all). The ARMv7
> multiprocessing extensions introduced the possibility to disable/trap
> SWP via the SCTLR.SW bit because it was no longer atomic. So basically
> native SWP only works (as expected, atomically) on ARMv7 UP and earlier.

Yes, but we've cocked this up - on ARMv7 SMP, we don't force SWP to be
enabled.  So, you may have SWP in hardware, which may not be atomic,
but as everyone seems to have SWP_EMULATE /disabled/ we don't know
whether the instruction even exists in any programs or libraries.

It may be that it's been completely eliminated, but we don't know that,
because we've never had the trapping enabled for SMP systems.

On the flip side (as I mentioned to Will) I don't think the situation is
quite as serious as Grant makes it out to be for Android.

There, the user base is already used to apps which don't work with new
Android devices.  For example, despite Android scaling the graphics to
the screen size, there are apps that don't work merely because the screen
is bigger, and the play store knows this and doesn't offer them.  However,
it /is/ still possible to install them (and some people have) by
downloading the .apk file and putting that on SD card.  In this case,
the app (a game) worked perfectly except that the game controls were at
an absolute screen position rather than a scaled position, which is why
the game was no longer offered for the later devices.

Moreover, when you download from the play store, you are only presented
with the version which is appropriate for your device - when you buy a
new device, and you re-fetch your apps, you don't get the same version
that you've had on previous device if there's one more appropriate for
your new device.

So the Linux userspace policy doesn't really apply all that much to the
Android space - I'm not saying we shouldn't try, I'm saying that users
are already used to their apps not working on new devices for a wide
variety of reasons.

The "this app starts unexpectedly crashing (due to swp) when I install
it on a new device" shouldn't happen because they shouldn't be presented
with the app in the first place.

At least this is what I've been told by an experienced Android user and
support person (who does do things like install from .apk's...)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
