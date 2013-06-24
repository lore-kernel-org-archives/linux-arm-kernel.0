From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 24 Jun 2013 17:42:05 +0800
Subject: [PATCH v2 4/4] USB: EHCI: support running URB giveback in tasklet
 context
In-Reply-To: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
References: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1372066925-23579-5-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All 4 transfer types can work well on EHCI HCD after switching to run
URB giveback in tasklet context, so mark all HCD drivers to support
it.

At the same time, don't release ehci->lock during URB giveback,
and remove the check on HCD_BH in ehci_disable_event().

>From below test results on 3 machines(2 ARM and one x86), time
consumed by EHCI interrupt handler droped much without performance
loss.

1 test description
1.1 mass storage performance test:
- run below command 10 times and compute the average performance

    dd if=/dev/sdN iflag=direct of=/dev/null bs=200M count=1

- two usb mass storage device:
A: sandisk extreme USB 3.0 16G(used in test case 1 & case 2)
B: kingston DataTraveler G2 4GB(only used in test case 2)

1.2 uvc function test:
- run one simple capture program in the below link

   http://kernel.ubuntu.com/~ming/up/capture.c

- capture format 640*480 and results in High Bandwidth mode on the
uvc device: Z-Star 0x0ac8/0x3450

- on T410(x86) laptop, also use guvcview to watch video capture/playback

1.3 about test2 and test4
- both two devices involved are tested concurrently by above test items

1.4 how to compute irq time(the time consumed by ehci_irq)
- use trace points of irq:irq_handler_entry and irq:irq_handler_exit

1.5 kernel
3.10.0-rc3-next-20130528

1.6 test machines
Pandaboard A1: ARM CortexA9 dural core
Arndale board: ARM CortexA15 dural core
T410: i5 CPU 2.67GHz quad core

2 test result
2.1 test case1: single mass storage device performance test
--------------------------------------------------------------------
		upstream 		| patched
		perf(MB/s)+irq time(us)	| perf(MB/s)+irq time(us)
--------------------------------------------------------------------
Pandaboard A1:  25.280(avg:145,max:772)	| 25.540(avg:14, max:75)
Arndale board:  29.700(avg:33, max:129)	| 29.700(avg:10,  max:50)
T410: 		34.430(avg:17, max:154*)| 34.660(avg:12, max:155)
---------------------------------------------------------------------

2.2 test case2: two mass storage devices' performance test
--------------------------------------------------------------------
		upstream 			| patched
		perf(MB/s)+irq time(us)		| perf(MB/s)+irq time(us)
--------------------------------------------------------------------
Pandaboard A1:  15.840/15.580(avg:158,max:1216)	| 16.500/16.160(avg:15,max:139)
Arndale board:  17.370/16.220(avg:33 max:234)	| 17.480/16.200(avg:11, max:91)
T410: 		21.180/19.820(avg:18 max:160)	| 21.220/19.880(avg:11, max:149)
---------------------------------------------------------------------

2.3 test case3: one uvc streaming test
- uvc device works well(on x86, luvcview can be used too and has
same result with uvc capture)
--------------------------------------------------------------------
		upstream 		| patched
		irq time(us)		| irq time(us)
--------------------------------------------------------------------
Pandaboard A1:  (avg:445, max:873)	| (avg:33, max:44)
Arndale board:  (avg:316, max:630)	| (avg:20, max:27)
T410: 		(avg:39,  max:107)	| (avg:10, max:65)
---------------------------------------------------------------------

2.4 test case4: one uvc streaming plus one mass storage device test
--------------------------------------------------------------------
		upstream 		| patched
		perf(MB/s)+irq time(us)	| perf(MB/s)+irq time(us)
--------------------------------------------------------------------
Pandaboard A1:  20.340(avg:259,max:1704)| 20.390(avg:24, max:101)
Arndale board:  23.460(avg:124,max:726)	| 23.370(avg:15, max:52)
T410: 		28.520(avg:27, max:169)	| 28.630(avg:13, max:160)
---------------------------------------------------------------------

* On T410, sometimes read ehci status register in ehci_irq takes more
than 100us, and the problem has been reported on the link:

	http://marc.info/?t=137065867300001&r=1&w=2

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/host/ehci-fsl.c       |    2 +-
 drivers/usb/host/ehci-grlib.c     |    2 +-
 drivers/usb/host/ehci-hcd.c       |    2 +-
 drivers/usb/host/ehci-mv.c        |    2 +-
 drivers/usb/host/ehci-octeon.c    |    2 +-
 drivers/usb/host/ehci-pmcmsp.c    |    2 +-
 drivers/usb/host/ehci-ppc-of.c    |    2 +-
 drivers/usb/host/ehci-ps3.c       |    2 +-
 drivers/usb/host/ehci-q.c         |    5 -----
 drivers/usb/host/ehci-sead3.c     |    2 +-
 drivers/usb/host/ehci-sh.c        |    2 +-
 drivers/usb/host/ehci-tilegx.c    |    2 +-
 drivers/usb/host/ehci-timer.c     |    3 ---
 drivers/usb/host/ehci-w90x900.c   |    2 +-
 drivers/usb/host/ehci-xilinx-of.c |    2 +-
 15 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index bd831ec..330274a 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -669,7 +669,7 @@ static const struct hc_driver ehci_fsl_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq = ehci_irq,
