From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Wed, 7 Mar 2012 19:40:07 +0530
Subject: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
 modules.
In-Reply-To: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
References: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <CAMrsUdJq8J8dTnKcZmXgMucDX=dNXgR+9xFhYOdHvNDuw_=4Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 5:49 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
>
> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
> (ex: usb host uhh module) in absence of this flag
> omap_hwmod_enable/disable_wakeup avoids configuring
> pad mux wakeup capability.
>
> Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
> try enabling/disabling wakeup from mux_pad pins.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> ?arch/arm/mach-omap2/omap_hwmod.c | ? 30 ++++++++++++++++--------------
> ?1 files changed, 16 insertions(+), 14 deletions(-)

[...]

>
> @@ -2506,14 +2507,15 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
> ? ? ? ?unsigned long flags;
> ? ? ? ?u32 v;
>
> - ? ? ? if (!oh->class->sysc ||
> - ? ? ? ? ? !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
> - ? ? ? ? ? ? ? return -EINVAL;
> -
> ? ? ? ?spin_lock_irqsave(&oh->_lock, flags);
> - ? ? ? v = oh->_sysc_cache;
> - ? ? ? _disable_wakeup(oh, &v);
> - ? ? ? _write_sysconfig(v, oh);
> +
> + ? ? ? if (oh->class->sysc ||
> + ? ? ? ? ? (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {


This condition check should have been _and_ (&&)
sorry for the typo,

Here [1] is the updated patch.

--
Thanks,
Govindraj.R

[1]:

>From b3aa1dac5909cad1b959f5b97bbf408b2f974060 Mon Sep 17 00:00:00 2001
From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Wed, 7 Mar 2012 17:14:02 +0530
Subject: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
 modules.

Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
(ex: usb host uhh module) in absence of this flag
omap_hwmod_enable/disable_wakeup avoids configuring
pad mux wakeup capability.

Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
try enabling/disabling wakeup from mux_pad pins.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eba6cd3..9605fad 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2475,14 +2475,15 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	unsigned long flags;
 	u32 v;

-	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
-		return -EINVAL;
-
 	spin_lock_irqsave(&oh->_lock, flags);
-	v = oh->_sysc_cache;
-	_enable_wakeup(oh, &v);
-	_write_sysconfig(v, oh);
+
+	if (oh->class->sysc &&
+	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
+		v = oh->_sysc_cache;
+		_enable_wakeup(oh, &v);
+		_write_sysconfig(v, oh);
+	}
+
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);

@@ -2506,14 +2507,15 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	unsigned long flags;
 	u32 v;

-	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
-		return -EINVAL;
-
 	spin_lock_irqsave(&oh->_lock, flags);
-	v = oh->_sysc_cache;
-	_disable_wakeup(oh, &v);
-	_write_sysconfig(v, oh);
+
+	if (oh->class->sysc &&
+	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
+		v = oh->_sysc_cache;
+		_disable_wakeup(oh, &v);
+		_write_sysconfig(v, oh);
+	}
+
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);

-- 
1.7.5.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-omap_hwmod-Allow-io_ring-wakeup-configuration-for-al.patch
Type: application/octet-stream
Size: 2210 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/f68a01f4/attachment.obj>
