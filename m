From: ahs3@redhat.com (Al Stone)
Date: Tue, 26 Sep 2017 16:23:21 -0600
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
Message-ID: <20170926222324.17409-1-ahs3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As ARMv8 servers get deployed, I keep getting the same set of questions
from end-users of those systems: what do all the hex numbers mean in 
/proc/cpuinfo and could you make them so I don't have to carry a cheat
sheet with me all the time?

These patches respond to those questions.  For good or ill, some of the
automation used to manage systems in data centers (as well as many of
the humans involved) need to have text; this helps them simply slide 
into place and become usable quickly.

Patch 1/2 provides the MPIDR as basic topology info in /proc/cpuinfo
when using ACPI, perhaps until such time as the more robust ACPI
implementation is available [0]; this is helpful in automating the
selection of multi-CPU systems when many choices are available (for
example, in automated testing systems).  While it is yet another hex
value, it does provide some topology information without interfering
with what [0] will ultimately provide, and is helpful in sorting out
ACPI table issues that use the MPIDR for identifying CPUs.

Patches 2/3 and 3/3 are similar in that they provide a more human-
readable version of the info already available; this allows admin
tools to provide proper strings to display in inventory systems, for
example, or when a human is using a CI system and needs to be provided
a list of possible systems to test on.

In all of the patches, I have avoided replacing or interfering with
any existing output so as not to affect systems already in use.

Tested on AMD Seattle, APM Mustang and Cavium ThunderX systems.


[0] https://marc.info/?l=linux-pm&m=150584702021552&w=2


Al Stone (3):
  arm64: cpuinfo: add MPIDR value to /proc/cpuinfo
  arm64: cpuinfo: add human readable CPU names to /proc/cpuinfo
  arm64: cpuinfo: display product info in /proc/cpuinfo

 arch/arm64/include/asm/cpu.h |   1 +
 arch/arm64/kernel/cpuinfo.c  | 225 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+)

-- 
2.13.5
