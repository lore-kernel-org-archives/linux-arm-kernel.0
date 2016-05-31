From: fan.chen@mediatek.com (Fan Chen)
Date: Tue, 31 May 2016 16:20:35 +0800
Subject: [PATCH v2 1/3] regulator: DT: Add DT property for operation
 mode configuration
In-Reply-To: <20160523112856.GR8206@sirena.org.uk>
References: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
 <1463987611-32139-2-git-send-email-henryc.chen@mediatek.com>
 <20160523104703.GB26992@leverpostej> <20160523112856.GR8206@sirena.org.uk>
Message-ID: <1464682835.25847.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, 2016-05-23 at 12:28 +0100, Mark Brown wrote:
> On Mon, May 23, 2016 at 11:47:04AM +0100, Mark Rutland wrote:
> 
> > > +/* Regulator operating modes */
> > > +#define REGULATOR_OPERATION_MODE_FAST			0x0
> > > +#define REGULATOR_OPERATION_MODE_NORMAL			0x1
> > > +#define REGULATOR_OPERATION_MODE_IDLE			0x2
> > > +#define REGULATOR_OPERATION_MODE_STANDBY		0x3
> 
> > These sound like they're tied to linux internal details (e.g. the
> > implementation of idle and/or suspend).
> 
> > What do each of these actually mean?
> 
> They are not really at all general and I'm fairly sure I've provided the
> same feedback repeatedly on earlier versions of the patch set.  They are
> not entirely based on Linux internal details (or at least the Linux
> internal details tend to flow from the hardware) - broadly fast is
> forced PWM, normal is default, idle is LDO mode and standby is a lower
> quality LDO mode - but how this translates into anything that a consumer
> could actually use is unclear since the supported output loads and
> quality of regulation can vary wildy.  It's also somewhat implementation
> dependent what a given regulator does (and it's always possible that
> some regulators may have more modes to control or differing definitions
> in the hardware).
> 
> Henry, *please* look at how the existing mode support in the bindings is
> done and consider how a consumer would use this given that it doesn't
> know anything about the regulator...

Hi Mark,

Thanks for your review and patiently explain your thought to us.

In the case of svs[1], which Henry mentioned in cover letter, it can be
regarded as a special consumer who requires very accurate voltage for
calibration the hardware in its initialization stage. So, this kinds of
consumers know their regulator very well and only need to switch to the
modes they want in the particular conditions.
However, IIUC, you want a proposal to provide a sort of QoS framework
which can cover most of use cases who care about the regular quality in
runtime, is that correct?

IMHO, some quality index can be considered, for example:
Minimum Current Requirement (mA): If a user specified this constraint in
runtime, it means that he cares more about the supplying quality like
transient voltage drop, ripple above certain load.
Maximum Current Requirement (mA): If a user specified this constraint in
runtime, it means that he cares more about the power consumption under
certain load.
It could be a flexible way instead to tie the operation modes directly.

BTW, we should encourage people here to share more use cases related to
regulator quality issues, especially in runtime, so we can evaluate the
most suitable index to fit the requirements.

What do you think?


[1] http://www.spinics.net/lists/devicetree/msg111208.html


Best regards,
Fan

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
