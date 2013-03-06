From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 15:32:36 -0700
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <20130306193332.GA6022@amd.pavel.ucw.cz>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
Message-ID: <5137C404.9060902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 12:33 PM, Pavel Machek wrote:
> Hi!
> 
> Commit
> 
> commit 499cd8298628eeabf0eb5eb6525d4faa0eec80d8
> Author: Grant Likely <grant.likely@secretlab.ca>
> Date:   Tue Nov 27 16:29:11 2012 -0700
> 
>     The current rules have the .dtb files build in a different
>     directory
>     from the .dts files. The only reason for this is that it was what
>     PowerPC has done historically. This patch changes ARM to use the
> generic dtb rule which builds .dtb files in the same directory as the
> source .dts.
> 
> --
> 
> Moves dtb files from arch/arm/boot/ to arch/arm/boot/dtb. That causes
> several problems:
> 
> 1) it is inconsistent with 3.8, making switching between 3.9-rc1 and
> 3.8 tricky

It's pretty easy to locate the DTB by automatically looking in
arch/*/boot/dts first, then if the file doesn't exist there, looking in
arch/*/boot instead as a legacy fallback.

> 2) what is worse, it is very easy to do stuff like
> 
>    make socfpga_cyclone5.dtb
> 
>    and you end up with success, but stale file in arch/arm/boot, where
>    your scripts expect it.
> 
>    (There are some attempts to rm stale files in Makefiles; they don't
>    work in above case).

I guess moving the rm into cmd_dtc rather than the "dtbs" rule would
solve that.

> 3) it is now incosistent between powerpc and arm.

True. PPC's DTB-handling is a little more complex than most, so wasn't
converted along with this patch. It'd be nice to finish the conversion
and make PPC pick up this change too.

> 4) device tree _binary_ files are now output in device tree _source_
> directory

Isn't that true for almost all object files? One of the motivators for
the move was that binaries were being built in a different directory to
the source, which is quite odd.

> (Sorry for noticing this earlier).
> 
> I believe the commit should be simply reverted. Reasons to move dtbs
> around are not good enough.
> 									Pavel
> 
