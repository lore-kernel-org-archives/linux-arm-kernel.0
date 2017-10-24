From: keescook@chromium.org (Kees Cook)
Date: Tue, 24 Oct 2017 01:26:21 -0700
Subject: [PATCH] staging: vc04_services: Convert timers to use timer_setup()
Message-ID: <20171024082621.GA18529@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Michael Zoran <mzoran@crowfest.net>
Cc: Keerthi Reddy <keerthigd4990@gmail.com>
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: devel at driverdev.osuosl.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 +++++++------
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.h   |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6fcc62603580..6d16cc036c0c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -109,7 +109,7 @@ static const char *const resume_state_names[] = {
  * requested */
 #define FORCE_SUSPEND_TIMEOUT_MS 200
 
-static void suspend_timer_callback(unsigned long context);
+static void suspend_timer_callback(struct timer_list *t);
 
 typedef struct user_service_struct {
 	VCHIQ_SERVICE_T *service;
@@ -2184,8 +2184,9 @@ vchiq_arm_init_state(VCHIQ_STATE_T *state, VCHIQ_ARM_STATE_T *arm_state)
 
 		arm_state->suspend_timer_timeout = SUSPEND_TIMER_TIMEOUT_MS;
 		arm_state->suspend_timer_running = 0;
-		setup_timer(&arm_state->suspend_timer, suspend_timer_callback,
-			    (unsigned long)(state));
+		arm_state->state = state;
+		timer_setup(&arm_state->suspend_timer, suspend_timer_callback,
+			    0);
 
 		arm_state->first_connect = 0;
 
@@ -3017,10 +3018,10 @@ vchiq_instance_set_trace(VCHIQ_INSTANCE_T instance, int trace)
 	instance->trace = (trace != 0);
 }
 
-static void suspend_timer_callback(unsigned long context)
+static void suspend_timer_callback(struct timer_list *t)
 {
-	VCHIQ_STATE_T *state = (VCHIQ_STATE_T *)context;
-	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
+	VCHIQ_ARM_STATE_T *arm_state = from_timer(arm_state, t, suspend_timer);
+	VCHIQ_STATE_T *state = arm_state->state;
 
 	if (!arm_state)
 		goto out;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index a4cc0db899be..40bb0c63b1a9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -83,6 +83,7 @@ typedef struct vchiq_arm_state_struct {
 
 	unsigned int wake_address;
 
+	VCHIQ_STATE_T *state;
 	struct timer_list suspend_timer;
 	int suspend_timer_timeout;
 	int suspend_timer_running;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
