From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Mar 2013 15:45:07 +0100
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <5137C404.9060902@wwwdotorg.org>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
 <5137C404.9060902@wwwdotorg.org>
Message-ID: <20130307144506.GB7344@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > commit 499cd8298628eeabf0eb5eb6525d4faa0eec80d8
> > Author: Grant Likely <grant.likely@secretlab.ca>
> > Date:   Tue Nov 27 16:29:11 2012 -0700
...
> > 1) it is inconsistent with 3.8, making switching between 3.9-rc1 and
> > 3.8 tricky
> 
> It's pretty easy to locate the DTB by automatically looking in
> arch/*/boot/dts first, then if the file doesn't exist there, looking in
> arch/*/boot instead as a legacy fallback.

Unfortunately, that does not work. See 2) below. Stale files even
survive "make clean".

3.9-rc1:

[pavel at pollux linux]$ ls -al arch/arm/boot/dts/socfpga_cyclone5.dtb 
-rw-rw-r-- 1 pavel pavel 3335 Mar  6 14:55
arch/arm/boot/dts/socfpga_cyclone5.dtb
[pavel at pollux linux]$ cp arch/arm/boot/dts/socfpga_cyclone5.dtb
arch/arm/boot/socfpga_cyclone5.dtb 
[pavel at pollux linux]$ ls -al arch/arm/boot/socfpga_cyclone5.dtb
-rw-rw-r-- 1 pavel pavel 3335 Mar  7 15:41
arch/arm/boot/socfpga_cyclone5.dtb
[pavel at pollux linux]$ make clean
  CLEAN   .
  CLEAN   drivers/tty/vt
  CLEAN   kernel
  CLEAN   lib
  CLEAN   .tmp_versions
[pavel at pollux linux]$ ls -al arch/arm/boot/socfpga_cyclone5.dtb
-rw-rw-r-- 1 pavel pavel 3335 Mar  7 15:41
arch/arm/boot/socfpga_cyclone5.dtb
[pavel at pollux linux]$ make socfpga_cyclone5.dtb

> > 2) what is worse, it is very easy to do stuff like
> > 
> >    make socfpga_cyclone5.dtb
> > 
> >    and you end up with success, but stale file in arch/arm/boot, where
> >    your scripts expect it.
> > 
> >    (There are some attempts to rm stale files in Makefiles; they don't
> >    work in above case).
> 
> I guess moving the rm into cmd_dtc rather than the "dtbs" rule would
> solve that.

Yep, I guess something like that should be done.

> > 3) it is now incosistent between powerpc and arm.
> 
> True. PPC's DTB-handling is a little more complex than most, so wasn't
> converted along with this patch. It'd be nice to finish the conversion
> and make PPC pick up this change too.

Why break people's build scripts? What is the advantage? Having
binaries in same directory... ok but not worth the breakage.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
