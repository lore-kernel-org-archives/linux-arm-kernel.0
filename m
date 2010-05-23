From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 May 2010 10:01:39 +0100
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <87pr0n31q2.fsf@free.fr>
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
	<87fx1k46qg.fsf@free.fr>
	<20100522094637.GA954@n2100.arm.linux.org.uk>
	<87pr0n31q2.fsf@free.fr>
Message-ID: <20100523090139.GA950@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 23, 2010 at 02:23:33AM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > You could boot with 'quiet' so that the kernel shuts up most of the
> > noisy kernel messages.
> 
> With "quiet" option, the kernel console outputs only 1 line :
> "Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)"

Right, so none of the errors in the ARM MM initialization are being
triggered, so the initrd image isn't being corrupted.

The reason that initrd_start is zero at rd_load_ramdisk is that in
populate_rootfs(), the initrd is written into the ramfs root as a
/initrd.image file.  Then the original initrd image is freed, resulting
in both initrd_start and initrd_end being zeroed.

Do you have CONFIG_BLK_DEV_RAM enabled?  Try some debugging (using
pr_err() and booting with 'quiet' so you can see the output) in
populate_rootfs().
