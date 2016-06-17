From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2016 17:07:39 +0200
Subject: [PATCH] arm64: Kconfig: select PM for ARCH_VEXPRESS
In-Reply-To: <57641056.2000708@arm.com>
References: <1466090128-24425-1-git-send-email-sudeep.holla@arm.com>
 <3892833.90HLNUPjM3@wuerfel> <57641056.2000708@arm.com>
Message-ID: <5285733.mW80cUVgAV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 17, 2016 3:59:34 PM CEST Sudeep Holla wrote:
> 
> On 17/06/16 15:16, Arnd Bergmann wrote:
> > On Friday, June 17, 2016 2:38:32 PM CEST Sudeep Holla wrote:
> >> On 17/06/16 12:53, Arnd Bergmann wrote:
> >>>> The discussion on this happened on linux-pm list[1]. This is
> >>>> need on Juno once we introduce coresight components in the DT.
> >>>> With !CONFIG_PM, the board stalls on boot and hence this patch
> >>>> is needed. This shouldn't change any thing in the defconfig as
> >>>> couple of other platforms already do the same. It's needed in
> >>>> case all other ARCH_* configs are disabled.
> >>>>
> >>>> Without this, we need a dirty trick in the DT[2] to handle
> >>>> !CONFIG_PM.
> >>>>
> >>>> Can you please pick this for v4.8 ?
> >>>
> >>> Question: if AMBA cannot deal with CONFIG_PM disabled, should the
> >>> 'select' be done from CONFIG_ARM_AMBA instead?
> >>>
> >>
> >> But few platforms using AMBA may not want PM at all.
> >
> > Ok, then I just misunderstood what you meant with "the AMBA framework
> > can't deal with !CONFIG_PM case".
> >
> 
> To be more precise genpd/runtime code return same error -ENODEV when
> PM_GENERIC_DOMAINS=n and if the no power domain is found with
> PM_GENERIC_DOMAINS=y . The AMBA bus code just checks for -EPROBE_DEFER
> to stop adding devices, while proceeds to access the device otherwise.
> 
> However on Juno, the coresight needs to powered up before accessing it.
> Well all is fine if you specify power domains in DT and have
> PM_GENERIC_DOMAINS=y. However if PM_GENERIC_DOMAINS=n the AMBA ignores
> the error(-ENODEV) from runtime PM and access the device resulting in
> boot hang when adding amba devices.
> 
> I thought we need is to have code to check for power domains in DT for
> the device even when PM_GENERIC_DOMAINS=n and return an error that can
> be used to skip registering the device and clearly identifies with other
> allowed errors. It may need a bit of surgery and closer look IMO. But
> when asked for opinion, I was suggested to do this. I admit that I
> didn't propose my thoughts then :)

Ok, so we also need PM_GENERIC_DOMAINS, not just PM, right?

It also sounds like there is no easy way to just turn on the clocks
in the amba bus handler when PM_GENERIC_DOMAINS is turned off, other
than reimplementing PM_GENERIC_DOMAINS?

I'm just guessing here, I haven't looked into the code in enough
depth.

> >>> Then again  ARCH_RENESAS seems to already do this.
> >>
> >> Yes, it was hard to find get !CONFIG_PM as many platforms select
> >> it directly or indirectly.
> >
> > Starting from an allmodconfig build, I just needed to disable
> > ARCH_RENESAS, ARCH_OMAP2PLUS_TYPICAL, SUSPEND and HIBERNATE.
> >
> 
> I assume this is in ARM32, I am looking at ARM64, but allmodconfig might
> help.

Yes, I was looking at ARM32.

	Arnd
