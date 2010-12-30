From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 20:18:46 +0100
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1293731992.4919.5.camel@heimdal.trondhjem.org>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
Message-ID: <20101230191846.GB14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trond,

On Thu, Dec 30, 2010 at 12:59:52PM -0500, Trond Myklebust wrote:
> On Thu, 2010-12-30 at 18:14 +0100, Uwe Kleine-K?nig wrote: 
> > I wonder if the nfs-stuff is considered to be solved, because I still
> > see strange things.
> > 
> > During boot my machine sometimes (approx one out of two times) hangs with
> > the output pasted below on Sysctl-l.  The irq 
> > 
> > I'm not 100% sure it's related, but at least it seems to hang in
> > nfs_readdir.  (When the serial irq happend that triggered the sysrq the
> > program counter was at 0xc014601c, which is fs/nfs/dir.c:647 for me.)
> > 
> > This is on 2.6.37-rc8 plus some patches for machine support on an ARM
> > machine.
> 
> Ccing linux-nfs at vger.kernel.org
Yeah, good idea.  I had that ~2min after sending my report during
dinner, sorry :-\
 
> What filesystem are you exporting on the server? What is the NFS
> version? Is this nfsroot, autofs or an ordinary nfs mount?
This is an nfsroot of /home/ukl/nfsroot/tx28 which is a symlink to a
directory on a different partition.  I don't know the filesystem of my
homedir as it resides on a server I have no access to, but I asked the
admin, so I can follow up with this info later (I'd suspect ext3, too).
The real root directory is on ext3 (rw,noatime).

The serving nfs-server is Debian's nfs-kernel-server 1:1.2.2-1.
nfs-related kernel parameters are

	ip=dhcp root=/dev/nfs nfsroot=192.168.23.2:/home/ukl/nfsroot/tx28,v3,tcp

I hope this answers your questions.  If not, please ask.

I tried without the symlink and saw some different errors, e.g.

	starting splashutils daemon.../etc/rc.d/S00splashutils: line 50: //sbin/fbsplashd.static: Unknown error 521

(this is the init script that hung before) and

	[    6.160000] NFS: server 192.168.23.2 error: fileid changed
	[    6.160000] fsid 0:c: expected fileid 0x33590a4, got 0x4d11bedc

but no hang as before.  So maybe it's related to the symlink?  I don't
know if testing that further would help or just waste of my time, so
please let me know if I can help you and how.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
