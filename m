From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 8 Jul 2014 15:05:02 +0200
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
References: <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
 <539F691E.5030204@wwwdotorg.org> <20140617121313.GE18816@ulmo>
 <20140617140146.GH3407@tbergstrom-lnx.Nvidia.com>
 <20140617215119.GC24743@mithrandir>
 <20140618121806.GJ3407@tbergstrom-lnx.Nvidia.com>
 <53A1B252.1030204@wwwdotorg.org>
 <20140619080234.GK3407@tbergstrom-lnx.Nvidia.com>
 <53A3096B.1040409@wwwdotorg.org>
 <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140708130501.GC9516@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 01:14:42PM +0300, Peter De Schrijver wrote:
> On Thu, Jun 19, 2014 at 06:01:47PM +0200, Stephen Warren wrote:
> > On 06/19/2014 02:02 AM, Peter De Schrijver wrote:
> > > On Wed, Jun 18, 2014 at 05:37:54PM +0200, Stephen Warren wrote:
> > >> On 06/18/2014 06:18 AM, Peter De Schrijver wrote:
> > >>> On Tue, Jun 17, 2014 at 11:51:20PM +0200, Thierry Reding wrote:
> > >>>> * PGP Signed by an unknown key
> > >>>>
> > >>>> On Tue, Jun 17, 2014 at 05:01:46PM +0300, Peter De Schrijver wrote:
> > >>>>> On Tue, Jun 17, 2014 at 02:13:15PM +0200, Thierry Reding wrote:
> > >>>>>>> Old Signed by an unknown key
> > >>>>>>
> > >>>>>> On Mon, Jun 16, 2014 at 04:01:02PM -0600, Stephen Warren wrote:
> > >>>>>>> On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > >>>>>>>> This symbol needs to be exported to power on rails without using
> > >>>>>>>> tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
> > >>>>>>>> cannot be used in situations where the driver wants to handle clocking
> > >>>>>>>> by itself.
> > >>>>>>>
> > >>>>>>> Thierry, are you OK with this change?
> > >>>>>>
> > >>>>>> I would've preferred tegra_powergate_sequence_power_up() to be used
> > >>>>>
> > >>>>> I don't think the current tegra_powergate_sequence_power_up() API is very well
> > >>>>> defined though. I don't think the clocks and resets required by the sequence
> > >>>>> should be provided by the driver. For one, there can be several clocks and
> > >>>>> resets that need to be controlled for a single domain.
> > >>>>
> > >>>> Do you have any suggestions for what the API should look like? Even if
> > >>>> we plan to move to some different API, I think there's some advantage in
> > >>>> using it consistently if for no other reason than to make it easier to
> > >>>> replace occurrences later on.
> > >>>>
> > >>>
> > >>> I think the API should only have the domain ID as input so:
> > >>>
> > >>> int tegra_powerdomain_on(int id) 
> > >>>
> > >>> /*
> > >>>  * Prerequisites: domain is off
> > >>>  * Result: domain is on, clocks of the modules in the domain are off, modules are in reset
> > >>>  */
> > >>>
> > >>> int tegra_powerdomain_off(int id)
> > >>>
> > >>> /*
> > >>>  * Prerequisites: all clocks of the modules in the domain are off
> > >>>  * result: domain is off
> > >>>  */
> > >>
> > >> That doesn't make sense; the PMC doesn't have access to the clock and
> > >> reset IDs - that's why the API requires them to be passed in.
> > >>
> > > 
> > > We should make driver look them up by name then. It doesn't make sense to
> > > move this knowledge to the drivers as there can be several modules in 1
> > > powerdomain. So every driver would then need to have access to all clock
> > > and reset IDs of the modules of the domain?
> > 
> > Having the drivers know the clocks, resets, and power domains that
> > affect their HW module seems perfectly reasonable.
> > 
> 
> Yes, but the problem is that you also need clocks and reset of other modules
> in the same domain to safely control the domain's status. Eg: the ISPs, VI and
> CSI share a domain. VI and CSI are useable without ISP and the ISP lacks
> public documentation. So it's not unlikely a VI and CSI driver will upstreamed
> someday which means we would need to control the domain and therefore would
> need to tell that driver about the ISPs clocks and resets even though the
> driver doesn't know anything about the ISP hw otherwise.

Can't we make powergates reference counted so that they don't get
disabled as long as there are any users? Looking for example at the
display controller driver, modules don't seem to care overly much about
the powergate's state except that it needs to be turned on before they
touch some of the registers.

>From a bit of experimentation it also seems like the sequence encoded
within tegra_powergate_sequence_power_up() isn't at all necessary. I
couldn't find an authoritative reference for that either, so I'm tempted
to conclude that it was simply cargo-culted from the dark-ages.

So I'm thinking that if we ever move to use power domains for this, we
may be able to just drop any extra handling (well, we'd need to keep it
for backwards-compatibility... *sigh*) and let drivers handle the clock
and reset resources.

On the other hand, given that we already need to keep the existing code
for backwards-compatibility, I'm not sure there's a real advantage in
turning them into power domains, since we'd be adding extra code without
an clear gains (especially since it seems like we'd need even more code
to properly handle suspend/resume in drivers that need powergates).

> > Do we actually have any case where unrelated modules are in the same
> > power domain /and/ there's some need for those drivers to manipulate the
> > power domain?
> > 
> 
> According to the TRM, the reset state of the power domains is undefined. While
> that seems unlikely, I do think the kernel should not assume any domain is on
> apart from the obvious ones (like the CPU domain it is running on),

Hm... I thought I had seen some documents specifically giving the reset
states of the power partitions. Perhaps it wasn't in the TRM, though.
But I agree that drivers generally shouldn't be assuming anything about
the power partition states.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/c9da3d66/attachment.sig>
