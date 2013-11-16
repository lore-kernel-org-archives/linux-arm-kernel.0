From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Sat, 16 Nov 2013 11:36:25 -0500
Subject: xen drivers fail to link on ARM with v3.12-9888-gf63c482
In-Reply-To: <CA+5PVA7YMMRmFE=T7MOdGNeUiv_4Eu_u2-SrDfSTE052MpAnag@mail.gmail.com>
References: <CA+5PVA7YMMRmFE=T7MOdGNeUiv_4Eu_u2-SrDfSTE052MpAnag@mail.gmail.com>
Message-ID: <CA+5PVA63LyUB7o0+Z-YS91AUUwvRokHeYq_GJ1i6VE3bj2qQLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 9:56 AM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> Hi All,
>
> The xen-gntalloc, xen-netfront, xen-blkfront, and xen-netback drivers
> fail to link on ARM today with the following error:
>
> ERROR: "phys_to_mach" [drivers/xen/xen-gntalloc.ko] undefined!
> ERROR: "phys_to_mach" [drivers/net/xen-netfront.ko] undefined!
> ERROR: "phys_to_mach" [drivers/net/xen-netback/xen-netback.ko] undefined!
> ERROR: "phys_to_mach" [drivers/block/xen-blkfront.ko] undefined!
>
> This is with Linus' tree as of this morning.
>
> I'm guessing this is because the mfn_to_pfn and pfn_to_mfn functions
> are inlined and reference phys_to_mach directly, and that isn't
> exported to modules.  Thoughts?

The patch below seems to fix this, but I'm not sure it's the desired
approach.  I added the export for mach_to_phys just in case.

josh

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 23732cd..7772fa8 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -27,7 +27,9 @@ struct xen_p2m_entry {

 rwlock_t p2m_lock;
 struct rb_root phys_to_mach = RB_ROOT;
+EXPORT_SYMBOL_GPL(phys_to_mach);
 static struct rb_root mach_to_phys = RB_ROOT;
+EXPORT_SYMBOL_GPL(mach_to_phys);

 static int xen_add_phys_to_mach_entry(struct xen_p2m_entry *new)
 {
