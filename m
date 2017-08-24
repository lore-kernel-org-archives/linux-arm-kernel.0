From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 24 Aug 2017 12:51:22 +0530
Subject: [PATCH v2 00/20] rpmsg: glink: Add glink smem based transport
Message-ID: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The glink protocol works with a shared-memory(transport) for
communication between the local and remote processors. The
existing glink-rpm driver implements the basic features
of the protocol and uses msgram as the transport.

The same is extended to support smem based transport as well.
The first few patches consolidates the code, so that the
core protocol code is made common for both the types of
transport.

The next set of patches adds the additional features of the
protocol required by clients using smem based transport,
particularly support for intents.

 * What is intents ?
	Intents are nothing but pre-allocated buffers that
	both the local and the remote clients allocate and
	share the details (about the buffer size and an id)
	before intending to receive data. The transmitter then
	searches for an suitable 'intent-id' based on size from
	the list that it was notified previously and sends the data
	targeting that intent buffer, which is then copied by the
	receiver in to the same intent-buffer. So this avoids memory
	allocation stalls on copy based transports.

[V2]
        Fixed review comments and a race condition when the remote
        device goes down. Added 2 small patches for fixing the same.
        Previous version is here [1]

[1] https://www.spinics.net/lists/arm-kernel/msg601119.html

Bjorn Andersson (7):
  rpmsg: glink: Rename glink_rpm_xx functions to qcom_glink_xx
  rpmsg: glink: Associate indirections for pipe fifo accessor's
  rpmsg: glink: Split rpm_probe to reuse the common code
  rpmsg: glink: Move the common glink protocol implementation to
    glink_native.c
  rpmsg: glink: Allow unaligned data access
  rpmsg: glink: Introduce glink smem based transport
  rpmsg: glink: Make RX FIFO peak accessor to take an offset

Sricharan R (13):
  rpmsg: glink: Return -EAGAIN when there is no FIFO space
  rpmsg: glink: Do a mbox_free_channel in remove
  rpmsg: glink: Fix default case while handling received commands
  rpmsg: glink: Add support for transport version negotiation
  rpmsg: glink: Fix idr_lock from mutex to spinlock
  rpmsg: glink: Add support for TX intents
  rpmsg: glink: Use the local intents when receiving data
  rpmsg: glink: Add rx done command
  rpmsg: glink: Add announce_create ops and preallocate intents
  rpmsg: glink: Receive and store the remote intent buffers
  rpmsg: glink: Use the intents passed by remote
  rpmsg: glink: Request for intents when unavailable
  rpmsg: glink: Handle remote rx done command

 drivers/rpmsg/Kconfig             |   16 +-
 drivers/rpmsg/Makefile            |    2 +
 drivers/rpmsg/qcom_glink_native.c | 1611 +++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/qcom_glink_native.h |   45 ++
 drivers/rpmsg/qcom_glink_rpm.c    | 1026 ++---------------------
 drivers/rpmsg/qcom_glink_smem.c   |  316 ++++++++
 include/linux/rpmsg/qcom_glink.h  |   27 +
 7 files changed, 2092 insertions(+), 951 deletions(-)
 create mode 100644 drivers/rpmsg/qcom_glink_native.c
 create mode 100644 drivers/rpmsg/qcom_glink_native.h
 create mode 100644 drivers/rpmsg/qcom_glink_smem.c
 create mode 100644 include/linux/rpmsg/qcom_glink.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
