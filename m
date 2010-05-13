From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 May 2010 10:15:14 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <20100512150057.GA29867@atrey.karlin.mff.cuni.cz>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<20100512150057.GA29867@atrey.karlin.mff.cuni.cz>
Message-ID: <1273709714.21352.138.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 17:00 +0200, Jan Kara wrote:

>  Could you get the filesystem image with: e2image -r /dev/sdb2 buggy-image
> bzip2 it and make it available somewhere? Maybe I could guess something
> from the way the filesystem gets corrupted.
>  Oh, and also overwrite the partition with zeros before calling mkfs to make
> the analysis simpler.

Here we go.

Created a smaller partition (100MB). dd'ed /dev/zero to it, dd'ed it off
to NFS host to locally cmp it with /dev/zero to make sure it's nice and
clean. It is. Then mkfs.ext3, mount, rsync over /usr/lib of my test
root, unmount, and dd it off to the NFS host again.

The result shows the same errors with fsck.ext3 -n -f ./test.img

I uploaded it at:

http://gate.crashing.org/~benh/test.img.bz2

Cheers,
Ben.

> > In fact, if I do ls /mnt/test/usr/bin/ I see debconf but if I do
> > ls /mnt/test/usr/bin/chrt then I get No such file or directory.
> > 
> > So something is badly wrong :-)
> > 
> > Now, trying without the dir_index feature (mkfs.ext3 -O ^dir_index)
> > and it works fine. All my md5sum's are correct and fsck passes.
>   Funny. Not sure how that could happen...
> 
> 								Honza
