From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Nov 2016 13:25:02 +0000
Subject: commit 4dd1837d7589f468ed109556513f476e7a7f9121 breaks build
In-Reply-To: <58319D70.7030106@math.uni-bielefeld.de>
References: <58310EC6.4020402@math.uni-bielefeld.de>
 <20161120113007.GS1041@n2100.armlinux.org.uk>
 <58318C6A.50104@math.uni-bielefeld.de>
 <20161120123422.GT1041@n2100.armlinux.org.uk>
 <58319D70.7030106@math.uni-bielefeld.de>
Message-ID: <20161120132502.GV1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2016 at 01:56:16PM +0100, Tobias Jakobi wrote:
> Hey Russell,
> 
> thanks for the quick reply and looking into this!
> 
> Added Nicolas Pitre to Cc since the ksym trim stuff came from him.

Arnd's patch "kbuild: provide include/asm/asm-prototypes.h for ARM" fixes
it, but I think it's a mixture of fixes, and partially dependent on some
other patches.  I don't know what the status of his patch is, but my
feeling is that it consists of more than a single fix, and needs
splitting.  Certainly the asm-prototypes.h is not relevant to this
problem, but the rest of it seems to be.

> Russell King - ARM Linux wrote:
> > On Sun, Nov 20, 2016 at 12:43:38PM +0100, Tobias Jakobi wrote:
> >> Hello Russell,
> >>
> >> Russell King - ARM Linux wrote:
> >>> None of the autobuilders are finding this problem, and they build a
> >>> wide range of configurations.  Maybe it's something specific to how
> >>> you're building the kernel - can you give step by step instructions
> >>> how to reproduce this please?
> >> Just using plain make here, no cross-compiler or anything involved. gcc
> >> is version 4.9.4.
> > 
> > Hmm.  The commit you mention was merged during the merge window, so
> > anyone building 4.9-rc1 or later should be seeing this problem, but
> > they aren't.  I've built many kernels post -rc1, and I'm not seeing
> > the problem with my 4.7.4 cross compiler.
> > 
> >> Build platform is a Exynos4412 based ODROID-X2.
> >>
> >>
> >> The complete log from the 'build modules' step:
> >>>   Building modules, stage 2.
> >>>   Kernel: arch/arm/boot/Image is ready
> >>>   MODPOST 52 modules
> >>>   XZKERN  arch/arm/boot/compressed/piggy_data
> >>>   SHIPPED arch/arm/boot/compressed/lib1funcs.S
> >>>   SHIPPED arch/arm/boot/compressed/ashldi3.S
> >>>   SHIPPED arch/arm/boot/compressed/bswapsdi2.S
> >>>   AS      arch/arm/boot/compressed/lib1funcs.o
> >>>   AS      arch/arm/boot/compressed/ashldi3.o
> >>>   AS      arch/arm/boot/compressed/bswapsdi2.o
> >>> ERROR: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> >>> ERROR: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
> >>> ERROR: "_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
> >>> ERROR: "_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [sound/core/seq/snd-seq.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [sound/core/seq/snd-seq.ko] undefined!
> >>> ERROR: "_set_bit" [net/bridge/bridge.ko] undefined!
> >>> ERROR: "_clear_bit" [net/bridge/bridge.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [net/bluetooth/hidp/hidp.ko] undefined!
> >>> ERROR: "_set_bit" [net/bluetooth/hidp/hidp.ko] undefined!
> >>> ERROR: "_clear_bit" [net/bluetooth/hidp/hidp.ko] undefined!
> >>> ERROR: "_set_bit" [net/bluetooth/bnep/bnep.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [net/bluetooth/bnep/bnep.ko] undefined!
> >>> ERROR: "_clear_bit" [net/bluetooth/bnep/bnep.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [fs/fuse/fuse.ko] undefined!
> >>> ERROR: "_set_bit" [fs/fuse/fuse.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [fs/fuse/fuse.ko] undefined!
> >>> ERROR: "_clear_bit" [fs/fuse/fuse.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [fs/cifs/cifs.ko] undefined!
> >>> ERROR: "_set_bit" [fs/cifs/cifs.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [fs/cifs/cifs.ko] undefined!
> >>> ERROR: "_clear_bit" [fs/cifs/cifs.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [fs/btrfs/btrfs.ko] undefined!
> >>> ERROR: "_set_bit" [fs/btrfs/btrfs.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [fs/btrfs/btrfs.ko] undefined!
> >>> ERROR: "_clear_bit" [fs/btrfs/btrfs.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [drivers/usb/storage/usb-storage.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/usb/storage/usb-storage.ko] undefined!
> >>> ERROR: "_clear_bit" [drivers/usb/storage/usb-storage.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/usb/gadget/libcomposite.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/usb/gadget/function/usb_f_rndis.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> >>> ERROR: "_clear_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> >>> ERROR: "_clear_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> >>> ERROR: "_clear_bit" [drivers/md/dm-crypt.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/md/dm-crypt.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/gpu/arm/mali/maligpu.ko] undefined!
> >>> ERROR: "_clear_bit" [drivers/gpu/arm/mali/maligpu.ko] undefined!
> >>> ERROR: "_test_and_clear_bit" [drivers/bluetooth/btusb.ko] undefined!
> >>> ERROR: "_test_and_set_bit" [drivers/bluetooth/btusb.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/bluetooth/btusb.ko] undefined!
> >>> ERROR: "_clear_bit" [drivers/bluetooth/btusb.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/bluetooth/btintel.ko] undefined!
> >>> ERROR: "_set_bit" [drivers/bluetooth/btbcm.ko] undefined!
> >>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> >>> make[1]: *** [__modpost] Error 1
> >>> Makefile:1191: recipe for target 'modules' failed
> >>> make: *** [modules] Error 2
> >>
> >>
> >> This is the config I'm using for the build:
> >> https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.9-debug.conf
> > 
> > You have CONFIG_TRIM_UNUSED_KSYMS enabled - I wonder if that's the
> > issue.  I've just enabled that here, and building I see:
> Thanks, I had this enabled on purpose since I don't need any out-of-tree
> drivers for this board.
> 
> I'll check if disabling TRIM_UNUSED_KSYMS also does the trick for me.
> 
> 
> With best wishes,
> Tobias
> 
> 
> >   EXPORTS lib/lib-ksyms.o
> >   LD      lib/built-in.o
> >   CHK     include/generated/autoksyms.h
> >   KSYMS   symbols: before=0, after=2413, changed=2413
> >   UPD     include/generated/autoksyms.h
> > 
> > and then the build seems to restart from the very beginning, which seems
> > rather fishy - it doubles the build time of the kernel.  The second
> > build doesn't even hit any ccache entries from the first build.  Then we
> > get through the rebuild, and I get:
> > 
> >   EXPORTS lib/lib-ksyms.o
> >   LD      lib/built-in.o
> >   CHK     include/generated/autoksyms.h
> >   LD      vmlinux.o
> > ...
> >   LD      vmlinux
> >   SORTEX  vmlinux
> >   SYSMAP  System.map
> >   Building modules, stage 2.
> >   OBJCOPY arch/arm/boot/Image
> >   Kernel: arch/arm/boot/Image is ready
> >   AS      arch/arm/boot/compressed/head.o
> >   LZO     arch/arm/boot/compressed/piggy_data
> >   MODPOST 465 modules
> > ERROR:   CC      arch/arm/boot/compressed/misc.o
> > "_clear_bit" [net/sched/sch_teql.ko] undefined!
> > ERROR: "_set_bit" [net/sched/sch_teql.ko] undefined!
> > ERROR: "_set_bit" [net/sched/cls_u32.ko] undefined!
> > ERROR: "_test_and_set_bit" [net/netfilter/nfnetlink_acct.ko] undefined!
> > ERROR: "_clear_bit" [net/netfilter/nfnetlink_acct.ko] undefined!
> > ERROR: "_test_and_clear_bit" [net/mac80211/mac80211.ko] undefined!
> > ERROR: "_set_bit" [net/mac80211/mac80211.ko] undefined!
> > ERROR: "_test_and_set_bit" [net/mac80211/mac80211.ko] undefined!
> > ERROR: "_clear_bit" [net/mac80211/mac80211.ko] undefined!
> > 
> > So yes, it's caused by this ksyms trimming.
> > 
> > Now, the thing is that include/generated/autoksyms.h contains:
> > 
> > #define __KSYM__change_bit 1
> > #define __KSYM__clear_bit 1
> > #define __KSYM__set_bit 1
> > #define __KSYM__test_and_change_bit 1
> > #define __KSYM__test_and_clear_bit 1
> > #define __KSYM__test_and_set_bit 1
> > 
> > amongst many other stuff - presumably this is a list of ksyms which
> > should be included, rather than a list of what should be excluded.
> > 
> > I'm afraid that I never saw the patches which changed the way the ksyms
> > stuff worked for the assembly files, and these patches have caused
> > several problems for ARM.  I'm not aware of what the changes were, or
> > how the damn exports now work, so I'm currently at a loss what to
> > suggest at the moment, other than to disable CONFIG_TRIM_UNUSED_KSYMS in
> > your configuration until someone can work out wtf is going on.
> > 
> > I guess I'm going to have to work out how this stuff now works - don't
> > expect a solution quickly, especially as building with this option
> > enabled is soo time consuming (like, half an hour per build.)
> > 
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
