From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 28 May 2015 10:22:43 -0700
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <20150527062430.GN6325@pengutronix.de> (Sascha Hauer's message of
 "Wed, 27 May 2015 08:24:30 +0200")
References: <1431349882-12260-1-git-send-email-s.hauer@pengutronix.de>
 <1431349882-12260-3-git-send-email-s.hauer@pengutronix.de>
 <7hlhgbotlp.fsf@deeprootsystems.com>
 <20150527062430.GN6325@pengutronix.de>
Message-ID: <7hvbfciplo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Tue, May 26, 2015 at 03:35:14PM -0700, Kevin Hilman wrote:
>> Sascha Hauer <s.hauer@pengutronix.de> writes:
>> 
>> > This adds a power domain driver for the Mediatek SCPSYS unit.
>> >
>> > The System Control Processor System (SCPSYS) has several power
>> > management related tasks in the system. The tasks include thermal
>> > measurement, dynamic voltage frequency scaling (DVFS), interrupt
>> > filter and lowlevel sleep control. The System Power Manager (SPM)
>> > inside the SCPSYS is for the MTCMOS power domain control.
>> >
>> > For now this driver only adds power domain support, the more
>> > advanced features are not yet supported. The driver implements
>> > the generic PM domain device tree bindings, the first user will
>> > most likely be the Mediatek AFE audio driver.
>> >
>> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> > ---
>> >  drivers/soc/mediatek/Kconfig             |   6 +
>> >  drivers/soc/mediatek/Makefile            |   1 +
>> >  drivers/soc/mediatek/mtk-scpsys.c        | 345 +++++++++++++++++++++++++++++++
>> >  include/dt-bindings/power/mt8173-power.h |  15 ++
>> >  4 files changed, 367 insertions(+)
>> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
>> >  create mode 100644 include/dt-bindings/power/mt8173-power.h
>> >
>> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>> > index bcdb22d..1d34819 100644
>> > --- a/drivers/soc/mediatek/Kconfig
>> > +++ b/drivers/soc/mediatek/Kconfig
>> > @@ -9,3 +9,9 @@ config MTK_PMIC_WRAP
>> >  	  Say yes here to add support for MediaTek PMIC Wrapper found
>> >  	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
>> >  	  hardware to connect the PMIC.
>> > +
>> > +config MTK_SCPSYS
>> > +	tristate "MediaTek SCPSYS Support"
>> 
>> depends on ARCH_MEDIATEK ?
>
> You are reviewing v2 of this series. This is already fixed in v3 sent
> out last wednesday.

Yeah, sorry about that.  I noticed that after sending.

>> > +	for (i = 0; i < NUM_DOMAINS; i++) {
>> > +		struct scp_domain *scpd = &scp->domains[i];
>> > +		struct generic_pm_domain *pmd = &scpd->pmd;
>> > +
>> > +		scp->pmd[i] = pmd;
>> > +		scpd->data = &scp_domain_data[i];
>> > +		scpd->scp = scp;
>> > +
>> > +		pmd->name = scp_domain_data[i].name;
>> > +		pmd->power_off = scpsys_power_off;
>> > +		pmd->power_on = scpsys_power_on;
>> > +		pmd->power_off_latency_ns = 20000;
>> > +		pmd->power_on_latency_ns = 20000;
>> 
>> I think I mentioned this before... are these numbers really identical
>> for all domains?  I suggest you make these each a field in the domain
>> data so they can be different for each domain, and eventually come from
>> DT data.
>
> For the record, here are the numbers I just measured:
>
> mtk-scpsys 10006000.scpsys:       vdec on: 31000 off: 10769
> mtk-scpsys 10006000.scpsys:       venc on:  6000 off:  5923
> mtk-scpsys 10006000.scpsys:        isp on:  5923 off:  5923
> mtk-scpsys 10006000.scpsys:         mm on:  7616 off:  7692
> mtk-scpsys 10006000.scpsys:    venc_lt on:  5924 off:  6000
> mtk-scpsys 10006000.scpsys:      audio on:  5462 off:  5615
> mtk-scpsys 10006000.scpsys:        usb on:  5461 off:  5462
> mtk-scpsys 10006000.scpsys:  mfg_async on: 29923 off: 11077
> mtk-scpsys 10006000.scpsys:     mfg_2d on:  5923 off:  5616
> mtk-scpsys 10006000.scpsys:        mfg on: 11231 off: 16153
>
> Anyway, the pm domain core measures these times itself, so there
> should not be a need to fill in anything here. I was irritated by the
> warning message I got each time when the times were exceeded. This
> message seemed to imply that something was wrong and I had to fill
> in sane values in the latency fields. Since we now have [1] I'll just
> drop the initialisation of these fields.

OK.

However, I suspect you will still want these numbers on a per-domain
basis eventually when you consider having genpd governors that want
to make decisions.  But that can always be added later also.

Kevin
