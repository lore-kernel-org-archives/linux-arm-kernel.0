From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 09:34:19 +0100
Subject: [PATCH] ARM: Enter CPU in ARM state for cpu_resume
In-Reply-To: <CAKv+Gu9m3id8QPxnuCuRmmwE7sPDqvtNiWQGr1OvnOpiOCS_xw@mail.gmail.com>
References: <1433190120-27798-1-git-send-email-sboyd@codeaurora.org>
 <20150601214525.GT2067@n2100.arm.linux.org.uk>
 <CAKv+Gu9m3id8QPxnuCuRmmwE7sPDqvtNiWQGr1OvnOpiOCS_xw@mail.gmail.com>
Message-ID: <20150602083419.GW2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 08:18:18AM +0200, Ard Biesheuvel wrote:
> On 1 June 2015 at 23:45, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Please do this differently.  The default should be (as we do with
> > the SMP secondary entry path) to assume that the firmware does the
> > right thing.
> >
> > So, if we want an ARM-mode entry point, please use:
> >
> > +               .arm
> > +ENTRY(cpu_resume_arm)
> > + THUMB(        badr    r9, 1f          )       @ Kernel is entered in ARM.
> > + THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
> > + THUMB(        .thumb                  )       @ switch to Thumb now.
> > + THUMB(1:                      )
> >
> > Don't forget an ENDPROC() for the new symbol.  Buggy platforms then
> > use cpu_resume_arm instead of cpu_resume.
> >
> 
> OK, I think that was Stephen intention at first, but I suggested this instead.
> 
> The point is that it is safer and more tidy to make these entry points
> ARM only throughout, and switch to Thumb2 only if THUMB2_KERNEL. This
> way, since all firmwares (except ARMv7-M, but let's disregard that for
> now) are known to be able to enter/resume into the kernel in ARM mode,
> this is more robust in the face of new platforms and firmware
> revisions of existing platforms.

Stop creating random interfaces with differing ways to call them.
Consistency is one of the important things.

We have three interfaces to the kernel:

- Boot
- Secondary CPU
- Resume

Out of those three, boot is the special one, as we have no way to
communicate what mode it is required - so we specify a mode, which
is ARM mode, except for CPUs which have no ARM mode support.

Secondary CPU is not defined in the booting document because it's
not relevant, and it's not relevant for the same reason that the
resume entry point isn't.  These entry points are not at a fixed
location in the kernel image, and the kernel has to communicate that,
along with their entry mode to the firmware.

Therefore, firmware _does_ have the information to discover whether
the address should be called in ARM or Thumb mode, and what's more,
it should just work on those platforms which have no ARM mode support.

If we start forcing these interfaces to be ARM mode only, we then need
the same work-arounds for them as for the boot interface.

In other words, boot has a _valid_ reason to be different, the other
two are very similar in how they should be called.

Besides, I'm not pandering to broken firmware.  We should do the right
thing by default, which is to have sane interfaces, and only work around
stuff where needed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
