From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Oct 2016 16:53:25 +0100
Subject: [PATCH 2/3] ARM: convert to generated system call tables
In-Reply-To: <13702107.LdHY4HTXyY@wuerfel>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
 <13702107.LdHY4HTXyY@wuerfel>
Message-ID: <20161019155325.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 05:30:49PM +0200, Arnd Bergmann wrote:
> On Tuesday, October 18, 2016 8:31:38 PM CEST Russell King wrote:
> > Convert ARM to use a similar mechanism to x86 to generate the unistd.h
> > system call numbers and the various kernel system call tables.  This
> > means that rather than having to edit three places (asm/unistd.h for
> > the total number of system calls, uapi/asm/unistd.h for the system call
> > numbers, and arch/arm/kernel/calls.S for the call table) we have only
> > one place to edit, making the process much more simple.
> > 
> > The scripts have knowledge of the table padding requirements, so there's
> > no need to worry about __NR_syscalls not fitting within the immediate
> > constant field of ALU instructions anymore.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Ah, very nice!
> 
> I have some vague plans to do something like this for all architectures,
> so having it done for one of the more complex examples (there are very
> few architectures with more than one table) simplifies it a lot.
> 
> The next step is probably to do it for asm-generic/unistd.h, which
> covers a lot of architectures, and then we can introduce a shared
> table for all future additions so we only have to add the new calls
> in one place, and change the scripts so they can merge two input
> files into one.

Architecture maintainers like to verify that the system call works on
their architecture before they push it out into the wild; your idea
effectively bypasses architecture maintainer review and testing, so
is bad.  For something as critical as system call interfaces, that
step is critical: introducing a new system call across all architectures
that then fails to work correctly on a particular architecture invites
userspace to work around the problem, and the brokenness then becomes
user API which can't be fixed.

> > +# Where abi is:
> > +#  common - for system calls shared between oabi and eabi
> > +#  oabi   - for oabi-only system calls (may have compat)
> > +#  eabi   - for eabi-only system calls
> 
> Why do we need all three? I would have guessed that these two are
> sufficient to cover all cases:
> 
> arm	- one entry for eabi, optional second entry for oabi if different
> oabi	- only one entry for oabi, syscall is not used on eabi

You haven't quite understood if you think the second entry gets used
for OABI - but that's not surprising because the issues here are
quite complex.

For OABI-only, all the oabi and first entry in common gets used.
For EABI-only, all the eabi and first entry in common gets used.
For EABI with OABI compat, EABI uses eabi and the first entry in common,
but the OABI compat table uses the oabi and common entries, prefering
the second entry where present.

Yes, for the cases where we list the oabi and eabi together like you
quoted, currently there are no differences between the system calls,
and in my latest version, they've already been modified down to just
a single "common" entry, leaving us without any eabi entries.
However, I want to retain the ability to have separate eabi entries
if needs be.  Such a case would be a system call which needs a helper
for arguments passed in >4 registers on EABI but not OABI (eg, because
of an non-naturally aligned 64-bit quantity passed in r1/r2 on OABI
but r2/r3 in EABI.)

You'll find the latest version in the next linux-next, or my current
for-next branch.

> > diff --git a/arch/arm/tools/syscallhdr.sh b/arch/arm/tools/syscallhdr.sh
> > new file mode 100644
> > index 000000000000..72d4b2e3bdec
> > --- /dev/null
> > +++ b/arch/arm/tools/syscallhdr.sh
> 
> The scripts are still very similar to the x86 version. Any chance
> we can move them to a top-level scripts/syscall/ directory and make
> them work for both architectures? It would be good to avoid duplicating
> them for all the other architectures too, so starting out with a common
> version could make that easier.

The fileguard prefix would have to be specified as an additional
argument to achieve that, but I don't see that as a big problem.

The syscalltbl.sh script is particularly architecture specific, as
our "compat" isn't the same as x86's "compat" requirements.

The syscallnr.sh script kind-of looks like a candidate, but it has
ARM arch specifics to it (knowing that the number of system calls
needs to fit within the 8-bit value plus 4-bit shift constant
representation of ARM ALU instructions.)  Maybe a generic version
without that knowledge would work, provided architectures can
override it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
