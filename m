From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Tue, 27 May 2014 16:29:57 -0400
Subject: [RFC 0/2] ACPI Platform Communication Channel driver
Message-ID: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds initial support for the PCC (Platform Communication Channel)
interface as described in the current ACPI 5.0a spec. See Section 14 of the
ACPI spec - http://acpi.info/DOWNLOADS/ACPI_5_Errata%20A.pdf for more details on
how PCC works.

In brief PCC (Platform Communication Channel) is a generic means for PCC clients,
to talk to the firmware. The PCC register space is typically memory mapped IO and
uses a doorbell mechanism to communicate synchronously from the OS to the firmware.
The PCC driver is completely agnostic to the protocol implemented by the PCC clients.
It only implements the enumeration of PCC channels and the low level transport mechanism
and leaves the rest to the PCC clients.

The PCC is meant to be useable in the future by clients such as CPPC
(Collaborative Processor Performance Control), RAS (Reliability,
Availability and Serviceability) and MPST (Memory Power State Tables) and possibly others.

While the PCC clients will come as following patches whenever they're ready, I wanted
to get feedback on this common driver and hope that it could be merged upstream. This
should hopefully help various folks that are working on drivers that rely on the PCC
interface.

Cheers,
Ashwin

=== Testing Methodology ===

The PCC test driver in [2/2] is a simple driver that was used to
demonstrate how PCC clients would use the PCC driver. The PCC driver was
tested by sending multiple PCC READS and PCC WRITES across a shared memory
region on an MSM ARMv7 platform. This memory is shared between an apps processor
and a power controller processor. So, one end of the PCC channel is the PCC test driver
running on the apps processor and the other end is a debugger script
(running on a JTAG debugger) thats attached to the power processor. The debugger
script is busy looping on the doorbell address waiting for a bit to flip. This bit
indicates a synchronous communication from the apps processor. The doorbell is rung
when the OS sends a PCC READ or PCC WRITE command. The PCC communication channel
is simply a few fake 32 bit registers that are incremented by the OS and the debugger
script. The OS increments the registers and then sends the PCC WRITE command. On a PCC
READ, the script increments these registers and then OS reads them back. The values
are always incremented by 1 by either end, so we know what value to expect for each
PCC READ/WRITE.

Ashwin Chaugule (2):
  ACPI: Add support for Platform Communication Channel
  PCC Test driver

 drivers/acpi/Kconfig    |  10 +++
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/pcc-test.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pcc.c      | 192 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pcc-test.c
 create mode 100644 drivers/acpi/pcc.c

-- 
1.8.3.2
