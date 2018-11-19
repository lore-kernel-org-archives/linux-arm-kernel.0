From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Nov 2018 11:41:23 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add I2C-DVFS device
 node
In-Reply-To: <20181119101438.flbtwyslfdgumkhf@verge.net.au>
References: <1540071349-27483-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdV=ZinKOWZco9t4rGncYY5BqghXxGE6w9qCNW55UVSa+A@mail.gmail.com>
 <20181107123002.t6xg4m4vbq7cuapb@verge.net.au>
 <20181108102201.kuheale47tqygoe4@verge.net.au>
 <CAMuHMdW=f77EafYXSzD3BiuMLirm+gjMnQZ7WzE0kX-TjXwkdg@mail.gmail.com>
 <20181108115219.47lf5iauoygomdbh@verge.net.au>
 <CAMuHMdX=Gj1a5rjfRWSDKMbDuqyeztBCGb+9yam8w8UQMLkUPg@mail.gmail.com>
 <20181108131815.5jebwxqbaldofk6d@verge.net.au>
 <20181119101438.flbtwyslfdgumkhf@verge.net.au>
Message-ID: <CAMuHMdV7uRZL72LkzgCNJVnvHZ5bcnXwJYWv2NYswKbihCKCqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Nov 19, 2018 at 11:14 AM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 08, 2018 at 02:18:16PM +0100, Simon Horman wrote:
> > On Thu, Nov 08, 2018 at 01:25:45PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Nov 8, 2018 at 12:52 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Thu, Nov 08, 2018 at 11:27:31AM +0100, Geert Uytterhoeven wrote:
> > > > > On Thu, Nov 8, 2018 at 11:22 AM Simon Horman <horms@verge.net.au> wrote:
> > > > > > On Wed, Nov 07, 2018 at 01:30:10PM +0100, Simon Horman wrote:
> > > > > > > On Mon, Nov 05, 2018 at 09:52:48AM +0100, Geert Uytterhoeven wrote:
> > > > > > > > On Sat, Oct 20, 2018 at 11:35 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > > > > > > > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > > > > > > >
> > > > > > > > > This patch adds I2C-DVFS device node for the R8A77990 SoC.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > > > > > > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > > > > > >
> > > > > > > > Thanks for your patch!
> > > > > > > >
> > > > > > > > > --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> > > > > > > > > +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> > > > >
> > > > > > > > >         };
> > > > > > > > >
> > > > > > > > >         cpus {
> > > > > > > > > @@ -337,6 +338,22 @@
> > > > > > > > >                         reg = <0 0xe6060000 0 0x508>;
> > > > > > > > >                 };
> > > > > > > > >
> > > > > > > > > +               i2c_dvfs: i2c at e60b0000 {
> > > > > > > > > +                       #address-cells = <1>;
> > > > > > > > > +                       #size-cells = <0>;
> > > > > > > > > +                       compatible = "renesas,iic-r8a77990",
> > > > > > > >
> > > > > > > > "renesas,iic-r8a77990" is not yet documented.
> > > > > > >
> > > > > > > Thanks, as per my comment below I wonder if as well as documenting
> > > > > > > "renesas,iic-r8a77990" we also to teach the driver about it.
> > > > > > >
> > > > > > > >
> > > > > > > > > +                                    "renesas,rcar-gen3-iic",
> > > > > > > > > +                                    "renesas,rmobile-iic";
> > > > > > > >
> > > > > > > > Also, IIC on R-Car E3 does not have the automatic transmission registers.
> > > > > > > > Does this affect claiming compatibility with the family-specific or generic
> > > > > > > > compatible values?
> > > > > > >
> > > > > > > My cursory reading of the driver indicates that only register that is
> > > > > > > used by it but documented as not existing on E3 is ICSTART (offset 0x70).
> > > > > > >
> > > > > > > It seems to me that we should confirm with Renesas that the register does
> > > > > > > indeed not exist - as this patch comes from the BSP which implies it is
> > > > > > > being used there. And if it does not exist we should try teaching the
> > > > > > > driver not to use ICSTART via the "renesas,iic-r8a77990" compat string.
> > > > > > > What do you think?
> > > > > >
> > > > > > Further examination by Wolfram Sang has shown that the code in question is
> > > > > > only used on the r8a7740. I don't think there is any compatibility issue
> > > > > > for r8a77990 when using the current driver.
> > > > >
> > > > > "When using the current driver".
> > > > > Do we want to claim compatibility with "renesas,rcar-gen3-iic" and/or
> > > > > "renesas,rmobile-iic"?
> > > >
> > > > Thinking a bit more since I wrote my previous email.
> > > >
> > > > It seems that the r8a77990 has a different feature set to other R-Car Gen3
> > > > SoCs but that the current driver implementation "renesas,rcar-gen3-iic"
> > > > and "renesas,rmobile-iic" do not exceed that feature set.
> > > >
> > > > In future we could expand the features supported by the driver for other
> > > > Gen3 SoCs beyond what is supported for r8a77990. If we chose to describe
> > > > r8a77990 as compatible with renesas,rcar-gen3-iic then that implies those
> > > > new features would not be activated by matching on "renesas,rcar-gen3-iic",
> > > > though we could choose to control that using soc_match. Conversely if we
> > > > decide that r8a77990 is not compatible with renesas,rcar-gen3-iic then we
> > > > have more freedom to move with regards to adding features not supported by
> > > > r8a77990 to renesas,rcar-gen3-iic in future.
> > > >
> > > > So perhaps it would be wise to be conservative and, for now,
> > > > not document r8a77990 as being compatible with renesas,iic-r8a77990.
> > > >
> > > > I'm tempted to say that renesas,rmobile-iic is a lowest common denominator
> > > > and r8a77990 can be documented as being compatible with it. But we could
> > > > say the same of renesas,rcar-gen3-iic.
> > > >
> > > > What do you think?
> > >
> > > That matches my thoughts.
> > >
> > > Given R-Mobile A1 does have the register, I think r8a77990 should not claim
> > > compatibility with it.
> >
> > Right, but the ICSTART register is only used on R-Mobile A1
> > (r8a7740) via the "renesas,iic-r8a7740" compat string. Never, in my reading
> > of the driver, via more generic compat strings.
> >
> > Also, fwiw, the function the ICSTART register is called
> > sh_mobile_i2c_r8a7740_workaround. Note the use of workaround.
> >
> > > Of course all this assumes there's no bug in the datasheet w.r.t. r8a77990...
> >
> > The safest approach would be not to declare r8a77990 as being compatible
> > with the more generic compat strings. We can reverse that decision in
> > future.  The converse is not, strictly speaking, true.
>
> Could we revive this conversation?
>
> I propose that we document the r8a77990 compat string but rely on driver
> initialisation via the more generic compat strings for now. If the driver
> is enhanced in future then the generic compat strings will need to preserve
> that compatibility. But new features for any SoC can be enabled via
> SoC-specific compat strings.

If we do that, please document this in the driver, so we don't forget about it:

+ /*
+  * The automatic transmission registers are not assumed to be present
+  * for generic compatible values like "renesas,rmobile-iic",
"renesas,rcar-gen2-iic",
+  * and "renesas,rcar-gen3-iic"
+  */
  #define ICSTART                 0x70

Is there any probability we may start using the automatic transmission registers
in the future?
If yes, with the above decision, the driver would need to start matching on all
SoC-specific compatible values for SoCs that do have it.

So declaring r8a77990 not compatible with the generic version may be easier.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
