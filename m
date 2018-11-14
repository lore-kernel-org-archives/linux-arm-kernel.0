From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Wed, 14 Nov 2018 13:59:42 +0100
Subject: [PATCH 16/16] staging: vchiq: add more tasks to the TODO list
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
Message-ID: <20181114125942.25163-17-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TODO list was missing some tasks needed before upstreaming the
device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchi/TODO | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
index 0b3ec75ff627..fc2752bc95b2 100644
--- a/drivers/staging/vc04_services/interface/vchi/TODO
+++ b/drivers/staging/vc04_services/interface/vchi/TODO
@@ -49,3 +49,45 @@ such as dev_info, dev_dbg, and friends.
 
 A short top-down description of this driver's architecture (function of
 kthreads, userspace, limitations) could be very helpful for reviewers.
+
+7) Review and comment memory barriers
+
+There is a heavy use of memory barriers in this driver, it would be very
+beneficial to go over all of them and, if correct, comment on their merits.
+Extra points to whomever confidently reviews the remote_event_*() family of
+functions.
+
+8) Get rid of custom function return values
+
+Most functions use a custom set of return values, we should force proper Linux
+error numbers. Special care is needed for VCHIQ_RETRY.
+
+9) Reformat core code with more sane indentations
+
+The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
+indentation deep making it very unpleasant to read. This is specially relevant
+in the character driver ioctl code and in the core thread functions.
+
+10) Reorganize file structure: Move char driver to it's own file and join both
+platform files
+
+The cdev is defined alongside with the platform code in vchiq_arm.c. It would
+be nice to completely decouple it from the actual core code. For instance to be
+able to use bcm2835-audio without having /dev/vchiq created. One could argue
+it's better for security reasons or general cleanliness. It could even be
+interesting to create two different kernel modules, something the likes of
+vchiq-core.ko and vchiq-dev.ko. This would also ease the upstreaming process.
+
+The code in vchiq_bcm2835_arm.c should fit in the generic platform file.
+
+12) Get rid of all the struct typedefs
+
+Most structs are typedefd, it's not encouraged in the kernel.
+
+13) Get rid of all non essential global structures and create a proper per
+device structure
+
+The first thing one generally sees in a probe function is a memory allocation
+for all the device specific data. This structure is then passed all over the
+driver. This is good practice since it makes the driver work regardless of the
+number of devices probed.
-- 
2.19.1
