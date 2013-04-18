From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 18 Apr 2013 21:39:57 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130418114016.GG27197@titan.lakedaemon.net>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com>
 <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
 <20130418114016.GG27197@titan.lakedaemon.net>
Message-ID: <20130418193957.GB2778@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Thu, Apr 18, 2013 at 07:40:16AM -0400, Jason Cooper wrote:
> On Thu, Apr 18, 2013 at 12:22:01PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 18, 2013 at 07:16:08AM -0400, Jason Cooper wrote:
> > > Russell, Catalin, Simon,
> > > 
> > > I'm digging through my 'onice' mail folder and found this.  I've
> > > personally experienced this bug in the past (workaround: don't use LVM
> > > on ARM systems :-( ).
> > > 
> > > Is there any interest in reviving this series?  I can dig up the patches
> > > if needed.
...
> 
> Ok, got it.  I should have been more explicit.  LVM doesn't work on ARM.
> iirc, Simon had a demo of dm-crypt also faulting on ARM.  This patch was
> not the correct approach.  Is there an interest (particularly Simon) in
> fixing the problem?
> 
> I'm willing to take a look at it, but LVM on ARM is a "nice to have" for
> me, not a critical need.  The job would be easier if Simon was willing
> to assist and lend his experience with the issue.

Just to be precise here, the problem is much more specific: Drivers
which use flush_kernel_dcache_page() on VIVT or aliasing VIPT ARM
architectures may have problems with direct I/O.

In general, LVM should work perfectly fine on ARM. But if you have
this particular combination (in my case Kirkwood ARMv5 with VIVT
D-Cache and the mv_cesa driver), you can't put a physical volume on
such a device.  LVM user space tools will just read garbage when
trying to read from the device using direct I/O.

- Simon
