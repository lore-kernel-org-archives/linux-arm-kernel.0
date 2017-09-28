From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 11:45:58 +0100
Subject: [RESEND][PATCH 0/4] firmware: of: populate /firmware/ node during init
Message-ID: <1506595562-10592-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Arnd,

There's a push to place all firmware related device node under
/firmware/ node. However all the associated drivers are dealing with
device creation in their own ways. For example, qcom_scm, optee and
meson-sm drivers deal with the node in their own way. The SCMI drivers
I am about to add also needs to do the same. This small series is to
make it generic so that all the users of /firmware/ node need not
repeat the same.

There was concern that /firmware in DT is fit for /sys/firmware in sysfs.
IMO anything exposed to userspace from such firmware interface must
be in "/sys/firmware", but I don't see any issue with kernel handling
them as platform device/driver internally.

Sudeep Holla (4):
  of: platform: populate /firmware/ node from
    of_platform_default_populate_init()
  firmware: qcom_scm: drop redandant of_platform_populate
  drivers: tee: rework optee_driver_{init,exit} to use platform device
  firmware: meson-sm: rework meson_sm_init to use
    module_platform_driver_probe

 drivers/firmware/meson/meson_sm.c | 21 ++++++-----
 drivers/firmware/qcom_scm.c       | 24 -------------
 drivers/of/platform.c             |  4 +++
 drivers/tee/optee/core.c          | 74 +++++++++++++--------------------------
 4 files changed, 41 insertions(+), 82 deletions(-)

--
2.7.4
