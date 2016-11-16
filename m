From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 16 Nov 2016 14:40:24 -0800
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <CAOMZO5Bd2X3pVqExBtBw_uHReDDkf6J2VdMXnAXynCAHxoX60A@mail.gmail.com>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
 <20161116184649.GF11228@leverpostej>
 <20161116221002.GA19925@roeck-us.net>
 <CAOMZO5Bd2X3pVqExBtBw_uHReDDkf6J2VdMXnAXynCAHxoX60A@mail.gmail.com>
Message-ID: <20161116224024.GA11821@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 08:27:09PM -0200, Fabio Estevam wrote:
> Hi Guenter,
> 
> On Wed, Nov 16, 2016 at 8:10 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Anyway, I guess the problem is that the "official" dtb files no longer provide
> > the skeleton /chosen and /memory nodes (and maybe others), and qemu seems to
> > expect that they are provided. Is that correct ?
> 
> imx6qdl-sabrelite.dtsi provides chosen and memory nodes.

Yes, but not the 'device_type' property, which the kernel seems to expect.
The qemu patch below fixes the problem for sabrelite, I just don't know
if that is really the way to go. You tell me; I'll be happy to submit
the necessary patch(es) into qemu.

The same is true for 'chosen'. Right now qemu expects this node to exist.
It does exist for sabrelite, but apparently not for imx25-pdk.

Guenter

---
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1b913a4..080d1e5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -486,6 +486,12 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
             g_free(nodename);
         }
     } else {
+        Error *err = NULL;
+
+        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
+            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
+        }
+
         rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
                                           acells, binfo->loader_start,
                                           scells, binfo->ram_size);
