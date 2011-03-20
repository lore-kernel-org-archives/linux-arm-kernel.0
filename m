From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Mar 2011 11:03:22 +0000
Subject: Updated mach-types update
Message-ID: <20110320110322.GC16646@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some may notice that the mach-types update in my tree has been replaced
by a new update to the file, but with a difference:

 arch/arm/tools/mach-types | 2406 ++-------------------------------------------
 1 files changed, 89 insertions(+), 2317 deletions(-)

It deletes a lot of entries.

For a while now, I've been running a script each day after a pull from
mainline which updates a flag in the machine database indicating whether
an entry has existed in mainline at any point in time.  The database also
tracks the time which the last change made to any entry.

Coupling these two bits of data together means that we can select entries
from the machine database which are or have been in mainline, and which
have been updated within the last twelve months.  The above file reflects
that, and reduces the file down to 1090 lines (including header).

What this means is that any platform in the machine database which has not
been submitted to mainline for 12 months since it was registered will be
automatically dropped from the file, and the platform maintainer will need
to either talk to me to get it reinstated before submission, or update the
entry in some way to 'freshen' it.

This does have the potential to go wrong if people start randomly changing
the format of how they write the MACHINE_START() macro.  If it's not found
by:

grep -rh --exclude=include --include='*.c' MACHINE_START arch/arm |
 grep -v '^#' | sed "s@[^(]*(\([^,]*\).*@ ('\1')@;2,\$s@^@,@"

(which generates a subset of SQL) then it won't be kept.  In other words,
one line containing _at least_ this is the safest way:

MACHINE_START(NAME,

but this definitely won't work:

MACHINE_START(
	NAME,
	"Gobovision's Funky Platform")
