From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 09 Feb 2011 19:13:10 +0000
Subject: [RFC PATCH] ARM: pmu: add OF match support
In-Reply-To: <AANLkTikrBx1Y7MFGCJe=Gx-9fUxhwuYq-BZ4stGBGav6@mail.gmail.com>
References: <1297223617-19173-1-git-send-email-robherring2@gmail.com>
	<AANLkTi=7azYw8+sYrbDsLOfF1aZynBDo+ub37O9j+k49@mail.gmail.com>
	<3399156206431206254@unknownmsgid>
	<AANLkTin5aA0tq-PYBmRKh6tLv6bHRaK5ymjhsj9T4-Ah@mail.gmail.com>
	<-4919269306841091192@unknownmsgid>
	<AANLkTikrBx1Y7MFGCJe=Gx-9fUxhwuYq-BZ4stGBGav6@mail.gmail.com>
Message-ID: <1297278790.13362.18.camel@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-02-09 at 12:03 -0700, Grant Likely wrote:

<snip>

> >> It does make sense to encode the specific implementation into the
> >> compatible string.  A single device driver can bind against multiple
> >> compatible strings.  ie. the match table could include {.compatible =
> >> "arm,cortex-a9-pmu"},{.compatible = "arm,cortex-a9-l2cache-pmu"}...
> >
> > Ok - that's great! Specifying the CPU is probably a little verbose, but
> > something like "arm,armv7pmu" would be really helpful when it comes to
> > multiple devices.
> >
> >> > As for versioning, the PMU detection is done dynamically at runtime,
> >> > so knowing that we're poking a CPU is enough.
> >>
> >> Fair enough.  It is still good practice in the compatible list to
> >> encode the specific PMU implementation (maybe arm,cortex-a9-pmu?)
> >> instead of trying to define a 'generic' or wildcard compatible value.
> >> Newer implementations can always claim compatibility with an older
> >> implementation so that the kernel doesn't have to be modified to find
> >> the new devices.  "arm,pmu" is probably too generic.
> >
> > "arm,pmu" is definitely too generic. If it's good practice to specify
> > as much as possible, then go for it - I just feel a little uneasy having
> > to add lots of redundant kernel code but it sounds like you'll hopefully
> > prove me wrong on that :)
> 
> Shouldn't be any redundant kernel code.  It's just a list of match
> values, and the driver code already knows how to handle it.  The
> advantage of being specific is that if the driver ever does need
> information about the specific implementation (say, because the
> hardware reported value is buggy), then the data is available.
> 

Just to mention that this is ok as long as the platform device id 
is not used when we probe from DT (eg release_pmu ?).
If it is used for any reason it has to be initialized in the DT layer
since, as Grant brought up before, it cannot be changed after device
registration (ie @ dt_probe() ).

Lorenzo
