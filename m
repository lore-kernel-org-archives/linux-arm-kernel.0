From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 14 Mar 2015 11:43:15 +0000
Subject: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <CACxGe6uN_1_y+tSwkUdYZdbsURibR+es-oGab0JefsnFehJw_g@mail.gmail.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com>
 <20150311231141.GG21998@io.lakedaemon.net>
 <5500EFFF.2070807@huawei.com>
 <20150312051245.GI21998@io.lakedaemon.net>
 <550140ED.3080808@huawei.com>
 <20150313171526.GL21998@io.lakedaemon.net>
 <CACxGe6uN_1_y+tSwkUdYZdbsURibR+es-oGab0JefsnFehJw_g@mail.gmail.com>
Message-ID: <20150314114315.GC9696@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 08:47:49AM +0000, Grant Likely wrote:
> On Fri, Mar 13, 2015 at 5:15 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Hanjun, Catalin,
> >
> > On Thu, Mar 12, 2015 at 03:31:57PM +0800, Hanjun Guo wrote:
> >> On 2015/3/12 13:12, Jason Cooper wrote:
> >> > On Thu, Mar 12, 2015 at 09:46:39AM +0800, Hanjun Guo wrote:
> >> >> On 2015/3/12 7:11, Jason Cooper wrote:
> >> >>> Hey Grant,
> >> >>>
> >> >>> On Wed, Mar 11, 2015 at 06:04:50PM +0000, Grant Likely wrote:
> >> >>>> On 11 Mar 2015 12:42, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
> >> [...]
> >> >>>>> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> >> >>>>> index 0fe2f71..afd1af3 100644
> >> >>>>> --- a/drivers/irqchip/irqchip.c
> >> >>>>> +++ b/drivers/irqchip/irqchip.c
> >> >>>>> @@ -8,6 +8,7 @@
> >> >>>>>   * warranty of any kind, whether express or implied.
> >> >>>>>   */
> >> >>>>>
> >> >>>>> +#include <linux/acpi_irq.h>
> >> >>>>>  #include <linux/init.h>
> >> >>>>>  #include <linux/of_irq.h>
> >> >>>>>  #include <linux/irqchip.h>
> >> >>>>> @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
> >> >>>>>  void __init irqchip_init(void)
> >> >>>>>  {
> >> >>>>>         of_irq_init(__irqchip_of_table);
> >> >>>>> +
> >> >>>>> +       acpi_irq_init();
> >> >>>>>  }
> >> >>> Is this in line with Olof's idea that providing a dtb would override ACPI?
> >> >> Yes, it will. Since ACPI is default OFF (disabled), if a dtb provided, and no acpi=force
> >> >> passed in the early command line, dtb will be used as system configuration for
> >> >> boot (dtb is always the prior one for now) [1]. In acpi_gic_init() which called by
> >> >> acpi_irq_init(), it will return immediately if acpi disabled, so it will not parse
> >> >> any ACPI table for device configuration.
> >> > Ok, that matches my recollection.  Thanks for refreshing my memory.  I'll apply
> >> > this on a topic branch for irqchip/gic when I return from travel.  Most likely
> >> > Friday or over the weekend.
> >>
> >> Thank you very much! But this patch can't be applied without previous ones in this
> >> patch set, how about you ack this patch and Catalin takes it via ARM64 tree? I'm
> >> not sure for this, it depends on your decision.
> >
> > Is this a build dependency or a boot dependency?  I only received this patch in
> > the series and I apologize, I'm a bit swamped atm.  Catalin, would an immutable
> > irqchip/gic topic branch with this in it work for you?
> 
> Jason,
> 
> For a series like this I strongly recommend you provide an ack and let
> the whole series go in via a single branch. Trying to split it up only
> to reassemble it again creates more work for everyone. There is also
> very little likelyhood that this will create a complex conflict with
> your tree.

I would prefer this approach as well since we only enable ACPI on arm64
on patch 19. If we are to rework this, we probably end up with 3
branches: one for the base ACPI, another for irqchip and yet another to
enable ACPI on arm64 (that's unless we enable APCI on arm64 but without
any irqchip support which makes it pretty useless for testing).

-- 
Catalin
