From: ijc@debian.org (Ian Campbell)
Date: Wed, 16 Mar 2016 08:54:34 +0000
Subject: dtbs_install recursing on subdirs-y and dtbs-subdir leading to race?
Message-ID: <1458118474.28250.54.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of an automated build of the Debian Linux kernel packages I
think we have observed a race (or at least some unexpected extra
recursion) in the handling of dtb-subdirs vs subdirs-y in
arch/arm64/boot/dts when using make -j<N>.

Looking at the log at [0] and removing the unrelated stuff happening
due to other parallelism we see:

    make[8]: Nothing to be done for '__dtbs_install'.
mv: cannot stat '/?PKGBUILDDIR?/debian/linux-image-4.5.0-rc7-arm64/usr/lib/linux-image-4.5.0-rc7-arm64': No such file or directory
mv: cannot stat '/?PKGBUILDDIR?/debian/linux-image-4.5.0-rc7-arm64/usr/lib/linux-image-4.5.0-rc7-arm64': No such file or directory
/?PKGBUILDDIR?/scripts/Makefile.dtbinst:26: recipe for target '__dtbs_install_prep' failed
make[8]: *** [__dtbs_install_prep] Error 1
/?PKGBUILDDIR?/scripts/Makefile.dtbinst:26: recipe for target '__dtbs_install_prep' failed
make[8]: *** [__dtbs_install_prep] Error 1
  INSTALL net/bridge/netfilter/ebtable_nat.ko
/?PKGBUILDDIR?/scripts/Makefile.dtbinst:46: recipe for target 'apm' failed
make[7]: *** [apm] Error 2
make[7]: *** Waiting for unfinished jobs....
/?PKGBUILDDIR?/scripts/Makefile.dtbinst:46: recipe for target 'arm' failed
make[7]: *** [arm] Error 2
make[8]: Nothing to be done for '__dtbs_install'.
arch/arm64/Makefile:103: recipe for target 'dtbs_install' failed
make[6]: *** [dtbs_install] Error 2
Makefile:146: recipe for target 'sub-make' failed
make[5]: *** [sub-make] Error 2
Makefile:24: recipe for target '__sub-make' failed
make[4]: *** [__sub-make] Error 2
make[4]: Leaving directory '/?PKGBUILDDIR?/debian/build/build_arm64_none_arm64'
debian/rules.real:394: recipe for target 'install-image_arm64_none_arm64_dt' failed
make[3]: *** [install-image_arm64_none_arm64_dt] Error 2
make[3]: Leaving directory '/?PKGBUILDDIR?'
debian/rules.real:362: recipe for target 'install-image_arm64_none_arm64' failed
make[2]: *** [install-image_arm64_none_arm64] Error 2
make[2]: *** Waiting for unfinished jobs....

Where it appears that multiple instance of __dtbs_install_prep have
been running in parallel at least the apm and arm subdirectories of
arch/arm64/boot/dts, with both of them then racing in the?
    $(Q)if [ -d $(INSTALL_DTBS_PATH) ]; then mv $(INSTALL_DTBS_PATH) $(INSTALL_DTBS_PATH).old; fi
rule since apparently $(INSTALL_DTBS_PATH) existed during the "-d"
check but had gone by the time of the move. The build is in an
automated buildd pristine environment with INSTALL_DTBS_PATH pointing
to a brand new directory, so for $(INSTALL_DTBS_PATH) to exist at all
there must have been a third instance of __dtbs_install_prep earlier
which created it.

I understand that the mv bit of the rule in question is likely to be
removed quite soon[1] but I think the underlying race / extra recursion
still exits and might have other implications.

Ben and I have hypothesised that this is because
arch/arm64/boot/dts/Makefile has:

    subdir-y????????:= $(dts-dirs)

which means that dtbs_install recurses twice, once due to the dts-dirs
handling in scripts/Makefile.dtbinst rules (via $(dtbsinst-dirs)) and
once again for the (generic) subdir-y handling. BTW many of the subdir
Makefiles have the same construct, I'm not sure why since they have no
sub-sub-dirs, although it seems more harmless in that context.

By my reading the __dtbs_install_prep rule is supposed to run once as
part of arch/*/boot/dts/Makefile and not as part of any each of the
subdirectories.

I've experimented with removing the subdir-y assignment, but that seems
to break the dtbs and clean rules.

I'm not sure how else this can/should be fixed with Kbuild. Any ideas?

Thanks,
Ian.

[0]?https://buildd.debian.org/status/fetch.php?pkg=linux&arch=arm64&ver=4.5~rc7-1~exp1&stamp=1457444794
[1]?https://git.kernel.org/cgit/linux/kernel/git/mmarek/kbuild.git/commit/?id=5399eb9b39081d6d2fc1a13d4ea85f1ceb2c8b44
