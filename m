From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 21 Aug 2013 10:59:07 +0100
Subject: [PATCH v2] arm: update advice on kernel, initramfs and FDT load
 address.
In-Reply-To: <20130808215429.GG19383@mudshark.cambridge.arm.com>
References: <1375974974-31603-1-git-send-email-ian.campbell@citrix.com>
 <20130808215429.GG19383@mudshark.cambridge.arm.com>
Message-ID: <1377079147.31937.37.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-08 at 22:54 +0100, Will Deacon wrote:
> On Thu, Aug 08, 2013 at 04:16:14PM +0100, Ian Campbell wrote:
> > diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
> > +overwrite it while also with the region which will be covered by the
> > +kernel's low-memory mapping.
> 
> s/with/within/ ?


Yep, ETOOMANYREWRITES trying to get it sounding right...

> > +If an initramfs is in use then, as with the dtb, it must be placed in
> > +a region of memory where the kernel decompressor will not overwrite it
> > +while also with the region which will be covered by the kernel's
> 
> Hmm, same thing here. Maybe `...will not overwrite it, whilst remaining in the
> region...'?

Also made this change. Thanks.

Unless there are any more comments on the correctness of the advice I
suppose this should go via Russell's PTS? Now to dredge up the 8 year
old memories of how that stuff works...

Thanks,
Ian.

8<----------------------

>From 43f0e4eb33e1e8895666b5faffe1d1b6080d23b2 Mon Sep 17 00:00:00 2001
From: Ian Campbell <ian.campbell@citrix.com>
Date: Mon, 29 Jul 2013 13:44:42 +0100
Subject: [PATCH] arm: update advice on kernel, initramfs and FDT load address.

  - Recommend that the kernel be placed under 128MiB, this is required if
    CONFIG_AUTO_ZRELADDR=y and good (or at least not bad) advice even if
    CONFIG_AUTO_ZRELADDR=n.
  - Recommend that a zImage kernel be placed above 32MiB, this avoids the need
    to relocate prior to decompression, which can speed up boot.
  - Add basic info on the requirements when loading a raw (non-zImage) kernel
    which are stricter than the zImage requirements.
  - Recommend that the DTB be placed after the 128MiB boundary, avoiding any
    potential conflict with the kernel decompressor, and within the lowmem
    region.  In practice it could follow the kernel loaded after 32MiB,
    assuming the kernel decompesses to less than 32MiB, but the 128MiB
    recommendation is simple and unambiguous.
  - Add similar recommendation regarding initramfs.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Roy Franz <roy.franz@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
v3: Wording fixed from Will.
v2: Update based upon discussion with Russell, Nico, Will.
    Unconditionally recommend loading the kernel below 128MiB, but above 32MiB.    Recommend loading DTB at 128MiB and initramfs right after.
    Try to focus on concrete recommendations without getting into to much
    into the details of why or other alternatives/corner cases.
---
 Documentation/arm/Booting |   42 ++++++++++++++++++++++++++++++++----------
 1 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 0c1f475..371814a 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -18,7 +18,8 @@ following:
 2. Initialise one serial port.
 3. Detect the machine type.
 4. Setup the kernel tagged list.
-5. Call the kernel image.
+5. Load initramfs.
+6. Call the kernel image.
 
 
 1. Setup and initialise RAM
@@ -120,12 +121,27 @@ tagged list.
 The boot loader must pass at a minimum the size and location of the
 system memory, and the root filesystem location.  The dtb must be
 placed in a region of memory where the kernel decompressor will not
-overwrite it.  The recommended placement is in the first 16KiB of RAM
-with the caveat that it may not be located at physical address 0 since
-the kernel interprets a value of 0 in r2 to mean neither a tagged list
-nor a dtb were passed.
+overwrite it, whilst remaining within the region which will be covered
+by the kernel's low-memory mapping.
 
-5. Calling the kernel image
+A safe location is just above the 128MiB boundary from start of RAM.
+
+5. Load initramfs.
+------------------
+
+Existing boot loaders:		OPTIONAL
+New boot loaders:		OPTIONAL
+
+If an initramfs is in use then, as with the dtb, it must be placed in
+a region of memory where the kernel decompressor will not overwrite it
+while also with the region which will be covered by the kernel's
+low-memory mapping.
+
+A safe location is just above the device tree blob which itself will
+be loaded just above the 128MiB boundary from the start of RAM as
+recommended above.
+
+6. Calling the kernel image
 ---------------------------
 
 Existing boot loaders:		MANDATORY
@@ -136,11 +152,17 @@ is stored in flash, and is linked correctly to be run from flash,
 then it is legal for the boot loader to call the zImage in flash
 directly.
 
-The zImage may also be placed in system RAM (at any location) and
-called there.  Note that the kernel uses 16K of RAM below the image
-to store page tables.  The recommended placement is 32KiB into RAM.
+The zImage may also be placed in system RAM and called there.  The
+kernel should be placed in the first 128MiB of RAM.  It is recommended
+that it is loaded above 32MiB in order to avoid the need to relocate
+prior to decompression, which will make the boot process slightly
+faster.
+
+When booting a raw (non-zImage) kernel the constraints are tighter.
+In this case the kernel must be loaded at an offset into system equal
+to TEXT_OFFSET - PAGE_OFFSET.
 
-In either case, the following conditions must be met:
+In any case, the following conditions must be met:
 
 - Quiesce all DMA capable devices so that memory does not get
   corrupted by bogus network packets or disk data. This will save
-- 
1.7.2.5