-	.flags = HCD_USB2 | HCD_MEMORY,
+	.flags = HCD_USB2 | HCD_MEMORY | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-grlib.c b/drivers/usb/host/ehci-grlib.c
index a77bd8d..2905004 100644
--- a/drivers/usb/host/ehci-grlib.c
+++ b/drivers/usb/host/ehci-grlib.c
@@ -43,7 +43,7 @@ static const struct hc_driver ehci_grlib_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 35f1372..fe27038 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1170,7 +1170,7 @@ static const struct hc_driver ehci_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ehci_irq,
-	.flags =		HCD_MEMORY | HCD_USB2,
+	.flags =		HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 915c2db..ce18a36 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -96,7 +96,7 @@ static const struct hc_driver mv_ehci_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq = ehci_irq,
-	.flags = HCD_MEMORY | HCD_USB2,
+	.flags = HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-octeon.c b/drivers/usb/host/ehci-octeon.c
index 45cc001..ab0397e 100644
--- a/drivers/usb/host/ehci-octeon.c
+++ b/drivers/usb/host/ehci-octeon.c
@@ -51,7 +51,7 @@ static const struct hc_driver ehci_octeon_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-pmcmsp.c b/drivers/usb/host/ehci-pmcmsp.c
index 601e208..893b707 100644
--- a/drivers/usb/host/ehci-pmcmsp.c
+++ b/drivers/usb/host/ehci-pmcmsp.c
@@ -286,7 +286,7 @@ static const struct hc_driver ehci_msp_hc_driver = {
 #else
 	.irq =			ehci_irq,
 #endif
-	.flags =		HCD_MEMORY | HCD_USB2,
+	.flags =		HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index 86da09c..014d37b 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -28,7 +28,7 @@ static const struct hc_driver ehci_ppc_of_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index fd98377..8188542 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -71,7 +71,7 @@ static const struct hc_driver ps3_ehci_hc_driver = {
 	.product_desc		= "PS3 EHCI Host Controller",
 	.hcd_priv_size		= sizeof(struct ehci_hcd),
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 	.reset			= ps3_ehci_hc_reset,
 	.start			= ehci_run,
 	.stop			= ehci_stop,
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index d34b399..b637a65 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -254,8 +254,6 @@ static int qtd_copy_status (
 
 static void
 ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
-__releases(ehci->lock)
-__acquires(ehci->lock)
 {
 	if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
 		/* ... update hc-wide periodic stats */
@@ -281,11 +279,8 @@ __acquires(ehci->lock)
 		urb->actual_length, urb->transfer_buffer_length);
 #endif
 
-	/* complete() can reenter this HCD */
 	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
-	spin_unlock (&ehci->lock);
 	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
-	spin_lock (&ehci->lock);
 }
 
 static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
index b2de52d..8a73449 100644
--- a/drivers/usb/host/ehci-sead3.c
+++ b/drivers/usb/host/ehci-sead3.c
@@ -55,7 +55,7 @@ const struct hc_driver ehci_sead3_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index c4c0ee9..1691f8e 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -36,7 +36,7 @@ static const struct hc_driver ehci_sh_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq				= ehci_irq,
-	.flags				= HCD_USB2 | HCD_MEMORY,
+	.flags				= HCD_USB2 | HCD_MEMORY | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-tilegx.c b/drivers/usb/host/ehci-tilegx.c
index d72b292..204d3b6 100644
--- a/drivers/usb/host/ehci-tilegx.c
+++ b/drivers/usb/host/ehci-tilegx.c
@@ -61,7 +61,7 @@ static const struct hc_driver ehci_tilegx_hc_driver = {
 	 * Generic hardware linkage.
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * Basic lifecycle operations.
diff --git a/drivers/usb/host/ehci-timer.c b/drivers/usb/host/ehci-timer.c
index 9fef5d4..9970746 100644
--- a/drivers/usb/host/ehci-timer.c
+++ b/drivers/usb/host/ehci-timer.c
@@ -102,9 +102,6 @@ static void ehci_enable_event(struct ehci_hcd *ehci, unsigned event,
 /* Warning: don't call this function from hrtimer handler context */
 static void ehci_disable_event(struct ehci_hcd *ehci, unsigned event)
 {
-	if (!hcd_giveback_urb_in_bh(ehci_to_hcd(ehci)))
-		return;
-
 	ehci->enabled_hrtimer_events &= ~(1 << event);
 	if (!ehci->enabled_hrtimer_events) {
 		ehci->next_hrtimer_event = EHCI_HRTIMER_NO_EVENT;
diff --git a/drivers/usb/host/ehci-w90x900.c b/drivers/usb/host/ehci-w90x900.c
index 59e0e24..1c370df 100644
--- a/drivers/usb/host/ehci-w90x900.c
+++ b/drivers/usb/host/ehci-w90x900.c
@@ -108,7 +108,7 @@ static const struct hc_driver ehci_w90x900_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq = ehci_irq,
-	.flags = HCD_USB2|HCD_MEMORY,
+	.flags = HCD_USB2|HCD_MEMORY|HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
index 35c7f90..c6591ea 100644
--- a/drivers/usb/host/ehci-xilinx-of.c
+++ b/drivers/usb/host/ehci-xilinx-of.c
@@ -79,7 +79,7 @@ static const struct hc_driver ehci_xilinx_of_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
-- 
1.7.9.5
