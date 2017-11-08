From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  8 Nov 2017 13:47:49 +0100
Subject: [PATCH 0/3] tee: asynchronous supplicant requests
Message-ID: <1510145272-14842-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Currently all tee supplicant communication is synchronous. This isn't very
limiting if the supplicant only is accessing system local resources like
storage. With network access via the supplicant it becomes a larger
problem.

This patch set enables asynchronous communication with the supplicant by
introducing meta parameters in the user space API. The meta parameters can
be used to tag requests with an id that can be matched against an
asynchronous response as is done here in the OP-TEE driver. 

Asynchronous supplicant communication is needed by OP-TEE to implement
GlobalPlatforms TEE Sockets API Specification v1.0.1. The specification is
available at https://www.globalplatform.org/specificationsdevice.asp.

This change is backwards compatible allowing older supplicants to work with
newer kernels and vice versa.

Thanks,
Jens

Jens Wiklander (3):
  tee: add tee_param_is_memref() for driver use
  tee: add TEE_IOCTL_PARAM_ATTR_META
  optee: support asynchronous supplicant requests

 drivers/tee/optee/core.c          |  11 +-
 drivers/tee/optee/optee_private.h |  43 ++---
 drivers/tee/optee/rpc.c           |   4 +-
 drivers/tee/optee/supp.c          | 375 ++++++++++++++++++++++++--------------
 drivers/tee/tee_core.c            |  32 ++--
 include/linux/tee_drv.h           |  12 ++
 include/uapi/linux/tee.h          |   7 +
 7 files changed, 295 insertions(+), 189 deletions(-)

-- 
2.7.4
