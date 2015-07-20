From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 15:14:25 +0200
Subject: [PATCH V3 02/19] memory: tegra: Add MC flush support
In-Reply-To: <20150720095941.GZ6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
 <20150717113124.GP3057@ulmo>
 <20150720095941.GZ6287@tbergstrom-lnx.Nvidia.com>
Message-ID: <20150720131410.GA1098@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 12:59:41PM +0300, Peter De Schrijver wrote:
> On Fri, Jul 17, 2015 at 01:31:24PM +0200, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> > > On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> > > > > Old Signed by an unknown key
> > > > 
> > > > On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> > > > > The Tegra memory controller implements a flush feature to flush pending
> > > > > accesses and prevent further accesses from occurring. This feature is
> > > > > used when powering down IP blocks to ensure the IP block is in a good
> > > > > state. The flushes are organised by software groups and IP blocks are
> > > > > assigned in hardware to the different software groups. Add helper
> > > > > functions for requesting a handle to an MC flush for a given
> > > > > software group and enabling/disabling the MC flush itself.
> > > > > 
> > > > > This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
> > > > > 
> > > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > > ---
> > > > >  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  drivers/memory/tegra/mc.h |   2 +
> > > > >  include/soc/tegra/mc.h    |  34 ++++++++++++++
> > > > >  3 files changed, 146 insertions(+)
> > > > 
> > > > Do we know if this is actually necessary? I remember having a discussion
> > > > with Arnd Bergmann a while ago, and the Linux driver model kind of
> > > > assumes that by the time a device is disabled all outstanding accesses
> > > > will have stopped.
> > > > 
> > > > Do we have a way to determine that this even makes a difference? Can we
> > > > trigger a case where not doing this would cause breakage and see that
> > > > adding this fixes that particular issue?
> > > > 
> > > 
> > > Most likely it is. The memory controller can still be processing requests
> > > when the peripheral domain is powergated. This would mean the response cannot
> > > be delivered in that case. So we need to be sure there are no outstanding
> > > requests before shutting down the domain.
> > 
> > My point is that that's the driver's responsibility anyway, hence making
> > the explicit flush unnecessary.
> > 
> 
> The peripheral driver doesn't know how long a request is queued in the memory
> controller. So it can't be responsible for ensuring this.

Surely whenever the peripheral reports that the operation is done (be
that via some DMA controller interrupt or syncpoint increment) the
operation would have flushed from the memory controller. Drivers are
already supposed to make sure this is the case when they are removed or
suspended, so this would mean that we'd be adding all this code for no
real gain.

It would also explain why we're currently not seeing any such problems.

Also note that I'm not saying no to this, I merely want to make sure
that it's necessary, and in order to prove so we need tests to produce
enough traffic for this to be exposed, and then we can also verify that
the patches actually do what they're supposed to.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/5cb9197d/attachment-0001.sig>
