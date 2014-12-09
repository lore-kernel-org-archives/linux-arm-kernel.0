From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Dec 2014 11:53:05 +0100
Subject: [PATCH 1/4] clk: sunxi: Rework MMC phase clocks
In-Reply-To: <CAGb2v65Q17qacuV0bxWyCyweAPiUCwapqmiYCtYME6ONNN-Jug@mail.gmail.com>
References: <1417972868-12055-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417972868-12055-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65Q17qacuV0bxWyCyweAPiUCwapqmiYCtYME6ONNN-Jug@mail.gmail.com>
Message-ID: <20141209105305.GU8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 09, 2014 at 12:53:35AM +0800, Chen-Yu Tsai wrote:
> On Mon, Dec 8, 2014 at 1:21 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Instead of having three different clocks for the main MMC clock and the two
> > phase sub-clocks, which involved having three different drivers sharing the
> > same register, rework it to have the same single driver registering three
> > different clocks.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi/clk-mod0.c | 129 ++++++++++++++++++++++---------------------
> >  1 file changed, 67 insertions(+), 62 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
> > index 658d74f39451..24522c5b94ae 100644
> > --- a/drivers/clk/sunxi/clk-mod0.c
> > +++ b/drivers/clk/sunxi/clk-mod0.c
> > @@ -115,19 +115,17 @@ static void __init sun5i_a13_mbus_setup(struct device_node *node)
> >  }
> >  CLK_OF_DECLARE(sun5i_a13_mbus, "allwinner,sun5i-a13-mbus-clk", sun5i_a13_mbus_setup);
> >
> > -struct mmc_phase_data {
> > -       u8      offset;
> > -};
> > -
> >  struct mmc_phase {
> >         struct clk_hw           hw;
> > +       u8                      offset;
> >         void __iomem            *reg;
> > -       struct mmc_phase_data   *data;
> >         spinlock_t              *lock;
> >  };
> >
> >  #define to_mmc_phase(_hw) container_of(_hw, struct mmc_phase, hw)
> >
> > +static DEFINE_SPINLOCK(sun4i_a10_mmc_lock);
> > +
> 
> I'd move this to just above the setup function.
> The get/set_phase callbacks don't need it.

Indeed.

> > +               if (of_property_read_string_index(node, "clock-output-names",
> > +                                                 i, &init.name))
> > +                       init.name = node->name;
> 
> You could assign first, then call of_property_read_string_index.
> It won't touch the string unless a valid string is found.

Well then, in the most likely case (where you have the property), you
would have two consecutive assignments, instead of a single one like
what's done here.

It seems more natural to do it that way.

> 
> > +
> > +               clk_data->clks[i] = clk_register(NULL, &phase->hw);
> > +               if (IS_ERR(clk_data->clks[i]))
> > +                       continue;
> 
> I'm a bit skeptical about partial success/failure, though I don't
> have a strong argument for or against it yet.

Yeah, I was also a bit skeptical about that part to be honest :)

I'll rework it to cleanup the clocks if it fails.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141209/96392eac/attachment.sig>
