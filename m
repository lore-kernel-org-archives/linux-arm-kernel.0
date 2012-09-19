From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Sep 2012 13:25:49 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <5059A660.9080302@free-electrons.com>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209191250.54418.marex@denx.de> <5059A660.9080302@free-electrons.com>
Message-ID: <201209191325.50048.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

> Hi Marek,
> 
> Le 19/09/2012 12:50, Marek Vasut a ?crit :
> >> Le 19/09/2012 05:15, Shawn Guo a ?crit :
> >>> On Wed, Sep 19, 2012 at 12:37:17AM +0200, Marek Vasut wrote:
> >>>> Don't load the FEC MAC address from OCOTP, but use the one supplied
> >>>> via device tree by U-Boot. This is the preferred way, every DT-capable
> >>>> bootloader does set up "mac-address" and "local-mac-address"
> >>>> properties into the DT passed to the kernel.
> >>> 
> >>> Ok, since you are the maintainer of m28evk board, it could be your call
> >>> to do so.  While for imx28-evk, the kernel at least runs with bootlets
> >>> which is not DT capable.
> >>> 
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> >>>> Cc: Shawn Guo <shawn.guo@linaro.org>
> >>>> ---
> >>>> 
> >>>>  arch/arm/mach-mxs/mach-mxs.c |    2 --
> >>>>  1 file changed, 2 deletions(-)
> >>>> 
> >>>> diff --git a/arch/arm/mach-mxs/mach-mxs.c
> >>>> b/arch/arm/mach-mxs/mach-mxs.c index 170a930..71d47f5 100644
> >>>> --- a/arch/arm/mach-mxs/mach-mxs.c
> >>>> +++ b/arch/arm/mach-mxs/mach-mxs.c
> >>>> @@ -255,8 +255,6 @@ static void __init imx28_evk_post_init(void)
> >>>> 
> >>>>  static void __init m28evk_init(void)
> >>>>  {
> >>>> 
> >>>> -	update_fec_mac_prop(OUI_DENX);
> >>>> -
> >>> 
> >>> Since it's the only user of OUI_DENX, can we remove enum mac_oui
> >>> completely and make update_fec_mac_prop a fsl specific call?
> >> 
> >> I have a patch on the way that adds the Crystalfontz OUI for the
> >> CFA-10049, so it will be quite useful to me in the future.
> > 
> > Do you use U-Boot on that board?
> 
> No, we use barebox for it. And since the CFA-10049 is an expansion board
> to the CFA-10036, we only have support for the CFA-10036 in barebox, and
> support the devices present in the CFA-10049 through loading a different
> device tree.
> 
> So basically, I'd like to avoid to get the mac from the ocotp in
> barebox, since I won't need it if the CFA-10049 isn't plugged in.
> 
> Moreover, I've found no clue that barebox adds the local-mac-address or
> the mac-address fields to the device tree, so this assumption seems
> quite u-boot specific.

I dunno what barebox is, but it seems really crap. Don't use crap. The "mac-
address" and "local-mac-address" nodes must be set up by the bootloader, if 
barebox or whatever doesn't set it, it's broken.

U-Boot did that since PPC days (so basically all PPCs do that). And the FDT got 
onto ARM from PPCs. And FEC was used on PPCs too, thus I see no point to diverge 
on ARM from this method that was coined by years of development. It's no recent 
whim nor in any way non-standard.

> tl;dr: I found the current way of handling the mac address very
> convenient, and I wouldn't like to see it removed.

I'd say, move that to bootloader and don't polute Linux with it. That's where it 
belongs.

> Maxime

Best regards,
Marek Vasut
