From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Feb 2014 01:03:28 +0000
Subject: NFS client broken in Linus' tip
In-Reply-To: <1391201970.6978.1.camel@leira.trondhjem.org>
References: <20140130140834.GW15937@n2100.arm.linux.org.uk>
 <20140130141405.GA23985@infradead.org>
 <20140130142752.GX15937@n2100.arm.linux.org.uk>
 <20140130143208.GB9573@infradead.org>
 <20140130153812.GA15937@n2100.arm.linux.org.uk>
 <1391201970.6978.1.camel@leira.trondhjem.org>
Message-ID: <20140201010328.GI15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 03:59:30PM -0500, Trond Myklebust wrote:
> On Thu, 2014-01-30 at 15:38 +0000, Russell King - ARM Linux wrote:
> > On Thu, Jan 30, 2014 at 06:32:08AM -0800, Christoph Hellwig wrote:
> > > On Thu, Jan 30, 2014 at 02:27:52PM +0000, Russell King - ARM Linux wrote:
> > > > Yes and no.  I still end up with an empty /etc/mtab, but the file now
> > > > exists.  However, I can create and echo data into /etc/mtab, but it seems
> > > > that can't happen at boot time.
> > > 
> > > Odd.  Can you disable CONFIG_NFSD_V3_ACL for now to isolate the issue?
> > 
> > Unfortunately, that results in some problem at boot time, which
> > ultimately ends up with the other three CPUs being stopped, and
> > hence the original reason scrolls off the screen before it can be
> > read... even at 1920p.
> > 
> Hi Russell,
> 
> The following patch fixes the issue for me.

It doesn't entirely fix the issue for me, instead we've got even weirder
behaviour:

root at cubox-i4:~# ls -al test
ls: cannot access test: No such file or directory
root at cubox-i4:~# touch test
root at cubox-i4:~# ls -al test
-rw-r--r-- 1 root root 0 Feb  1 01:01 test
root at cubox-i4:~# echo foo > test
root at cubox-i4:~# ls -al test
-rw-r--r-- 1 root root 4 Feb  1 01:01 test
root at cubox-i4:~# cat test
foo
root at cubox-i4:~# rm test
root at cubox-i4:~# echo foo > test
-bash: test: Operation not supported
root at cubox-i4:~# ls -al test
-rw-r--r-- 1 root root 0 Feb  1 01:01 test

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
