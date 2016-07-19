From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2016 10:31:26 +0200
Subject: [PATCH v2 05/11] Kbuild: don't add obj tree in additional includes
In-Reply-To: <20160718201439.GA9053@sepie.suse.cz>
References: <20160615154553.3177021-1-arnd@arndb.de>
 <20160615154553.3177021-6-arnd@arndb.de>
 <20160718201439.GA9053@sepie.suse.cz>
Message-ID: <21521763.EfAflxWUP8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 18, 2016 10:14:39 PM CEST Michal Marek wrote:
> On Wed, Jun 15, 2016 at 05:45:47PM +0200, Arnd Bergmann wrote:
> > When building with separate object directories and driver specific
> > Makefiles that add additional header include paths, Kbuild adjusts
> > the gcc flags so that we include both the directory in the source
> > tree and in the object tree.
> > 
> > However, due to another bug I fixed earlier, this did not actually
> > include the correct directory in the object tree, so we know that
> > we only really need the source tree here. Also, including the
> > object tree sometimes causes warnings about nonexisting directories
> > when the include path only exists in the source.
> > 
> > This changes the logic to only emit the -I argument for the srctree,
> > not for objects. We still need both $(srctree)/$(src) and $(obj)
> > though, so I'm adding them manually.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hi Arnd,
> 
> I applied the series up to this patch to kbuild.git#kbuild. The rest
> seem to be related but not dependent patches, so I'll leave it up to the
> respective maintainers to pick them up. Is that OK with you?

I think that's fine, a couple were already picked up, and what I have
left now is

a281bfa5713a [SUBMITTED 20160615] [EXPERIMENTAL] Kbuild: enable -Wmissing-include-dirs by default
83934921e68e [SUBMITTED 20160615] rtlwifi: don't add include path for rtl8188ee
5664e7bb88a8 [SUBMITTED 20160615] drm: amd: remove broken include path
e6d3cf76f9f8 [SUBMITTED 20160615] ARM: hide mach-*/ include for ARM_SINGLE_ARMV7M
b21947dbd792 [SUBMITTED 20160615] ARM: don't include removed directories

I can probably put the last two into arm-soc directly. After that, we'd
be left with a very small diff for the series:

diff --git a/Makefile b/Makefile
index caa33e007a8c..53074dbe8619 100644
--- a/Makefile
+++ b/Makefile
@@ -754,6 +754,9 @@ endif
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
+# warn about incorrect -I include paths
+KBUILD_CFLAGS += -Wmissing-include-dirs
+
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 
diff --git a/drivers/gpu/drm/amd/acp/Makefile b/drivers/gpu/drm/amd/acp/Makefile
index 8363cb57915b..8a08e81ee90d 100644
--- a/drivers/gpu/drm/amd/acp/Makefile
+++ b/drivers/gpu/drm/amd/acp/Makefile
@@ -3,6 +3,4 @@
 # of AMDSOC/AMDGPU drm driver.
 # It provides the HW control for ACP related functionalities.
 
-subdir-ccflags-y += -I$(AMDACPPATH)/ -I$(AMDACPPATH)/include
-
 AMD_ACP_FILES := $(AMDACPPATH)/acp_hw.o
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile
index a85419a37651..676e7de27f27 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile
@@ -12,4 +12,4 @@ rtl8188ee-objs :=		\
 
 obj-$(CONFIG_RTL8188EE) += rtl8188ee.o
 
-ccflags-y += -Idrivers/net/wireless/rtlwifi -D__CHECK_ENDIAN__
+ccflags-y += -D__CHECK_ENDIAN__



I have only tested this on arm, arm64 and x86, so I don't know if that
introduces new warnings, but we could ask Andrew if he wants to add that
to linux-mm after the merge window.

	Arnd
