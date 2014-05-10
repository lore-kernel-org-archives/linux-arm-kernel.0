From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 10 May 2014 09:23:29 -0700
Subject: [PATCH 6/5] watchdog: Document reboot API
In-Reply-To: <536D74E3.8010609@infradead.org>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
 <536D74E3.8010609@infradead.org>
Message-ID: <20140510162329.GA19884@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new reboot API functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a0438f3..f8f0f18 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -90,6 +90,8 @@ struct watchdog_ops {
 	int (*stop)(struct watchdog_device *);
 	/* optional operations */
 	int (*ping)(struct watchdog_device *);
+	void (*reboot)(struct watchdog_device *, enum reboot_mode,
+		       const char *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
@@ -148,6 +150,10 @@ they are supported. These optional routines/operations are:
   info structure).
 * status: this routine checks the status of the watchdog timer device. The
   status of the device is reported with watchdog WDIOF_* status flags/bits.
+* reboot: if this routine is present, it may be called to reboot the system.
+  Parameters are the pointer to the watchdog device, the reboot mode, and a
+  command string. The latter two parameters are the system reboot mode
+  and the cmd parameter passed to machine_restart().
 * set_timeout: this routine checks and changes the timeout of the watchdog
   timer device. It returns 0 on success, -EINVAL for "parameter out of range"
   and -EIO for "could not write value to the watchdog". On success this
@@ -224,3 +230,11 @@ the device tree (if the module timeout parameter is invalid). Best practice is
 to set the default timeout value as timeout value in the watchdog_device and
 then use this function to set the user "preferred" timeout value.
 This routine returns zero on success and a negative errno code for failure.
+
+The watchdog_do_reboot function can be used reboot the system. This is intended
+to be used in systems which do not have an explicit reboot capability, but
+implement reboot by programming the watchdog to expire immediately. If the
+function is called, and a watchdog driver with reboot functionality was
+previously registered, the reboot function of that driver will be called.
+Architecture code should call watchdog_do_reboot from its machine_reboot
+function after other means to reboot the system failed.
-- 
1.9.1
