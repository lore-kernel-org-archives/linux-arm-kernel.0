From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 31 Jan 2010 09:44:22 +0100
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <1263914079.1951.43.camel@m0nster>
References: <20091225205917.GA25761@elf.ucw.cz>
	<20100115002419.GA25643@kroah.com>
	<20100119054516.GB22153@elf.ucw.cz>
	<1263914079.1951.43.camel@m0nster>
Message-ID: <20100131084421.GG2238@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > This adds missing include files, so it should now compile. ifdef
> > > > guards were added to Kconfig, so it should not cause problems on
> > > > non-arch-msm machines.
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > Odd, this doesn't apply to the linux-next tree, some of the files are
> > > already there.
> > 
> > Strange, it seems it is almost all already in. Well, good :-).
> > 
> > But there's small problem. linux-next now contains dwalker's tree, and
> > I could not get it to compile, even with staging disabled. I'll need
> > to look into that.
> 
> I worked on it a little, but I won't have time to really start cleaning
> up that tree till next week, or this weekend.
> 
> I pushed a new tree for next that should compile for dream with the
> attached config. I also included the patch that I added to get it to
> compile (you'll need the machine types too which I didn't include).

Thanks! I checked out linux-next version, and it seems to include

> commit cdf6c137865357112aa31666b65b938ab29fa736
>     msm: compile fixes for dream.

this patch. It still fails with:

arch/arm/mach-msm/rpc_hsusb.c: In function 'msm_chg_rpc_connect':
arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
function 'machine_is_msm7201a_surf'
arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
function 'machine_is_msm7x27_surf'
arch/arm/mach-msm/rpc_hsusb.c:157: error: implicit declaration of
function 'machine_is_qsd8x50_surf'
make[1]: *** [arch/arm/mach-msm/rpc_hsusb.o] Error 1
make: *** [arch/arm/mach-msm] Error 2

(and similar error further down). This fixes it, but you probably want
to add machine_is_* to your git. (Aha, is that what you meant by
"machine types"?

With this patch it compiles.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-msm/rpc_hsusb.c b/arch/arm/mach-msm/rpc_hsusb.c
index 22dee1c..52ba8b0 100644
--- a/arch/arm/mach-msm/rpc_hsusb.c
+++ b/arch/arm/mach-msm/rpc_hsusb.c
@@ -152,11 +152,6 @@ EXPORT_SYMBOL(msm_hsusb_rpc_connect);
 /* rpc connect for charging */
 int msm_chg_rpc_connect(void)
 {
-
-	if (machine_is_msm7201a_surf() || machine_is_msm7x27_surf() ||
-	    machine_is_qsd8x50_surf())
-		return -ENOTSUPP;
-
 	if (chg_ep && !IS_ERR(chg_ep)) {
 		printk(KERN_INFO "%s: chg_ep already connected\n", __func__);
 		return 0;
diff --git a/arch/arm/mach-msm/rpc_server_handset.c b/arch/arm/mach-msm/rpc_server_handset.c
index f2df4ac..2b3d33e 100644
--- a/arch/arm/mach-msm/rpc_server_handset.c
+++ b/arch/arm/mach-msm/rpc_server_handset.c
@@ -369,12 +369,6 @@ static int __init hs_rpc_init(void)
 {
 	int rc;
 
-	if (machine_is_msm7x27_surf() || machine_is_msm7x27_ffa()) {
-		rc = hs_rpc_cb_init();
-		if (rc)
-			pr_err("%s: failed to initialize\n", __func__);
-	}
-
 	return msm_rpc_create_server(&hs_rpc_server);
 }
 module_init(hs_rpc_init);



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
