From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 11:06:41 +0200
Subject: [PATCH RESEND 1/2] ARM: topology: Use a clock if possible to get
 the CPU frequency
In-Reply-To: <CAL_Jsq+D2dprBfg8G_zYeZ9sk0pwWhVRd-1Uo513E0Jgg2igRg@mail.gmail.com>
References: <1403034980-19112-1-git-send-email-maxime.ripard@free-electrons.com>
 <1403034980-19112-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAL_Jsq+D2dprBfg8G_zYeZ9sk0pwWhVRd-1Uo513E0Jgg2igRg@mail.gmail.com>
Message-ID: <20140618090641.GG19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jun 17, 2014 at 04:13:26PM -0500, Rob Herring wrote:
> On Tue, Jun 17, 2014 at 2:56 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The Cortex-A7 and Cortex-A15 based SoCs need a clock-frequency property in the
> > topology code.
> >
> > Allow to use a clock to provide the same information.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/kernel/topology.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> > index 9d853189028b..0bd044cbbcb2 100644
> > --- a/arch/arm/kernel/topology.c
> > +++ b/arch/arm/kernel/topology.c
> > @@ -11,6 +11,7 @@
> >   * for more details.
> >   */
> >
> > +#include <linux/clk.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/export.h>
> > @@ -100,8 +101,8 @@ static void __init parse_dt_topology(void)
> >                                  GFP_NOWAIT);
> >
> >         for_each_possible_cpu(cpu) {
> > -               const u32 *rate;
> > -               int len;
> > +               struct clk *clk;
> > +               u32 rate = 0;
> >
> >                 /* too early to use cpu->of_node */
> >                 cn = of_get_cpu_node(cpu, NULL);
> > @@ -117,14 +118,23 @@ static void __init parse_dt_topology(void)
> >                 if (cpu_eff->compatible == NULL)
> >                         continue;
> >
> > -               rate = of_get_property(cn, "clock-frequency", &len);
> > -               if (!rate || len != 4) {
> > -                       pr_err("%s missing clock-frequency property\n",
> > -                               cn->full_name);
> > +               clk = of_clk_get(cn, 0);
> > +               if (!IS_ERR(clk)) {
> > +                       rate = clk_get_rate(clk);
> > +               } else {
> > +                       if (of_property_read_u32(cn, "clock-frequency", &rate)) {
> > +                               pr_err("%s missing clocks or clock-frequency properties\n",
> > +                                      cn->full_name);
> 
> This error check and message is redundant with the next error message.
> You can remove this one and just call of_property_read_u32. rate will
> remain untouched on error.

I'm not sure what you mean here. There's no next error message in the
code as far as I'm aware.

If you mean that I'd rather have something like

clk = of_clk_get(cn, 0);
if (!IS_ERR(clk))
	rate = clk_get_rate(clk);
else
	of_property_read_u32(cn, "clock-frequency", &rate));

if (!rate)
	pr_err()

Then, yes, it makes sense. I'll resend a version

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/fdefee69/attachment.sig>
