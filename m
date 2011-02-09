From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Feb 2011 17:17:12 -0000
Subject: [RFC PATCH] ARM: pmu: add OF match support
In-Reply-To: <AANLkTi=7azYw8+sYrbDsLOfF1aZynBDo+ub37O9j+k49@mail.gmail.com>
References: <1297223617-19173-1-git-send-email-robherring2@gmail.com>
	<AANLkTi=7azYw8+sYrbDsLOfF1aZynBDo+ub37O9j+k49@mail.gmail.com>
Message-ID: <001f01cbc87d$314b3270$93e19750$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Rob,

> On Tue, Feb 8, 2011 at 8:53 PM, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > Add OF match table to enable OF style driver binding. The dts entry is like
> > this:
> >
> > pmu {
> >        compatible = "arm,pmu";
> >        interrupts = <100 101>;
> > };
> >
> > The use of pdev->id as an index breaks with OF device binding. Change to use
> > a counter instead. If more than 1 pmu device is ever really supported, a
> > better solution to match users with particular pmu is probably needed.
> >
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > ---
> >  arch/arm/kernel/pmu.c |   13 ++++++++++---
> >  1 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> > index b8af96e..7084057 100644
> > --- a/arch/arm/kernel/pmu.c
> > +++ b/arch/arm/kernel/pmu.c
> > @@ -24,30 +24,37 @@
> >  static volatile long pmu_lock;
> >
> >  static struct platform_device *pmu_devices[ARM_NUM_PMU_DEVICES];
> > +static int pmu_device_count;
> >
> >  static int __devinit pmu_device_probe(struct platform_device *pdev)
> >  {
> >
> > -       if (pdev->id < 0 || pdev->id >= ARM_NUM_PMU_DEVICES) {
> > +       if (pmu_device_count >= ARM_NUM_PMU_DEVICES) {
> >                pr_warning("received registration request for unknown "
> >                                "device %d\n", pdev->id);
> >                return -EINVAL;
> >        }
> >
> > -       if (pmu_devices[pdev->id])
> > +       if (pmu_devices[pmu_device_count])
> >                pr_warning("registering new PMU device type %d overwrites "
> >                                "previous registration!\n", pdev->id);
> >        else
> >                pr_info("registered new PMU device of type %d\n",
> >                                pdev->id);
> >
> > -       pmu_devices[pdev->id] = pdev;
> > +       pmu_devices[pmu_device_count++] = pdev;
> >        return 0;
> >  }
> >
> > +static struct of_device_id pmu_device_ids[] = {
> > +       { .compatible = "arm,pmu" },
> 
> This is a pretty generic compatible string and it doesn't account for
> the possibility that the implementation behaviour will change with
> newer devices.  Is there any form of versioning on the pmu that would
> be appropriate to encode here?

Following on from Rob's update, it would be nice if you could specify that
the PMU is a CPU PMU (as opposed to L2-cache, bus, gpu etc) in the string.
That way adding different PMUs in the future seems more natural and it accounts
for your concerns above. Is that ok, or does the compatible string have to
match that used by the platform bus?

As for versioning, the PMU detection is done dynamically at runtime,
so knowing that we're poking a CPU is enough.

Cheers,

Will
