From: J.Lambrecht@TELEVIC.com (=?iso-8859-1?Q?Lambrecht_J=FCrgen?=)
Date: Mon, 11 Jul 2011 12:30:52 +0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using
	mc13783 codec
In-Reply-To: <20110709022501.GA26900@sirena.org.uk>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<20110709022501.GA26900@sirena.org.uk>
Message-ID: <4E1AD0DC.7020201@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2011 04:25 AM, Mark Brown wrote:
>
> On Fri, Jul 08, 2011 at 03:24:51PM +0200, J??rgen Lambrecht wrote:
>
> Please read and try to follow the guidelines in SubmittingPatches:
>
OK, I only had a quick scan through it, ... and instead of complaining 
of ./Documentation being always outdated, I better supply a patch for 
SubmittingPatches ;-).
>
> - Provide a sensible changelog for your patch
>
i will for the patch indeed
>
> - Send copies to the relevant maintainers
>
Only being an RFC and not a real patch, I didn't do the effort of 
checking MAINTAINERS, sorry.
So you and Liam Girdwood for sound/soc
>
> - Word wrap within 80 columns
> - Follow the kernel coding style.
>
Oops, I thought I already sent the patches through ./scripts/checkpatch.pl
(the patches come from another branch in my git on an older version of 
the kernel)
(5 errors, shame on me..)
>
>
> >
> >  if SND_IMX_SOC
> >
> > -config SND_MXC_SOC_SSI
> > -     tristate
> > -
>
> This appeears to be unrelated to adding new machine support and should
> be a separate patch.
>
indeed, is someone else's patch I applied already
(when moving my branch to the latest pengutronix/for-next branch, i 
thought that patch would already have been applied - forgot to check)
>
>
> > +config SND_SOC_IMX_MC13783
> > +     tristate
> > +
>
> Err...  what is this for?
>
Well, normally all drivers here are platform specific, but I saw my 
driver for the imx27pdk was the same as the 'Phytec phyCORE (and 
phyCARD) boards' one (and now I hear also valid for mx31moboard 
platforms). So I decided to copy "phycore-mc13783.c" to "imx-mc13783.c", 
and this 'SND_SOC_IMX_MC13783' is to compile in the Makefile.
So I added an extra layer in Kconfig, because my 'SND_SOC_IMX27_MC13783' 
selects it, and also the phycore one selects it (but omitted it from my 
patch because it is not mine, and only exists in the imx-sound branch of 
Sascha).

I think now it is better to remove those 3 lines.
See next paragraph to continue.
>
>
> >  config SND_MXC_SOC_WM1133_EV1
> >       tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
> >       depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
> >       select SND_SOC_WM8350
> > -     select SND_MXC_SOC_SSI
> >       select SND_MXC_SOC_FIQ
> >       help
>
> Again, this and all the other similar hunks are totally unrelated to
> adding a machine.
>
> > +config SND_SOC_IMX27_MC13783
> > +     tristate "SoC Audio support for i.MX27 platforms with a 
> MC13783 codec"
> > +     depends on MACH_MX27_3DS
>
> The dependency and the text disagree with each other...
>
Indeed. But i did not dare to touch the phycore code (only in imx-sound 
branch).. Maybe this is better (removing those 3 lines above):

config SND_SOC_IMX_MC13783
     tristate "SoC Audio support for i.MX27 platforms with a MC13783 codec"
     depends on MACH_MX27_3DS || MACH_PCM038 || MACH_PCM037 || 
MACH_MX31MOBOARD
     select SND_SOC_MC13783
     select SND_MXC_SOC_MX2
     help
       Say Y if you want to add support for SoC audio on i.MX27 platforms
       with a MC13783 codec (based on Freescale's imx27pdk kit)

But actually, I have my doubts. Is it possible to reuse such a platform 
driver?
I don't know the other platforms, maybe they differ a little bit?

For example our own HW (based on imx27pdk) uses an enable pin (gpio) for 
the loudspeaker amplifier. Now I put it on in the machine driver (i mean 
the one in ./arch/arm/mach-imx/). But to save power, it could be 
interesting to enable the ampli only when needed.
What to do then: copy the complete driver and add an ampli-on/off function?


Thanks for your comments,
J?rgen

[snip: for next mail]

-- 
J?rgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
