From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Dec 2013 21:23:00 +0100
Subject: [PATCH 04/10] net: stmmac: sunxi platfrom extensions for GMAC in
 Allwinner A20 SoC's
In-Reply-To: <52A72C6D.60100@st.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org>
 <52A5A52C.50605@st.com>
 <CAGb2v67WiCaMpJEzA_X6o7uOu6i3w3FCEz7=N5HY0amQb01SZA@mail.gmail.com>
 <52A72C6D.60100@st.com>
Message-ID: <20131210202300.GG3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 02:59:57PM +0000, srinivas kandagatla wrote:
> 
> On 09/12/13 17:34, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Mon, Dec 9, 2013 at 7:10 PM, srinivas kandagatla
> > <srinivas.kandagatla@st.com> wrote:
> >> Hi Chen,
> >> Good to know that Allwinner uses gmac.
> > 
> > To my knowledge, Allwinner has never confirmed this.
> > 
> >> On ST SoC, we have very similar requirements, before we merge any of
> >> these changes I think we need to come up with common way to solve both
> >> Allwinner and ST SOCs use cases.
> >>
> >> I have already posted few patches on to net-dev
> >> http://lkml.org/lkml/2013/11/12/243 to add Glue driver on top of stmmac
> >> driver.
> >>
> >>
> >> There are few reasons for the way I have done it.
> >>
> >> 1> I did not want to modify gmac driver in any sense to when a new SOC
> >> support is added.
> > 
> > My approach would add one line (compatible strings) each time.
> 
> This would be a best case, But in reality the defination of the
> configuration register can change per each soc, so the data associated
> with it will also change and hence you will have to change more than
> then just compatible strings.
> 
> 
> > 
> >> 2> As the SOC specific glue logic sits on top of standard GMAC IP, it
> >> makes sense to represent it proper harware hierarchy.
> > 
> > My feeling is that the SoC specifics are not a glue layer around dwmac,
> > rather an interconnected extension. Arguably I do not have the whole
> > picture. Allwinner has refused to provide us with any specifics beyond
> > the SoC manual and drivers. As such I can only make educated guesses on
> > how the dwmac core interacts with the other modules.
> 
> I would be good to get actual picture of this hw setup, On ST the
> additional glue logic which sits on top of the GMAC is to resposible for
> selecting the correct retime clock.
> 
> > 
> >> 3> Did not want to change any generic gmac bindings for SOC specific
> >> stuff as requirements if SOC glue would be very different in each case.
> > 
> > We could try to define a standard set of clocks and reset controllers.
> > The dwmac does not have much additional tunables in the driver.
> > Anything else should be SoC specific, put in an extension, and
> > documented as such.
> 
> I think it will be impossible to standardize SOC specifics as this
> glue/logic keeps changing across SOCs/Vendors.

In our case, it's barely just an additional clock (and a reset line in
the not-yet-submitted A31 GMAC).

So I can't really get what is !standard about that. We already have
defined bindings for such cases, that we can totally make optionnal.

We don't have anything like you seem to have in ST SoCs, where you
actually have some hardware around the GMAC IP. We don't. It's really
only about clocks and reset.

[...]

> >>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> >>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> >>> @@ -35,6 +35,9 @@ static const struct of_device_id stmmac_dt_ids[] = {
> >>>       { .compatible = "snps,dwmac-3.70a"},
> >>>       { .compatible = "snps,dwmac-3.710"},
> >>>       { .compatible = "snps,dwmac"},
> >>> +#ifdef CONFIG_DWMAC_SUNXI
> >>> +     { .compatible = "allwinner,sun7i-gmac", .data = &sun7i_gmac_data},
> >>> +#endif
> >> ...]
> >>
> >> Personally, I did not want to do this kind of stuff in stmmac, As this
> >> list would keep growing, and this file need to be edited for every new
> >> SOC or every different type of glue logic.
> >>
> >> Please let me know what your opnion on doing Allwinner glue driver in
> >> line with http://lkml.org/lkml/2013/11/12/462
> > 
> > 
> > I needed to set some fields in the platform data,
> > as was set in the driver provided by Allwinner, and
> > out of our own needs.
> 
> > 
> > 1. .tx_coe
> >    This is not exported in the DT bindings.
> >    Looking at stmmac code, not setting this seems to disable all
> >    checksum offloading.
> 
> Why cant this go via DT as well?
> I think, this will be overriden by stmmac on MACs > 3.50a.

How is that about hardware? Especially if we can derive it from the
version of the IP, and hence from the compatible, putting it into the
DT would be both redundant and useless.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/e0e1eba7/attachment-0001.sig>
