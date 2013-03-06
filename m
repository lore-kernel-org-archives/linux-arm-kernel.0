From: pavel@denx.de (Pavel Machek)
Date: Wed, 6 Mar 2013 20:33:32 +0100
Subject: 3.9-rc1 regression in arm dtb build
Message-ID: <20130306193332.GA6022@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Commit

commit 499cd8298628eeabf0eb5eb6525d4faa0eec80d8
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Nov 27 16:29:11 2012 -0700

    The current rules have the .dtb files build in a different
    directory
    from the .dts files. The only reason for this is that it was what
    PowerPC has done historically. This patch changes ARM to use the
generic dtb rule which builds .dtb files in the same directory as the
source .dts.

--

Moves dtb files from arch/arm/boot/ to arch/arm/boot/dtb. That causes
several problems:

1) it is inconsistent with 3.8, making switching between 3.9-rc1 and
3.8 tricky

2) what is worse, it is very easy to do stuff like

   make socfpga_cyclone5.dtb

   and you end up with success, but stale file in arch/arm/boot, where
   your scripts expect it.

   (There are some attempts to rm stale files in Makefiles; they don't
   work in above case).

3) it is now incosistent between powerpc and arm.

4) device tree _binary_ files are now output in device tree _source_
directory

(Sorry for noticing this earlier).

I believe the commit should be simply reverted. Reasons to move dtbs
around are not good enough.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
