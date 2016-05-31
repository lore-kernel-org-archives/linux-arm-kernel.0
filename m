From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 17:56:30 +0100
Subject: [PATCH v2 2/4] Documentation: Add documentation for APM X-Gene
 SoC PMU DTS binding
In-Reply-To: <CACgAJHyT31DuVNoyRQZVKjv=zM5Fc-EY0gy=y=pHHrBTT+1Xow@mail.gmail.com>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
 <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
 <20160418170009.GA15338@rob-hp-laptop>
 <CACgAJHyBbO_LXwtfNVK1f=dY3v1Jfxwxq1dw98EZ0aYdhjPpAg@mail.gmail.com>
 <20160420113121.GE2514@arm.com>
 <20160502205648.GA7374@rob-hp-laptop>
 <CACgAJHyT31DuVNoyRQZVKjv=zM5Fc-EY0gy=y=pHHrBTT+1Xow@mail.gmail.com>
Message-ID: <20160531165630.GE4254@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 02:46:05PM -0700, Tai Tri Nguyen wrote:
> Hi Rob,
> 
> On Mon, May 2, 2016 at 1:56 PM, Rob Herring <robh@kernel.org> wrote:
> > On Wed, Apr 20, 2016 at 12:31:22PM +0100, Will Deacon wrote:
> >> On Mon, Apr 18, 2016 at 01:04:53PM -0700, Tai Tri Nguyen wrote:
> >> > >> +Required properties for MCB subnode:
> >> > >> +- compatible         : Shall be "apm,xgene-pmu-mcb".
> >> > >> +- reg                        : First resource shall be the MCB PMU resource.
> >> > >> +- index                      : Instance number of the MCB PMU.
> >> > >> +
> >> > >> +Required properties for MC subnode:
> >> > >> +- compatible         : Shall be "apm,xgene-pmu-mc".
> >> > >> +- reg                        : First resource shall be the MC PMU resource.
> >> > >> +- index                      : Instance number of the MC PMU.
> >> > >
> >> > > Don't use indexes. You probably need phandles to the nodes these are
> >> > > related to.
> >> > >
> >> > > How many variations of child nodes do you expect to have? 2, 10, 50? You
> >> > > might want to just collapse all this down to a single node and put this
> >> > > information in the driver if it is fixed for each SoC and there's only a
> >> > > handful.
> >> > >
> >> >
> >> > For each kind of PMU, for example memory controller PMU, I expect to
> >> > have the number of instances up to 8.
> >> > They are actually all independent PMU nodes and have their own CSR memory bases.
> >> > The indexes are used for exposing the devices to perf user only. It
> >> > doesn't have an impact on the programming model.
> >> > Mark also had the same concern.
> >>
> >> Regardless, I'll need an ack from Rob or Mark before I can merge this.
> >
> > I still have a concern with this. Needing an index to expose to the user
> > is generally not a valid reason. That's OS specific and therefore
> > doesn't belong in DT.
> >
> > Rob
> 
> I can use device name here. However, the perf event names will be
> different between DT and ACPI which I want to avoid.
> And the names don't look good at all.
> Also, specifically for MC and MCB PMUs, the indexes are compared
> against the active MC/MCB mask to find out whether they are populated
> or not.
> Without using the index property, I will also need a mapping function
> of physical device addresses and their physical ids.

What's wrong with using ${device}.{physical_address} as the PMU name?
That would be unique and consistent regardless of the firmware, no
mapping nor index property necessary.

That's sufficient for any user already familiar with the topology, a
familiarity you seem to be assuming regardless by not explicitly
describing the topology in the DT.

Thanks,
Mark.
