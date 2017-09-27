From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Sep 2017 11:34:07 +0100
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <20170926222324.17409-1-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
Message-ID: <20170927103406.GC32150@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Tue, Sep 26, 2017 at 04:23:21PM -0600, Al Stone wrote:
> As ARMv8 servers get deployed, I keep getting the same set of questions
> from end-users of those systems: what do all the hex numbers mean in 
> /proc/cpuinfo and could you make them so I don't have to carry a cheat
> sheet with me all the time?

I appreciate that /proc/cpuinfo can be opaque to end users, but I do not
believe that this is the right solution to that problem.

There are a number of issues stemming from the face that /proc/cpuinfo
is ill-defined and overused for a number of cases. Changes to it almost
certainly violate brittle de-facto ABI details people are relying on,
and there's a very long tail on fallout resulting from this. In
addition, many niceties come at an excessive maintenance cost, and are
simply unreliable as an ABI.

So, as with all other patches modifying /proc/cpuinfo, I must NAK this
series.

For the MPIDR and product info, I think we can expose this in a more
structured way (e.g. under sysfs). IIUC the product info is all derived
from DMI -- do we not expose that already?

For the human-readable names I must NAK such patches. This is an
extremely brittle ABI that cannot be forwards compatible, and comes with
hilarious political problems. This should be managed in userspace alone.

I thought tools like lscpu and lshw were intended to gather such
information for users. What are these missing today?

Thanks,
Mark.
