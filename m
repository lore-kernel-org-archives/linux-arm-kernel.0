From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Mar 2013 12:54:56 -0700
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <20130328193323.GA25166@amd.pavel.ucw.cz>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
 <5137C404.9060902@wwwdotorg.org>
 <20130307144506.GB7344@amd.pavel.ucw.cz>
 <5138FDAE.8060202@wwwdotorg.org>
 <20130311050546.GA21863@quad.lixom.net>
 <CACxGe6vkC7fjzf1-+K8O81+w=jQ63PvuTEhSPyitEBA9XiKYnw@mail.gmail.com>
 <20130328092916.GA11187@amd.pavel.ucw.cz>
 <51545870.4010209@wwwdotorg.org>
 <20130328193323.GA25166@amd.pavel.ucw.cz>
Message-ID: <20130328195456.GA22527@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 08:33:23PM +0100, Pavel Machek wrote:
> On Thu 2013-03-28 08:49:20, Stephen Warren wrote:
> > On 03/28/2013 03:29 AM, Pavel Machek wrote:
> > ...
> > > There's change that makes it pretty much impossible to build dtbs
> > > reliably between different kernel versions, because it leaves old dtbs
> > > around, and they survive even make clean.
> > 
> > One question here: Presumably the dtbs don't survive "make clean" if you
> > run that right after building the dtbs, but only if you check out a new
> > kernel version before running clean? Or is that not the case?
> 
> That was the case I seen, yes.
> 
> Have old kernel running, dtbs building. Apply a patch. It starts
> behaving weird. You do make clean... but you still get old dtbs.
> 
> (It would be nice if make socfpga_cyclone5.dtb would magically remove
> all the dtbs from old location; make dtbs does that if I understand
> stuff correctly).


This takes care of the "make dtbs" case (or just "make" case), but not
when you build a specific target.




ARM: dts: remove stale dtb files from arch/arm/boot

This will result in stale dtb files being removed from arch/arm/boot, which
can cause confusion when someone goes from an older kernel version to a newer
one without doing make clean on the old version (or git clean -f -d -x).


Signed-off-by: Olof Johansson <olof@lixom.net>

index 84aa2ca..b1127b8 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -115,4 +115,5 @@ i:
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
+clean-files := *.dtb
 subdir-	    := bootp compressed dts
