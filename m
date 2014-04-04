From: baohua@kernel.org (Barry Song)
Date: Fri, 4 Apr 2014 22:56:08 +0800
Subject: [PATCH 59/75] ARM: l2c: prima2: remove cache size override
In-Reply-To: <20140404141034.GC7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZ6-0007Gr-6r@rmk-PC.arm.linux.org.uk>
 <CAGsJ_4yUNET5mWEUH-KEtA1ei49Fo2aC20Wmb-jXhs0vF7HSYw@mail.gmail.com>
 <20140404141034.GC7528@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4zPrOQm0PzPSBQ55wCkNHfjP0eGb2rLew_MZwP5jSEc+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-04 22:10 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Apr 04, 2014 at 09:40:31PM +0800, Barry Song wrote:
>> 2014-03-28 23:19 GMT+08:00 Russell King <rmk+kernel@arm.linux.org.uk>:
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> >  arch/arm/boot/dts/marco.dtsi  |  2 +-
>> >  arch/arm/boot/dts/prima2.dtsi |  2 +-
>> >  arch/arm/mach-prima2/l2x0.c   | 34 +---------------------------------
>> >  3 files changed, 3 insertions(+), 35 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
>> > index 1579c3491ccd..247879aa1224 100644
>> > --- a/arch/arm/boot/dts/marco.dtsi
>> > +++ b/arch/arm/boot/dts/marco.dtsi
>> > @@ -36,7 +36,7 @@
>> >                 ranges = <0x40000000 0x40000000 0xa0000000>;
>> >
>> >                 l2-cache-controller at c0030000 {
>> > -                       compatible = "sirf,marco-pl310-cache", "arm,pl310-cache";
>> > +                       compatible = "arm,pl310-cache";
>> >                         reg = <0xc0030000 0x1000>;
>> >                         interrupts = <0 59 0>;
>> >                         arm,tag-latency = <1 1 1>;
>> > diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
>> > index 0e219932d7cc..29b578727b0a 100644
>> > --- a/arch/arm/boot/dts/prima2.dtsi
>> > +++ b/arch/arm/boot/dts/prima2.dtsi
>> > @@ -48,7 +48,7 @@
>> >                 ranges = <0x40000000 0x40000000 0x80000000>;
>> >
>> >                 l2-cache-controller at 80040000 {
>> > -                       compatible = "arm,pl310-cache", "sirf,prima2-pl310-cache";
>> > +                       compatible = "arm,pl310-cache";
>> >                         reg = <0x80040000 0x1000>;
>> >                         interrupts = <59>;
>> >                         arm,tag-latency = <1 1 1>;
>> > diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
>> > index 3a4eda45171e..09f68f046830 100644
>> > --- a/arch/arm/mach-prima2/l2x0.c
>> > +++ b/arch/arm/mach-prima2/l2x0.c
>> > @@ -8,42 +8,10 @@
>> >
>> >  #include <linux/init.h>
>> >  #include <linux/kernel.h>
>> > -#include <linux/of.h>
>> >  #include <asm/hardware/cache-l2x0.h>
>> >
>> > -struct l2x0_aux
>> > -{
>> > -       u32 val;
>> > -       u32 mask;
>> > -};
>> > -
>> > -static struct l2x0_aux prima2_l2x0_aux __initconst = {
>> > -       .val = L2C_AUX_CTRL_WAY_SIZE(2),
>> > -       .mask = 0,
>> > -};
>> > -
>> > -static struct l2x0_aux marco_l2x0_aux __initconst = {
>> > -       .val = L2C_AUX_CTRL_WAY_SIZE(2) | L310_AUX_CTRL_ASSOCIATIVITY_16,
>> > -       .mask = L2X0_AUX_CTRL_MASK,
>> > -};
>> > -
>> > -static struct of_device_id sirf_l2x0_ids[] __initconst = {
>> > -       { .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
>> > -       { .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
>> > -       {},
>> > -};
>> > -
>> >  static int __init sirfsoc_l2x0_init(void)
>> >  {
>> > -       struct device_node *np;
>> > -       const struct l2x0_aux *aux;
>> > -
>> > -       np = of_find_matching_node(NULL, sirf_l2x0_ids);
>> > -       if (np) {
>> > -               aux = of_match_node(sirf_l2x0_ids, np)->data;
>> > -               return l2x0_of_init(aux->val, aux->mask);
>> > -       }
>> > -
>> > -       return 0;
>> > +       return l2x0_of_init(0, ~0);
>>
>> Russell, as i mailed you before, pre-set L2 has disabled
>> write_combined, here we can make the bit restored.
>
> *Sigh*.  This is what your final email said on the subject:
>
>   [Barry Song]
>   Anyway, it seems I can drop the whole mach-prima2/l2x0.c if I use 0 as the
>   aux_val. For aux_mask, let me zero those bits I really want to zero.

yes. it is my final mail on the subject.

>
> which to me means "I need to figure out what we need to do here, and I'll
> eventually send you a patch".

it was because i missed your this mail and patch in mail list when i
got that mail. so i said i would send a patch to follow your
requirement.
but since you already had one here, i will not.

>
> It's really quite simple.  I've done nothing (as you can see if you compare
> this to what I sent you originally) because you've done nothing to help me.
> If you want me to do something different here, send me what you need.
> Otherwise, I'm not going to change it, because I don't know what you want
> here.
>

i was not asking why you have not done anything. i was just remarking
when i found this mail today.
about what i want here,  my 1st goal is making aux_mask 0xfdffffff.
my 2nd goal is making mach-prima2/l2x0.c disappear and moving
l2x0_of_init to mach-prima2/common.c.

-barry
