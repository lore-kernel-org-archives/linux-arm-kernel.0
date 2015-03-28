From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 28 Mar 2015 15:58:22 +0000
Subject: [PATCH V6] kbuild: dtbs_install: new make target
In-Reply-To: <20150328132320.GA24391@n2100.arm.linux.org.uk>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385942188-21831-1-git-send-email-jason@lakedaemon.net>
 <20150328132320.GA24391@n2100.arm.linux.org.uk>
Message-ID: <20150328155822.GA25778@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Mar 28, 2015 at 01:23:20PM +0000, Russell King - ARM Linux wrote:
> Okay, I'm digging up an old version of this patch - v7 was merged but
> I find *nowhere* where that version was posted to people involved in
> this discussion.

fwiw, I just went through my archive of patch submissions:

$ ls ~/projects/linux/dtbs_install/
v2  v3  v4  v5  v6
$

I never wrote a v7.  :-(  Regardless,

> The reason is that I would've commented on v7, because of this stupid
> thing (which is now in scripts/Makefile.dtbsinst):
> 
> +       $(Q)if [ -d $(INSTALL_DTBS_PATH).old ]; then rm -rf $(INSTALL_DTBS_PATH).old; fi
> +       $(Q)if [ -d $(INSTALL_DTBS_PATH) ]; then mv $(INSTALL_DTBS_PATH) $(INSTALL_DTBS_PATH).old; fi
> +       $(Q)mkdir -p $(INSTALL_DTBS_PATH)
> 
> What gives any kernel installation target the right to move a directory
> out of the way?
> 
> Let's say that you do this:
> 
> 	make install INSTALL_PATH=$sys_root/boot
> 	make dtbs_install INSTALL_DTBS_PATH=$sys_root/boot
> 
> The result is that dtbs_install thinks it has the right to rename that
> boot directory to boot.old, create a new one, and place the DTBs in
> there, thereby leaving you with no kernel to boot - and if you run it
> again, it _deletes_ the original directory.
> 
> No *other* kernel install target has this behaviour, not even 'make
> modules_installl'.  This is stupid and dangerous behaviour.  At the
> very least, this behaviour should be *well* documented.

you are correct.  This should be fixed.

thx,

Jason.
