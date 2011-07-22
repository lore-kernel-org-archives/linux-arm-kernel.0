From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 22 Jul 2011 12:27:18 +0200
Subject: [PATCH v2] ARM: support XZ compressed kernels
In-Reply-To: <20110722095738.GE21416@n2100.arm.linux.org.uk>
References: <1310475369-3000-1-git-send-email-kaloz@openwrt.org>
	<20110715162519.GC24628@n2100.arm.linux.org.uk>
	<op.vyptiwow2s3iss@ecaz>
	<20110719110235.GH26574@n2100.arm.linux.org.uk>
	<20110719110717.GI26574@n2100.arm.linux.org.uk>
	<20110722091604.GC21416@n2100.arm.linux.org.uk>
	<op.vy0lphg52s3iss@ecaz>
	<20110722095738.GE21416@n2100.arm.linux.org.uk>
Message-ID: <op.vy0nbsz22s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jul 2011 11:57:38 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Jul 22, 2011 at 11:52:19AM +0200, Imre Kaloz wrote:
>
>> Guessed I'm not the one outside the ARM community, so.. I can say it
>> didn't break neither ppc or mips for me, but have no idea who's feedback
>> are you waiting for.
>
> What I'm concerned about is the apparant lack of exposure of the patch
> to people outside of ARM, especially as it touches lib/xz/xz_dec_stream.c.
>
> I have no idea whether that breaks some architecture or not.
>
> Is Lasse Collin (the original contributer of that file) aware of this
> change?
>
> What is the additional include fixing on ARM?  Why isn't this include
> needed on other architectures?  And why isn't any of this mentioned in
> the patch commit log?
>

It's needed because of missing min_t - but just looked a bit further and it seems decompress.c should use kernel.h - so I send v3 right away with the following change if you agree:

--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -1,7 +1,7 @@
  #define _LINUX_STRING_H_

  #include <linux/compiler.h>	/* for inline */
-#include <linux/types.h>	/* for size_t */
+#include <linux/kernel.h>	/* for min_t */
  #include <linux/stddef.h>	/* for NULL */
  #include <linux/linkage.h>
  #include <asm/string.h>
