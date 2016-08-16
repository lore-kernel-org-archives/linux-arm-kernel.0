From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:06 -0700
Subject: [PATCH 00/14] Split rpmsg into a framework
Message-ID: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series splits the virtio rpmsg bus driver into a rpmsg bus and a virtio
backend/wireformat.


As we discussed the Qualcomm SMD implementation a couple of years back people
suggested that I should make it "a rpmsg thingie". With the introduction of the
Qualcomm 8996 platform, we must support a variant of the communication
mechanism that share many of the characteristics of SMD, but are different
enough that it can't be done in a single implementation. As such there is
enough benefit to do the necessary work and being able to make SMD a "rpmsg
thingie".

On-top of this series I have patches to switch the current smd clients over to
rpmsg (and by that drop the existing SMD implementation).

All this allows me to implement the new backend and reuse all existing SMD
drivers with the new mechanism.

Bjorn Andersson (14):
  rpmsg: Enable matching devices with drivers based on DT
  rpmsg: Name rpmsg devices based on channel id
  rpmsg: rpmsg_send() operations takes rpmsg_endpoint
  rpmsg: Internalize rpmsg_send() implementations
  rpmsg: Unify rpmsg device vs channel naming
  rpmsg: Indirect all virtio related function calls
  rpmsg: Split off generic tail of create_channel()
  rpmsg: Split rpmsg core and virtio backend
  rpmsg: Internalize rpmsg core ops
  rpmsg: virtio: Internalize vrp pointer
  rpmsg: Move virtio specifics from public header
  rpmsg: Make rpmsg_create_ept() take channel_info struct
  rpmsg: Allow callback to return errors
  rpmsg: Introduce Qualcomm SMD backend

 drivers/rpmsg/Kconfig            |   14 +
 drivers/rpmsg/Makefile           |    4 +-
 drivers/rpmsg/qcom_smd.c         | 1448 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_core.c       |  525 ++++++++++++++
 drivers/rpmsg/rpmsg_internal.h   |   63 ++
 drivers/rpmsg/virtio_rpmsg_bus.c |  483 +++++--------
 include/linux/rpmsg.h            |  242 +------
 7 files changed, 2268 insertions(+), 511 deletions(-)
 create mode 100644 drivers/rpmsg/qcom_smd.c
 create mode 100644 drivers/rpmsg/rpmsg_core.c
 create mode 100644 drivers/rpmsg/rpmsg_internal.h

-- 
2.5.0
