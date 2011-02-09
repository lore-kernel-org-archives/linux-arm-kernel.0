From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Feb 2011 11:07:54 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <AANLkTimDTVypBFCoO9G72TzKToAThdXm_aEi56O+w9nY@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081642.52774.arnd@arndb.de>
	<AANLkTimDTVypBFCoO9G72TzKToAThdXm_aEi56O+w9nY@mail.gmail.com>
Message-ID: <201102091107.54917.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011, Dave Martin wrote:
> I have a (possibly silly) question ... are the definitions in
> arm/system.h intended to be fully generic, or not?  Some features
> suggest an attempt at genericness, but not everything there is
> generic.  Maybe I have misconstrued the purpose of this header.

asm/system.h contains an ill-defined set of random stuff derived
from what used to be in there in the old days Linux-1.x and
whatever the individual architectures added to it.

There have been previous attempts to reduce the common stuff
and leave only architecture-specific definitions in there, but
it still contains for all architectures at least:

* switch_to()
* mb() and friends
* cmpxchg() and friends

These are hard to change, because each architecture has slightly
different rules for recursive header file inclusion, so you end
up breaking stuff when you touch them.

The other declarations and macros are arch specific, so we could
move them to a different place or change them if there is a good
reason to do that.

I personally think it would be good to have at least cmpxchg and
everything related to it in a separate header, like a few
architectures do (x86, sh, alpha, mips), but I don't see too
much value in doing that just on ARM while leaving the other
architectures alone.

	Arnd
