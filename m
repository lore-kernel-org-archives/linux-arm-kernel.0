From: achin.gupta@arm.com (Achin Gupta)
Date: Wed, 30 Jan 2013 12:22:29 +0000
Subject: [PATCH v3 15/15] ARM: vexpress/dcscb: probe via device tree
In-Reply-To: <alpine.LFD.2.02.1301291634140.6300@xanadu.home>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-16-git-send-email-nicolas.pitre@linaro.org>
 <510838AD.6040700@gmail.com>
 <alpine.LFD.2.02.1301291634140.6300@xanadu.home>
Message-ID: <CAMpgmWA0CCSRYxSvA1rNDYLo_RD-UavmX7coBXVpC+HEwQaBFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 9:41 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 29 Jan 2013, Rob Herring wrote:
>
>> On 01/29/2013 01:51 AM, Nicolas Pitre wrote:
>> > This allows for the DCSCB support to be compiled in and selected
>> > at run time.
>>
>> Shouldn't this just be rolled into the commit creating dcscb.c?
>
> Probably, yes.
>
>> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> > ---
>> >  arch/arm/mach-vexpress/dcscb.c | 9 ++++++---
>> >  1 file changed, 6 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
>> > index 58051ffafb..a724507cbc 100644
>> > --- a/arch/arm/mach-vexpress/dcscb.c
>> > +++ b/arch/arm/mach-vexpress/dcscb.c
>> > @@ -14,6 +14,7 @@
>> >  #include <linux/io.h>
>> >  #include <linux/spinlock.h>
>> >  #include <linux/errno.h>
>> > +#include <linux/of_address.h>
>> >  #include <linux/vexpress.h>
>> >  #include <linux/arm-cci.h>
>> >
>> > @@ -24,8 +25,6 @@
>> >  #include <asm/cp15.h>
>> >
>> >
>> > -#define DCSCB_PHYS_BASE    0x60000000
>> > -
>> >  #define RST_HOLD0  0x0
>> >  #define RST_HOLD1  0x4
>> >  #define SYS_SWRESET        0x8
>> > @@ -215,10 +214,14 @@ extern void dcscb_power_up_setup(unsigned int affinity_level);
>> >
>> >  static int __init dcscb_init(void)
>> >  {
>> > +   struct device_node *node;
>> >     unsigned int cfg;
>> >     int ret;
>> >
>> > -   dcscb_base = ioremap(DCSCB_PHYS_BASE, 0x1000);
>> > +   node = of_find_compatible_node(NULL, NULL, "arm,dcscb");
>>
>> This needs binding documentation and should be a more specific name. Not
>> knowing what dcscb is, I don't have a suggestion.
>
> Yes, I mentioned in the cover page that DT bindings are not yet
> documented.
>
> DCSCB stands for "Dual Cluster System Control Block".  This is in fact a
> set of miscellaneous registers, mainly for reset control of individual
> CPUs and clusters.
>
>> Perhaps should include vexpress or specific core tile name it is part
>> of.
>
> /me hopes for some ARM dude more acquainted with their nomenclature to
> chime in with suggestions.
>

As nico said, the DCSCB is just a reset controller thats a part of the
FastModels implementation.  The implementation should be referred to as
VE bL RTSM. The official name goes by:

RTSM_VE_Cortex-A15x4-A7x4
RTSM_VE_Cortex-A15x1-A7x1

The file should be renamed as bL_rtsm.c or something similar.

Thanks,
Achin
