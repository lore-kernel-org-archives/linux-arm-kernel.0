From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 11 Jul 2017 18:02:52 -0700
Subject: [PATCH 0/3] USB Mux support for Chipidea
Message-ID: <20170712010255.26855-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the TC7USB40MU usb mux found on 
db410c 96boards platforms via the new multiplexer framework and
hooks that into the chipidea driver. This allows us to properly
control host or device mode on this board via the sysfs knob.

So far I've only tested this on db410c, and there are some rough
edges to finish off before it can merge. Also I'm experiencing
odd behavior with switching the role while gadget is enabled and
the micro-usb cable is kept connected. Not sure what's wrong but
it seems like the gadget never gets disconnected? I'll investigate
more.

TODO:

 1. The mux framework has to be selected for consumers to use it. We'll
    need some stubs in the consumer header file to allow compilation to
    continue without mux always enabled by consumers.

 2. We probably need some sort of mux_control_get_optional() API so that
    we know if there was an error getting the mux control, instead of just
    ignoring errors. For now I can pass up EPROBE_DEFER errors and ignore
    other errors and consider it "missing from DT".

 3. Maybe we can get rid of the mux driver and just use mux-gpio.c with
    a compatible string update? I split it off because we may want to
    support the "S" pin on the TC7USB40MU one day that shuts off both
    mux outputs.

 4. The userspace side of things is murky. What is expected to go and toggle
    the host/gadget side of things in userspace at this very specific location
    for chipidea devices?

Stephen Boyd (3):
  usb: misc: Add a driver for TC7USB40MU
  usb: chipidea: Hook into mux framework to toggle usb switch
  arm64: dts: qcom: Collapse usb support into one node

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |  8 +++
 .../devicetree/bindings/usb/toshiba,tc7usb40mu.txt | 31 +++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 39 +++++++-----
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 62 +++++++++---------
 drivers/usb/chipidea/core.c                        | 17 +++++
 drivers/usb/chipidea/host.c                        | 10 +++
 drivers/usb/chipidea/udc.c                         | 11 ++++
 drivers/usb/misc/Kconfig                           | 11 ++++
 drivers/usb/misc/Makefile                          |  1 +
 drivers/usb/misc/tc7usb40mu.c                      | 74 ++++++++++++++++++++++
 include/linux/usb/chipidea.h                       | 14 ++++
 11 files changed, 228 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
 create mode 100644 drivers/usb/misc/tc7usb40mu.c

-- 
2.10.0.297.gf6727b0
