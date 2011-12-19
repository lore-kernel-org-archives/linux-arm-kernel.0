From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 14:23:21 +0100
Subject: [PATCH v3 0/7] s3c-hsudc: regulator handling and a lot of fixes
Message-ID: <201112191423.21461.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In his response to the first submission Felipe Balbi asked to also move
the driver to the new udc_start and udc_stop functions and to make an
effort to reduce dependencies on archictecture code.

v3 of the series does not try to provide a remove function, due to the
possible lifetime problem of gadget.dev found by Russel King.

The first patch reduces the number of arch dependencies by one by moving
the platform data struct to a header unter include/linux/usb.

The fourth and fifth patches implement the move to udc_start / udc_stop

And the sixt patch finally allows the s3c-hsudc driver to control its
supplying regulators as intended in the first place.

The regulator calls can use the regulators unconditionally and let
necessary "stubbing and mapping" happen through the regulator framework,
according to for example
http://marc.info/?l=linux-netdev&m=131914562120725&w=2
meaning there is no need to gracefully fail if a regulator is not present.


Each patch was compile-tested individually, the series applies cleanly
against linux-next from 2011-12-16.

Real-life testing happened on S3C2416 hardware.

Heiko Stuebner (7):
  s3c-hsudc: move platform_data struct to global header
  s3c-hsudc: add __devinit to probe function
  s3c-hsudc: add missing otg_put_transceiver in probe
  s3c-hsudc: move device registration to probe
  s3c-hsudc: use udc_start and udc_stop functions
  s3c-hsudc: Add regulator handling
  s3c-hsudc: use release_mem_region instead of release_resource

 arch/arm/mach-s3c2416/mach-smdk2416.c    |    1 +
 arch/arm/plat-samsung/devs.c             |    1 +
 arch/arm/plat-samsung/include/plat/udc.h |   15 +----
 drivers/usb/gadget/s3c-hsudc.c           |  109 +++++++++++++++++-------------
 include/linux/usb/s3c-hsudc.h            |   34 +++++++++
 5 files changed, 100 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/usb/s3c-hsudc.h

-- 
1.7.5.4
