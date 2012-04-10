From: domenico.andreoli@tomtom.com (Domenico Andreoli)
Date: Tue, 10 Apr 2012 10:48:33 +0200
Subject: [PATCH] ARM: fix amba_get_enable_vcore()'s handling of probe deferral
Message-ID: <20120410084833.GA13120@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

With v3.4-rc1 my board's console started to have problems. earlyprintk
revealed that the PL011 serial driver deferred the initialization and
never attempted it again. This resulted in console not being bound to
any physical device.

The error in probing the serial was due to amba_get_enable_vcore()
not ignoring the -EPROBE_DEFER got from regulator_get(), which has
been recently updated to ask for probe deferral in case the regulator
is not available (yet).

This fix makes amba_get_enable_vcore() consistently handle the new
-EPROBE_DEFER error case.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 drivers/amba/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/amba/bus.c
===================================================================
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -363,7 +363,7 @@ static int amba_get_enable_vcore(struct
 
 	if (IS_ERR(vcore)) {
 		/* It is OK not to supply a vcore regulator */
-		if (PTR_ERR(vcore) == -ENODEV)
+		if (PTR_ERR(vcore) == -EPROBE_DEFER)
 			return 0;
 		return PTR_ERR(vcore);
 	}
