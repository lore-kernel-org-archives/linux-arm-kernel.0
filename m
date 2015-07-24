From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 17:46:21 +0100
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
In-Reply-To: <20150724151559.GA12324@kroah.com>
References: <1436439433-10258-1-git-send-email-Dave.Martin@arm.com>
 <20150723220550.GA15032@kroah.com>
 <20150724095605.GI10670@e103592.cambridge.arm.com>
 <20150724151559.GA12324@kroah.com>
Message-ID: <20150724164619.GK10670@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 08:15:59AM -0700, Greg Kroah-Hartman wrote:
> On Fri, Jul 24, 2015 at 10:56:06AM +0100, Dave Martin wrote:
> > On Thu, Jul 23, 2015 at 03:05:50PM -0700, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 09, 2015 at 11:57:12AM +0100, Dave Martin wrote:
> > > > pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> > > > sufficient to inhibit pl011_int() from being triggered by a local
> > > > IRQ and trying to re-take the same lock.  This can lead to
> > > > deadlocks.
> > > > 
> > > > This patch uses the _irq() locking variants instead to ensure that
> > > > pl011_int() handling for a given port is deferred until any
> > > > pl011_tx_softirq() work for that port is complete.
> > > > 
> > > > Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
> > > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > > > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > > Cc: stable <stable@vger.kernel.org> # 4.1
> > > > ---
> > > >  drivers/tty/serial/amba-pl011.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > This doesn't apply at all to 4.2-rc3, so I can't apply it :(
> > 
> > This is applicable to 4.1 stable only, since the code this patch fixes
> > was replaced in 4.2-rc1.
> > 
> > Apologies, I didn't make that clear in the text.
> 
> I can't do anything with a 4.1-only patch, please read
> Documentation/stable_kernel_rules.txt for how to get a patch into the
> stable kernel releases.

OK, reposted[1] with a clear reference to the equivalent upstream
commit, and explanation of why this patch is different, which I'm
guessing is what was missing.

Is that sufficient?

Cheers
---Dave

[1] http://marc.info/?l=linux-serial&m=143775597205041&w=2
