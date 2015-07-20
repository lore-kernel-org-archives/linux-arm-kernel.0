From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 11:17:44 +0200
Subject: [PATCH V3 02/19] memory: tegra: Add MC flush support
In-Reply-To: <55ACB54A.4080103@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
 <20150717113124.GP3057@ulmo> <55ACB54A.4080103@nvidia.com>
Message-ID: <20150720091743.GO29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 09:46:02AM +0100, Jon Hunter wrote:
> 
> On 17/07/15 12:31, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> >> On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> >>>> Old Signed by an unknown key
> >>>
> >>> On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> >>>> The Tegra memory controller implements a flush feature to flush pending
> >>>> accesses and prevent further accesses from occurring. This feature is
> >>>> used when powering down IP blocks to ensure the IP block is in a good
> >>>> state. The flushes are organised by software groups and IP blocks are
> >>>> assigned in hardware to the different software groups. Add helper
> >>>> functions for requesting a handle to an MC flush for a given
> >>>> software group and enabling/disabling the MC flush itself.
> >>>>
> >>>> This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
> >>>>
> >>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >>>> ---
> >>>>  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  drivers/memory/tegra/mc.h |   2 +
> >>>>  include/soc/tegra/mc.h    |  34 ++++++++++++++
> >>>>  3 files changed, 146 insertions(+)
> >>>
> >>> Do we know if this is actually necessary? I remember having a discussion
> >>> with Arnd Bergmann a while ago, and the Linux driver model kind of
> >>> assumes that by the time a device is disabled all outstanding accesses
> >>> will have stopped.
> >>>
> >>> Do we have a way to determine that this even makes a difference? Can we
> >>> trigger a case where not doing this would cause breakage and see that
> >>> adding this fixes that particular issue?
> >>>
> >>
> >> Most likely it is. The memory controller can still be processing requests
> >> when the peripheral domain is powergated. This would mean the response cannot
> >> be delivered in that case. So we need to be sure there are no outstanding
> >> requests before shutting down the domain.
> > 
> > My point is that that's the driver's responsibility anyway, hence making
> > the explicit flush unnecessary.
> 
> I see your point and it is interesting. The trouble is that we would
> need to test every memory client in every power domain to prove this. So
> I don't think that is a trivial thing to do. Furthermore, looking at
> what we have done in kernel used for android products (which probably
> stress PM the most) this is done and so I don't know of any shipping
> product that stresses PM that does not do this. May be someone else
> might. I personally would not be comfortable removing this without
> testing, but as I mentioned it is not a trivial thing to test correctly.
> However, I will let you and the other maintainers decide what's best here.

Quite frankly, I'm fairly sure most of this is untested anyway. There
isn't a good way to test gr3d for example.

Generally I lean towards not merging any code that we don't know is
needed. Merely because Android kernels do something doesn't mean it is
necessary to do it (or even sane in some cases).

Now I understand that it might be difficult to test this, but that's all
the more reason not to include the code. If we find that we have bugs
that this can fix, then we can come up with tests to trigger it and
validate that the fix actually fixes something.

In other words, I don't think it makes sense to implement mechanisms to
recover from situations that we have no way of triggering in the first
place.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/0c490974/attachment.sig>
