From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Mar 2018 15:28:46 +0100
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <20180304204115.GD21710@lunn.ch>
References: <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
 <20180304204115.GD21710@lunn.ch>
Message-ID: <20180305142846.GJ25189@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2018 at 09:41:15PM +0100, Andrew Lunn wrote:
> On Sun, Mar 04, 2018 at 06:41:57PM +0100, Martin Michlmayr wrote:
> > A Debian user reported the following issue on QNAP TS-119P II with
> > 4.9.65:
> > 
> > * Menno Finlay-Smits <inbox@menno.io> [2018-01-21 23:08]:
> > > Rsyncing files between 2 HDDs on a QNAP 119p with a fresh, minimal install of
> > > stretch NAS (armel) causes the kernel to fail after ~20mins with a kernel
> > > memory overwrite attempt (full error below). 
> 
> Please can you give me the exact rsync command being used. Having a
> unix domain socket seems a bit odd for rsync'ing files on the same
> machine.

I played with this a bit. When you rsync with both source and target
on the same machine, it appears to fork two processes, and connect
them together via a unix domain socket.

I tried reproducing this with 4.9.86. I used the command

rsync -az /home /root/home

which copied 12G of data. No problems seen. But this is one disk. I
assume the machine giving the problem has one of the disks as USB,
since the QNAP TS-119P II is a single bay NAS. So it could be the USB
disk is slower than the internal disk, and there is a backlog building
up. First a backlog for writing out to the disk, then a backlog
forming on the Unix domain socket? So maybe that is why i cannot
reproduce it. Or the problem has been fixed between 4.9.65 and 4.9.86.

Would it be possible to try to reproduce this problem with 4.9.86 on
the hardware reporting the issue?

Thanks
	Andrew
