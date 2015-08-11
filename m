From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 11 Aug 2015 09:47:14 +0100
Subject: [PATCH v4] dtb: Create a common home for cross-architecture
 dtsi files.
In-Reply-To: <CAK7LNARyEbnOWTis0Nx9zwTcwH_s3GZKg2XYG3+zLnf=FhhctA@mail.gmail.com>
References: <1438617993-1012-1-git-send-email-ian.campbell@citrix.com>
 <CAK7LNARyEbnOWTis0Nx9zwTcwH_s3GZKg2XYG3+zLnf=FhhctA@mail.gmail.com>
Message-ID: <1439282834.9747.189.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-08-11 at 13:00 +0900, Masahiro Yamada wrote:
> Hi
> 
> 2015-08-04 1:06 GMT+09:00 Ian Campbell <ian.campbell@citrix.com>:
> > Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
> > LogicTile Express 20MG") added a new dts file to arch/arm64 which
> > included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
> > .dtsi supplied by arch/arm.
> > 
> > Unfortunately this causes some issues for the split device tree
> > repository[0], since things get moved around there. In that context
> > the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> > while the include is at src/arm/vexpress-v2m-rs1.dtsi.
> > 
> > The sharing of the .dtsi is legitimate since the baseboard is the same
> > for various vexpress systems whatever processor they use.
> > 
> > Rather than using ../../ tricks to pickup .dtsi files from another
> > arch this patch creates a new directory kernel/dts as a home for such
> > cross-arch .dtsi files and arranges for it to be in the include path
> > for both dtc and cpp. The dtsi file itself is moved into a vendor
> > subdir in this case "arm" (the vendor, not the ARCH=).
> 
> 
> Question:
> If this patch is applied, which directory will be created in
> device-tree-rebasing?
> src/kernel/, src/common/, or something else?
> Either will do, of course.

Below is the patch against the device-tree-rebasing.git, I went (pretty
much arbitrarily) with common at the top level.

commit 0524b00e5bd7b98a2a9ef85c1f5f2a8d93bcbeb6
Author: Ian Campbell <ian.campbell@citrix.com>
Date:   Tue Jul 21 17:27:13 2015 +0100

    Handle new kernel/dts subtree.
    
    Rewrite its contents to common/ and include in the CPP and DTC include
    paths.
    
    Signed-off-by: Ian Campbell <ian.campbell@citrix.com>

diff --git a/Makefile b/Makefile
index 5e8930c..b57107d 100644
--- a/Makefile
+++ b/Makefile
@@ -114,12 +114,13 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc	\
                  -Iinclude -I$(src) -Itestcase-data	\
+                 -Icommon				\
                  -undef -D__DTS__
 
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
         $(DTC) -O dtb -o $@ -b 0 \
-                -i $(src) $(DTC_FLAGS) \
+                -i $(src) -i common $(DTC_FLAGS) \
                 -d $(depfile).dtc.tmp $(dtc-tmp) ; \
         cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
diff --git a/scripts/rewrite-paths.sed b/scripts/rewrite-paths.sed
index b73fbce..5269769 100644
--- a/scripts/rewrite-paths.sed
+++ b/scripts/rewrite-paths.sed
@@ -33,6 +33,7 @@ s,\tarch/\([^/]*\)/boot/dts/\(.*\.h\)$,\tsrc/\1/\2,gp
 # Also rewrite the DTS include paths for dtc+cpp support
 s,\tarch/\([^/]*\)/include/dts/,\tsrc/\1/include/,gp
 s,\tinclude/dt-bindings/,\tinclude/dt-bindings/,gp
+s,\tkernel/dts/,\tcommon/,gp
 
 # Rewrite the bindings subdirectory
 s,\tDocumentation/devicetree/bindings/,\tBindings/,gp
