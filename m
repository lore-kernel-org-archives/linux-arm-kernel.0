From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Jul 2017 11:27:38 -0400 (EDT)
Subject: [PATCH] [RFC] ARM: move __bug_table into .data for XIP_KERNEL
In-Reply-To: <20170728141108.1283320-1-arnd@arndb.de>
References: <20170728141108.1283320-1-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1707281119450.5981@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jul 2017, Arnd Bergmann wrote:

> Matt Hart reports that vf610m4_defconfig kernels grew to 2GB
> xipImage size after the __bug_table change.
> 
> I tried out a few things and found that moving the bug table
> into the .data section avoids this problem. However, the
> linker script magic is beyond my capabilities here, so this
> is almost certainly not correct.

Well, before your patch the BUG_TABLE location as well as its runtime 
functionality were completely wrong and broken.

> I've added a few people to Cc that understand this better
> than I do, hopefully someone can turn my bogus patch into
> a proper one.

Your patch isn't as bad as you make it, but maybe the following will 
avoid open recoding BUG_TABLE locally:

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 8265b11621..21b4b29c2f 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -237,13 +237,13 @@ SECTIONS
 		 */
 		DATA_DATA
 		CONSTRUCTORS
-
-		_edata = .;
 	}
-	_edata_loc = __data_loc + SIZEOF(.data);
 
 	BUG_TABLE
 
+	_edata = .;
+	_edata_loc = __data_loc + SIZEOF(.data);
+
 #ifdef CONFIG_HAVE_TCM
         /*
 	 * We align everything to a page boundary so we can


Nicolas
