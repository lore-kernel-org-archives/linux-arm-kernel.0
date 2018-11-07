From: elder@linaro.org (Alex Elder)
Date: Tue,  6 Nov 2018 18:32:38 -0600
Subject: [RFC PATCH 00/12] net: introduce Qualcomm IPA driver
Message-ID: <20181107003250.5832-1-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series presents the driver for the Qualcomm IP Accelerator (IPA).
The IPA is a hardware component present in some Qualcomm SoCs that
allows network functions--such as routing, filtering, network address
translation and aggregation--to be performed without active involvement
of the main application processor (AP).

Initially, these advanced features are not supported; the IPA driver
simply provides a network interface that makes the modem's LTE
network available to the AP.  In addition, support is only provided
for the IPA found in the Qualcomm SDM845 SoC.

This code is derived from a driver developed internally by Qualcomm.
A version of the original source can be seen here:
    https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree
in the "drivers/platform/msm/ipa" directory.  Many were involved in
developing this, but the following individuals deserve explicit
acknowledgement for their substantial contributions:

    Abhishek Choubey
    Ady Abraham
    Chaitanya Pratapa
    David Arinzon
    Ghanim Fodi
    Gidon Studinski
    Ravi Gummadidala
    Shihuan Liu
    Skylar Chang

The code has undergone considerable rework to prepare it for
incorporation into upstream Linux.  Parts of it bear little
resemblance to the original driver.  Still, some work remains
to be done.  The current code and its design had a preliminary
review, and some changes to the data path implementation were
recommended.   These have not yet been addressed:
- Use NAPI for all interfaces, not just RX (and WAN data) endpoints.
- Do more work in the NAPI poll function, including collecting
  completed TX requests and posting buffers for RX.
- Do not use periodic NOP requests as a way to avoid TX interrupts.
- The NAPI context should be associated with the hardware interrupt
  (it is now associated with something abstracted from the hardware).
- Use threaded interrupts, to avoid the need for using spinlocks and
  atomic variables for synchronizing between workqueue and interrupt
  context.
- Have runtime power management enable and disable IPA clock and
  interconnects.
Many thanks to Arnd Bergmann, Ilias Apalodimas, and Bjorn Andersson
for their early feedback.

While there clearly remains work to do on this, we felt that things
are far enough along that it would be helpful to solicit broader
input on the code.  Major issues are best addressed as soon as
possible, and even minor issues when identified help in setting
priorities.

This code is dependent on the following two sets of code, which have
been posted for review but are not yet accepted upstream:
- Interconnect framework:  https://lkml.org/lkml/2018/8/31/444
- SDM845 interconnect provider driver:  https://lkml.org/lkml/2018/8/24/25

In addition, it depends on four more bits of code that have not yet
been posted for upstream review, but are expected to be available soon:
- clk-rpmh support for IPA from David Dai <daidavid1@codeaurora.org>
- SDM845 reserved memory from Bjorn Andersson <bjorn.andersson@linaro.org>
- list_cut_end() from Alex Elder <elder@linaro.org>
- FIELD_MAX() in "bitfield.h" from Alex Elder <elder@linaro.org>

This code (including its dependencies) is available in buildable
form here, based on kernel v4.19:
    remote: ssh://git at git.linaro.org/people/alex.elder/linux.git
    branch: qualcomm_ipa-v1
	    59562facd61a arm64: dts: sdm845: add IPA information

					-Alex

Alex Elder (12):
  dt-bindings: soc: qcom: add IPA bindings
  soc: qcom: ipa: DMA helpers
  soc: qcom: ipa: generic software interface
  soc: qcom: ipa: immediate commands
  soc: qcom: ipa: IPA interrupts and the microcontroller
  soc: qcom: ipa: QMI modem communication
  soc: qcom: ipa: IPA register abstraction
  soc: qcom: ipa: utility functions
  soc: qcom: ipa: main IPA source file
  soc: qcom: ipa: data path
  soc: qcom: ipa: IPA rmnet interface
  soc: qcom: ipa: build and "ipa_i.h"

 .../devicetree/bindings/soc/qcom/qcom,ipa.txt |  136 ++
 .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |   15 +
 drivers/net/ipa/Kconfig                       |   30 +
 drivers/net/ipa/Makefile                      |    7 +
 drivers/net/ipa/gsi.c                         | 1685 ++++++++++++++
 drivers/net/ipa/gsi.h                         |  195 ++
 drivers/net/ipa/gsi_reg.h                     |  563 +++++
 drivers/net/ipa/ipa_dma.c                     |   61 +
 drivers/net/ipa/ipa_dma.h                     |   61 +
 drivers/net/ipa/ipa_dp.c                      | 1994 +++++++++++++++++
 drivers/net/ipa/ipa_i.h                       |  573 +++++
 drivers/net/ipa/ipa_interrupts.c              |  307 +++
 drivers/net/ipa/ipa_main.c                    | 1400 ++++++++++++
 drivers/net/ipa/ipa_qmi.c                     |  406 ++++
 drivers/net/ipa/ipa_qmi.h                     |   12 +
 drivers/net/ipa/ipa_qmi_msg.c                 |  587 +++++
 drivers/net/ipa/ipa_qmi_msg.h                 |  233 ++
 drivers/net/ipa/ipa_reg.c                     |  972 ++++++++
 drivers/net/ipa/ipa_reg.h                     |  614 +++++
 drivers/net/ipa/ipa_uc.c                      |  336 +++
 drivers/net/ipa/ipa_utils.c                   | 1035 +++++++++
 drivers/net/ipa/ipahal.c                      |  541 +++++
 drivers/net/ipa/ipahal.h                      |  253 +++
 drivers/net/ipa/msm_rmnet.h                   |  120 +
 drivers/net/ipa/rmnet_config.h                |   31 +
 drivers/net/ipa/rmnet_ipa.c                   |  805 +++++++
 26 files changed, 12972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
 create mode 100644 drivers/net/ipa/Kconfig
 create mode 100644 drivers/net/ipa/Makefile
 create mode 100644 drivers/net/ipa/gsi.c
 create mode 100644 drivers/net/ipa/gsi.h
 create mode 100644 drivers/net/ipa/gsi_reg.h
 create mode 100644 drivers/net/ipa/ipa_dma.c
 create mode 100644 drivers/net/ipa/ipa_dma.h
 create mode 100644 drivers/net/ipa/ipa_dp.c
 create mode 100644 drivers/net/ipa/ipa_i.h
 create mode 100644 drivers/net/ipa/ipa_interrupts.c
 create mode 100644 drivers/net/ipa/ipa_main.c
 create mode 100644 drivers/net/ipa/ipa_qmi.c
 create mode 100644 drivers/net/ipa/ipa_qmi.h
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.c
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.h
 create mode 100644 drivers/net/ipa/ipa_reg.c
 create mode 100644 drivers/net/ipa/ipa_reg.h
 create mode 100644 drivers/net/ipa/ipa_uc.c
 create mode 100644 drivers/net/ipa/ipa_utils.c
 create mode 100644 drivers/net/ipa/ipahal.c
 create mode 100644 drivers/net/ipa/ipahal.h
 create mode 100644 drivers/net/ipa/msm_rmnet.h
 create mode 100644 drivers/net/ipa/rmnet_config.h
 create mode 100644 drivers/net/ipa/rmnet_ipa.c

-- 
2.17.1
