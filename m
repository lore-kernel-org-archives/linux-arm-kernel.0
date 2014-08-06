From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Aug 2014 14:03:39 +0100
Subject: [PATCH V2 2/4] ARM: perf: Associate PMU data with driver.
In-Reply-To: <20140806105029.GE25953@arm.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144835.25462.71004.stgit@localhost> <20140806105029.GE25953@arm.com>
Message-ID: <20140806130339.GP30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 11:50:29AM +0100, Will Deacon wrote:
> On Tue, Aug 05, 2014 at 03:48:35PM +0100, Martin Fuzzey wrote:
> > In order to use the PM hooks for platform specific control we sometimes
> > need access to the PMU driver data.
> > 
> > Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> > ---
> >  arch/arm/kernel/perf_event_cpu.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> > index c09e18e..951a542 100644
> > --- a/arch/arm/kernel/perf_event_cpu.c
> > +++ b/arch/arm/kernel/perf_event_cpu.c
> > @@ -311,6 +311,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
> >  
> >  	cpu_pmu = pmu;
> >  	cpu_pmu->plat_device = pdev;
> > +	dev_set_drvdata(&pdev->dev, pmu);
> 
> I'd rather the platform-specific code used its own structures to keep track
> of what it's doing. Exposing the PMU like this is almost certainly going to
> cause us problems later on.

+1 - it's fine for the driver itself to access its private data in the
device struct, but this is not supposed to be a mechanism for passing
stuff between drivers, or indeed code outside of the driver.

A better solution would be a proper API to obtain a reference to this
data - and that must have some side effects to protect against the driver
being unbound at /any/ moment, and therefore must also have an interface
to tell the driver when it can proceed with being unbound.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
