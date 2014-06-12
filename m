From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Jun 2014 12:48:09 -0400
Subject: [RFC v2 0/3] ACPI Platform Communication Channel driver
Message-ID: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
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


=== Changelog ===

Changes since V1:

-	Integration with Mailbox framework - https://lkml.org/lkml/2014/5/15/49


Ashwin Chaugule (3):
  Mailbox: Add support for ACPI
  ACPI: Add support for Platform Communication Channel
  PCC test driver

 drivers/acpi/Makefile              |   2 +-
 drivers/acpi/pcc-test.c            | 208 ++++++++++++++++++++++++++++++++++
 drivers/acpi/pcc.c                 | 225 +++++++++++++++++++++++++++++++++++++
 drivers/mailbox/Kconfig            |  11 ++
 drivers/mailbox/mailbox.c          | 155 ++++++++++++++++---------
 include/linux/mailbox_client.h     |   3 +
 include/linux/mailbox_controller.h |   6 +
 7 files changed, 557 insertions(+), 53 deletions(-)
 create mode 100644 drivers/acpi/pcc-test.c
 create mode 100644 drivers/acpi/pcc.c

-- 
1.8.3.2
