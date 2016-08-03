From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 3 Aug 2016 10:11:40 +0200
Subject: [PATCH] Add file permission mode helpers
In-Reply-To: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
Message-ID: <20160803081140.GA7833@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [ So I answered similarly to another patch, but I'll just re-iterate
> and change the subject line so that it stands out a bit from the
> millions of actual patches ]
> 
> On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> > S_IRCRP | S_IROTH (*). Please don't do this.
> 
> Absolutely. It's *much* easier to parse and understand the octal
> numbers, while the symbolic macro names are just random line noise and
> hard as hell to understand. You really have to think about it.
> 
> So we should rather go the other way: convert existing bad symbolic
> permission bit macro use to just use the octal numbers.

In addition to that I'd love to have something even easier to read, a few common 
variants of the permissions field of 'ls -l' pre-defined. I did some quick 
grepping, and collected the main variants that are in use:

		PERM_r________	0400
		PERM_r__r_____	0440
		PERM_r__r__r__	0444

		PERM_rw_______	0600
		PERM_rw_r_____	0640
		PERM_rw_r__r__	0644
		PERM_rw_rw_r__	0664
		PERM_rw_rw_rw_	0666

		PERM__w_______	0200
		PERM__w__w____	0220
		PERM__w__w__w_	0222

		PERM_r_x______	0500
		PERM_r_xr_x___	0550
		PERM_r_xr_xr_x	0555

		PERM_rwx______	0700
		PERM_rwxr_x___	0750
		PERM_rwxr_xr_x	0755
		PERM_rwxrwxr_x	0775
		PERM_rwxrwxrwx	0777

		PERM__wx______	0300
		PERM__wx_wx___	0330
		PERM__wx_wx_wx	0333

Allowing these would be nice too, because there were cases in the past where 
people messed up the octal representation or our internal symbolic helpers,
but this representation is fundamentally self-describing and pretty 'fool proof'.

An added advantage would be that during review it would stick out like a sore 
thumb if anyone used a 'weird' permission variant.

For example, if you saw these lines in a driver patch:

+	__ATTR(l1, 0444, driver_show_l4, NULL);
+		__ATTR(l3, 0446, driver_show_l4, NULL);
+			__ATTR(l2, 04444, driver_show_l4, NULL);
+		__ATTR(l4, 0444, driver_show_l4, NULL);

... would you notice it at a glance that it contains two security holes?

While the weird permissions in this:

+		__ATTR(l1, PERM_r__r__r__,  driver_show_l4, NULL);
+		__ATTR(l3, PERM_r__r__rw_,  driver_show_l4, NULL);
+		__ATTR(l2, PERM_sr__r__r__, driver_show_l4, NULL);
+		__ATTR(l4, PERM_r__r__r__,  driver_show_l4, NULL);

Wouln't even build, because the dangerous patterns of PERM_r__r__rw_ or 
PERM_sr__r__r__ are not defined to begin with.

The patch below adds them to stat.h.

Thanks,

	Ingo

 include/linux/stat.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/stat.h b/include/linux/stat.h
index 075cb0c7eb2a..863d5563427f 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -5,6 +5,38 @@
 #include <asm/stat.h>
 #include <uapi/linux/stat.h>
 
+/*
+ * Human readable symbolic definitions for common
+ * file permissions:
+ */
+#define PERM_r________	0400
+#define PERM_r__r_____	0440
+#define PERM_r__r__r__	0444
+
+#define PERM_rw_______	0600
+#define PERM_rw_r_____	0640
+#define PERM_rw_r__r__	0644
+#define PERM_rw_rw_r__	0664
+#define PERM_rw_rw_rw_	0666
+
+#define PERM__w_______	0200
+#define PERM__w__w____	0220
+#define PERM__w__w__w_	0222
+
+#define PERM_r_x______	0500
+#define PERM_r_xr_x___	0550
+#define PERM_r_xr_xr_x	0555
+
+#define PERM_rwx______	0700
+#define PERM_rwxr_x___	0750
+#define PERM_rwxr_xr_x	0755
+#define PERM_rwxrwxr_x	0775
+#define PERM_rwxrwxrwx	0777
+
+#define PERM__wx______	0300
+#define PERM__wx_wx___	0330
+#define PERM__wx_wx_wx	0333
+
 #define S_IRWXUGO	(S_IRWXU|S_IRWXG|S_IRWXO)
 #define S_IALLUGO	(S_ISUID|S_ISGID|S_ISVTX|S_IRWXUGO)
 #define S_IRUGO		(S_IRUSR|S_IRGRP|S_IROTH)
