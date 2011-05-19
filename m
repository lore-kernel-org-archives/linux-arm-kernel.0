From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 19 May 2011 18:31:28 +0100 (BST)
Subject: [RFC PATCH] ARM hibernation / suspend-to-disk support code
In-Reply-To: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
Message-ID: <alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

/me again ...

Sorry that this took a little ... holidays. And work. And distractions...

Anyway, here we go again, basic code to enable hibernation 
(suspend-to-disk) on ARM platforms.

Any comments highly welcome.



To use this, you need sleep.S modifications for your SoC type (to get 
__save/__restore_processor_state hooks). I've sent some of those for 
illustration earlier, they haven't changed, I've not included them here, 
so pick these changes up from:

http://68.183.106.108/lists/linux-pm/msg24020.html

The patch below only contains the _generic_ code.


This is tested on S5P6450 and OMAP3, with the sleep...S changes just 
mentioned - check the archives for those. Works both with normal swsusp and 
tuxonice (again, check the archives for the TOI modification needed).



Previously, I've reported OMAP3 video issues, after resume-from-disk. That 
isn't fully solved (it's a driver issue) but I've found a workaround: 
Trigger the resume from initramfs, after loading a logo image into the 
framebuffer and switching it on. That gets everything back without 
corruptions / wrong LCD reinitialization.

The OMAP video seems a bit of a diva; I've got one board type on which 
suspend/resume work perfectly but the omapdss driver spits out thousands 
of error interrupts during system startup (before the image is loaded), 
and the other board where all that is fine but the restore somehow garbles 
the LCD clocking (but the driver's sysfs files claim it's the same).


In short: This stuff really works now, for all I can say. And adding 
support for new type of ARM SoC doesn't touch the basic / generic code at 
all anymore either.




Anyway ...
About the patch, changes vs. all previous suggestions:

* Made the assembly sources as small as I responsibly could ;-)
   They compile for thumb2 (but I haven't tested that yet) as well.

* The page copy loop is now a C function. That also has the advantage
   that one can use cpu_switch_mm() - a macro - there for swapper_pg_dir,
   which makes resume via uswsusp ioctl or /sys/power/tuxonice/do_resume
   possible (only tested the latter, though).

* The SoC state save/restore is made to (re-)use the existing code in
   sleep....S  for the particular chip.
   OMAP3 and S5P64xx are provided as examples of that.

* The save/restore_processor_state() hooks are now used in the same way
   as e.g. existing powerpc code uses them (to trigger lazy saves before
   and perform cache flushes after).


Things that probably aren't perfect yet:

* The code currently reserves a full page for the saved "core" state.
   This is more than absolutely necessary; anyone think it's a problem ?

* it sets aside another half a page of __nosavedata page for use as
   temporary stack during the image copy (so that funcs can be called).

   Right now on ARM, that's not an issue because even with TuxOnIce in,
   there's less than 20 bytes of nosave stuff, so can as well put the
   rest of that page to good use ;-)

* I'd love to get rid of the include/asm-generic/vmlinux.lds.h change,
   as it seems that's not necessary in other architectures.
   Without that, the code gives a link error when building vmlinux
   though, and I'm unsure how to address that.

* The "integration" with the CPU sleep code is rather "backdoorish".
   While the hooks into ..._cpu_suspend aren't massive, and there's no
   code duplication, it'd be nicer to eventually have a cleaner way.

* An OMAPDSS restore troubleshooting HOWTO would be helpful ;-)


* The patch needs to be rebaselined against a current kernel;
   any preferences which tree to base this on ?



Thanks for all help with the little nits !
FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernate-19May2011.patch
Type: text/x-diff
Size: 7512 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/1d69d23c/attachment.bin>
