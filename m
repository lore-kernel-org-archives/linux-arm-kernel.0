From: wolfgang.betz@st.com (Wolfgang BETZ)
Date: Thu, 14 Jul 2011 11:33:09 +0200
Subject: [PATCH 0/1 V2] Add Thread Support for the Context ID Register of
	ARM v6 & v7 Architectures
Message-ID: <cover.1310544641.git.wolfgang.betz@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfgang Betz <wolfgang.betz@st.com>

The Context ID Register, CONTEXTIDR, identifies the current:
- Process Identifier (PROCID) &
- Address Space Identifier (ASID).

The value of the whole of this register is called the Context ID and is 
used by:
- the ARM debug logic, for Linked and Unlinked Context ID matching
  (e.g. for breakpoint debug and watchpoint debug events).
- the trace logic, to identify the current process.

The CONTEXTIDR is a 32-bit read/write register whose format is:
- PROCID, bits [31:8]
  Process Identifier. This field should be programmed with a unique 
  value that identifies the current process and is used by the trace logic and 
  the debug logic to identify the process that is running currently.
- ASID, bits [7:0]
  Address Space Identifier. This field must be programmed with the 
  value of the current ASID and is used by many memory management functions.

This change-set aims at:
- implementing thread tracing support based on the armv6 & v7 CONTEXTIDR 
  register while leaving the Linux kernel ASID functionality (semantically)
  unchanged.
- focusing on compatibility with tracing tools such as Lauterbach's 
  TRACE32 tool.
- the avoidance of platform specific calls in generic code.
- simplicity, readability, and good performances.
- being general: i.e. the change-set applies to all armv7/v6 platforms &
  is in general compilable for all (other) platforms.

The patch has been jointly developed by 
Lauterbach GmbH (http://www.lauterbach.com) and 
STMicroelectronics Srl (http://www.st.com/). 
Main contributors are:
- Khaled Jmal <khaled.jmal@lauterbach.com>
- Rudi Dienstbeck <Rudolf.Dienstbeck@Lauterbach.com>
- Wolfgang Betz <wolfgang.betz@st.com>


Wolfgang Betz (1):
  Add Thread Support for the Context ID Register of ARM v6 & v7
    Architectures

 arch/arm/Kconfig.debug             |   13 +++++++
 arch/arm/include/asm/mmu_context.h |   63 +++++++++++++++++++++++++++++++----
 arch/arm/kernel/smp.c              |    2 +-
 arch/arm/mm/context.c              |   42 +++++++++++++++++++++++-
 arch/arm/mm/proc-v6.S              |    1 -
 arch/arm/mm/proc-v7.S              |    1 -
 6 files changed, 109 insertions(+), 13 deletions(-)

-- 
1.7.4.4
