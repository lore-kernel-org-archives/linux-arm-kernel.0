From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Mar 2015 13:23:20 +0000
Subject: [PATCH V6] kbuild: dtbs_install: new make target
In-Reply-To: <1385942188-21831-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385942188-21831-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20150328132320.GA24391@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, I'm digging up an old version of this patch - v7 was merged but
I find *nowhere* where that version was posted to people involved in
this discussion.

The reason is that I would've commented on v7, because of this stupid
thing (which is now in scripts/Makefile.dtbsinst):

+       $(Q)if [ -d $(INSTALL_DTBS_PATH).old ]; then rm -rf $(INSTALL_DTBS_PATH).old; fi
+       $(Q)if [ -d $(INSTALL_DTBS_PATH) ]; then mv $(INSTALL_DTBS_PATH) $(INSTALL_DTBS_PATH).old; fi
+       $(Q)mkdir -p $(INSTALL_DTBS_PATH)

What gives any kernel installation target the right to move a directory
out of the way?

Let's say that you do this:

	make install INSTALL_PATH=$sys_root/boot
	make dtbs_install INSTALL_DTBS_PATH=$sys_root/boot

The result is that dtbs_install thinks it has the right to rename that
boot directory to boot.old, create a new one, and place the DTBs in
there, thereby leaving you with no kernel to boot - and if you run it
again, it _deletes_ the original directory.

No *other* kernel install target has this behaviour, not even 'make
modules_installl'.  This is stupid and dangerous behaviour.  At the
very least, this behaviour should be *well* documented.

Linus, will you take a patch to remove the lines moving a pre-existing
INSTALL_DTBS_PATH directory out of the way?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
