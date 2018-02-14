From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Feb 2018 11:51:19 +0000
Subject: [PATCH 2/5] drivers/bus: Split Arm CCI driver
In-Reply-To: <f62d3a76-9ee0-43a5-c585-fcebce52e800@arm.com>
References: <cover.1517855839.git.robin.murphy@arm.com>
 <1660c838bafffb0b1a0d48823bc88c701adf01e4.1517855839.git.robin.murphy@arm.com>
 <87shadgfam.fsf@e105922-lin.cambridge.arm.com>
 <f62d3a76-9ee0-43a5-c585-fcebce52e800@arm.com>
Message-ID: <20180214115118.GD2992@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:07:53PM +0000, Robin Murphy wrote:
> Hi Punit,
> 
> On 07/02/18 12:22, Punit Agrawal wrote:
> [...]
> >>-static void __iomem *cci_ctrl_base;
> >>+void __iomem *cci_ctrl_base __ro_after_init;
> >
> >Initially I wondered if cci_ctrl_base gets used in the pmu driver before
> >it's initialised. But as it gets set in early_initcall() that looks to
> >be fine.
> 
> In fact it's even more robust than initcall ordering, since the PMU device
> will only be created at all via cci_platform_probe(), thus cci_init() is
> guaranteed to have run successfully before the PMU driver probe can ever
> touch anything.

Could you hijack the platform data at this point by passing an of_dev_auxdata
to of_platform_populate and then use that to pass the __iomem address to the
PMU driver?

Will
