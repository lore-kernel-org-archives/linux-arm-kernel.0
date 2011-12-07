From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 07 Dec 2011 15:38:31 -0500 (EST)
Subject: [GIT PULL] Identity mapping changes for 3.3
In-Reply-To: <20111207194826.GB14542@n2100.arm.linux.org.uk>
References: <20111202160833.GK5540@mudshark.cambridge.arm.com>
 <20111205232342.GG14542@n2100.arm.linux.org.uk>
 <20111206101438.GB25782@mudshark.cambridge.arm.com>
 <20111206103843.GM14542@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112062321070.2907@xanadu.home>
 <20111207194826.GB14542@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1112071454100.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Dec 2011, Russell King - ARM Linux wrote:

> On Tue, Dec 06, 2011 at 11:25:47PM -0500, Nicolas Pitre wrote:
> > Make sure the repo on that machine is nicely packed.  Running "git gc" 
> > (gc as in garbage collect) once in a while is a good thing to do, 
> > especially that you now have the smart HTTP protocol enabled.  That will 
> > bring the memory usage way down, and serving requests will be much 
> > faster too.  It is safe to put that in a cron job once a week or so, 
> > even if concurrent requests are being serviced.
> 
> Well, I tried an experiment.  On my laptop, if I run git fsck, it takes
> around about 20 minutes to complete.

This is a bit long but reasonable.

> On ZenIV, I started this, this morning:
> 
> $ GIT_DIR=linux-2.6-arm.git git fsck
> 
> and it's now (this evening) some 10 hours after, its still going.  This
> is the exact same repository (as it's an rsync'd copy of the git objects
> and packs which are on the laptop.)

Ouch!  No, this is no good.

[...]
> As you can see, git fsck seems to be pulling data at around 50MB/s,
> presumably for 9 hours - this is rediculous because there's only 500MB
> of git data for it to read!

Well, of course the fsck process will keep a tree in memory of the 
relationship between all objects and so on.  So it certainly has 
potential for eating lots of memory and pushing the system into swap.  
And I don't think that fsck was optimized to minimize seeks like 
pack-objects does.

Of course this is not very representative of a typical git pull process 
though.  Assuming that people are already updated to v3.2-rc1, you can 
simulate the effect on the server by running:

	echo "v3.2-rc1..for-next" | \
	git pack-objects --progress --thin --revs --stdout > /dev/null

and you really really don't want such an operation to ever touch swap 
space.

> What this is saying to me is that git can't run sensibly on a dual-core
> P4, 3GHz machine with 2G of RAM and 4G swap, with a disk IO subsystem
> capable of about 50MB/s - basically, git is driving ZenIV into the ground
> (and I believe git was also responsible for ZenIV having a load average
> hitting a few hundred several months ago which resulted in us having to
> have it rebooted.)

Most likely, yes.  The disk throughput shouldn't be such a problem, but 
the lack of RAM certainly is.  And 2g of RAM to deal with a repository 
the size of the Linux kernel is making it tight.

So forget my suggestion about packing the repository on the server since 
it certainly doesn't have enough RAM to do a descent job.  You should 
consider packing it elsewhere on a biffier machine, and copying the 
resulting pack to ZenIV.  Having a well packed repository is one of the 
best way to limit memory consumption when serving a repository, but to 
produce that pack you need quite some RAM in the first place.

I'm sure many corporations involved with ARM would be more than welcome 
to sponsor some 64-bit hardware for this server and at least 8G of RAM, 
which is relatively cheap these days.

> It's worth noting that Linus tree currently has 19 pack files, my tree
> has an additional 9 on that.

One design requirement for the pack file format is that it should be 
self sufficient when on disk i.e. no delta representation may refer to a 
base object outside of the pack it is found in.  Of course the wire 
protocol is totally the opposite i.e. the packed data sent during a 
transfer is free of any object data the other end already has.  So upon 
reception over the smart protocol, any packed data has to be "completed" 
with a copy of the locally found objects for the pack to be self 
contained.  There is therefore some data redundancy that accumulates as 
the number of packs in a repository grows.  Hence the need to 
garbage collect once in a while.  Having 28 packs is normally not that 
huge a deal, but maybe the relatively small amount of RAM makes it more 
critical.


Nicolas
