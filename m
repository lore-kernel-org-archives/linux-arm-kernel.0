From: trini@konsulko.com (Tom Rini)
Date: Wed, 16 Aug 2017 20:35:02 -0400
Subject: [PATCH] dts: Make it easier to enable __symbols__ generation in dtb
 files
Message-ID: <1502930102-8648-1-git-send-email-trini@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces the variabe DTC_EXTRA_FLAGS to allow for additional
flags to be passed to dtc.  While this can have many uses (such as
easier testing of new warning flags) the use case I wish to spell out
here is passing of -@ to enable __symbols__ to be included in the
resulting dtb and thus 'stacked' overlays to be able to be used.

When passing in -@ this will increase the size of the dtb (and resident
memory usage) in exchange for allowing more types of overlays to be
applied to the dtb file prior to passing it to Linux and additional
functionality within the kernel when OF_OVERLAY is enabled and in tools
outside of the kernel.

Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <mmarek@suse.com>
CC: linux-kbuild at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Tom Rini <trini@konsulko.com>
---
This would be v3 of my attempt to enable __symbols__ more widely (v2,
for people not on the CC, enabled it always, but for some boards).

To be clear, this version of the patch is more flexible in that it
allows for arbitrary flags to be passed to dtc, which can have other
uses.  But, I'm still spelling out -@ being the motivation behind this
for clarity.  Both Frank and Rob were uncomfortable with v2, and Frank
suggested this approach to make it easier for users  / distributions /
etc to opt-in to this functionality.  For clarity, Frank was suggesting
(at least at first) perhaps also a tie-in CONFIG option, which I have
not done here as I feel that's adding extra hurdles to something that
must already be opt-in.  Given that today many of the immediate uses are
for "pre-boot" application of overlays (SoM + carrier + add-ons or EVM +
LCD for example), I believe this is an acceptable trade-off to make
currently.
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 58c05e5d9870..04434ffe3370 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -293,7 +293,7 @@ DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wproperty_name_chars_strict
 endif
 
-DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
+DTC_FLAGS += $(DTC_FLAGS_$(basetarget)) $(DTC_EXTRA_FLAGS)
 
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTB     $@
-- 
1.9.1
