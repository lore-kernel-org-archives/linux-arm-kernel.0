From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 04 Feb 2014 12:40:50 +0000
Subject: [PATCH V6] kbuild: dtbs_install: new make target
In-Reply-To: <20140110182923.GM19878@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net> <
 1385942188-21831-1-git-send-email-jason@lakedaemon.net> <20140110182923.
 GM19878@titan.lakedaemon.net>
Message-ID: <20140204124050.60C59C407C9@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jan 2014 13:29:23 -0500, Jason Cooper <jason@lakedaemon.net> wrote:
> Grant,
> 
> On Sun, Dec 01, 2013 at 11:56:28PM +0000, Jason Cooper wrote:
> > Unlike other build products in the Linux kernel, there is no 'make
> > *install' mechanism to put devicetree blobs in a standard place.
> > 
> > This patch is an attempt to fix this problem.  Akin to 'make install',
> > this creates a new make target, dtbs_install.  The script that gets
> > called defers to a distribution or user supplied installdtbs binary,
> > if found in the system.  Otherwise, the default action is to install the
> > built dtbs into
> > 
> >   /lib/devicetrees/${kernel_version}/${dts_filename}.dtb
> > 
> > This is done to keep dtbs from different kernel versions separate until
> > things have settled down.  Once the dtbs are stable, and not so strongly
> > linked to the kernel version, the devicetree files will most likely move
> > to their own repo.  Users will need to upgrade install scripts at that
> > time.
> > 
> > /lib has been selected over /boot since /boot is often a FAT filesystem
> > and a majority of the dts filenames are longer than 8+3.
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> 
> Is this good to go?

I took another look at it and did some rework. It bothered my that the
install script didnt' have any knowledge of the actual build targets and
just blindly copied the files it finds. I've reworked the patch to make
each file a separate target and also fixed a few bugs in the process.

I also removed the call out to an external script. I'm not convinced a
call out hook is the best approach when a buildroot tool can post
process the install directory. It wouldn't be hard to add back in, but I
don't want it to block this feature. I'll post my version in a minute.

g.
