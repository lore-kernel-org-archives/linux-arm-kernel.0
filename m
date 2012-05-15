From: mgreer@animalcreek.com (Mark A. Greer)
Date: Tue, 15 May 2012 11:54:43 -0700
Subject: [PATCH] arm: omap3: am35x: Set proper powerdomain states
In-Reply-To: <20120515183527.GB26651@animalcreek.com>
References: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
 <CAORVsuXouGSdZRKW+T8yvc+23KYr-x0u9FeRXxiET+QmanE_EA@mail.gmail.com>
 <20120515183527.GB26651@animalcreek.com>
Message-ID: <20120515185443.GC26651@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 11:35:27AM -0700, Mark A. Greer wrote:
> On Tue, May 15, 2012 at 09:43:52AM +0200, Jean Pihet wrote:
> > Hi Mark,
> 
> Hi Jean.
> 
> > On Mon, Apr 30, 2012 at 11:26 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > >
> > > The am35x family of SoCs only support the PWRSTS_ON
> > > state so create a new set of powerdomain structures
> > > that ensure that only the ON state is entered.
> > >
> > > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > > ---
> 
> > > ?void __init omap3xxx_powerdomains_init(void)
> > > ?{
> > > ? ? ? ?unsigned int rev;
> > > @@ -301,21 +403,31 @@ void __init omap3xxx_powerdomains_init(void)
> > > ? ? ? ? ? ? ? ?return;
> > >
> > > ? ? ? ?pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
> > > - ? ? ? pwrdm_register_pwrdms(powerdomains_omap3430_common);
> > >
> > > ? ? ? ?rev = omap_rev();
> > >
> > > - ? ? ? if (rev == OMAP3430_REV_ES1_0)
> > > - ? ? ? ? ? ? ? pwrdm_register_pwrdms(powerdomains_omap3430es1);
> > > - ? ? ? else if (rev == OMAP3430_REV_ES2_0 || rev == OMAP3430_REV_ES2_1 ||
> > > - ? ? ? ? ? ? ? ?rev == OMAP3430_REV_ES3_0 || rev == OMAP3630_REV_ES1_0)
> > > - ? ? ? ? ? ? ? pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
> > > - ? ? ? else if (rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2 ||
> > > - ? ? ? ? ? ? ? ?rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1 ||
> > > - ? ? ? ? ? ? ? ?rev == OMAP3630_REV_ES1_1 || rev == OMAP3630_REV_ES1_2)
> > > - ? ? ? ? ? ? ? pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
> > > - ? ? ? else
> > > - ? ? ? ? ? ? ? WARN(1, "OMAP3 powerdomain init: unknown chip type\n");
> > > + ? ? ? if (rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1) {
> > > + ? ? ? ? ? ? ? pwrdm_register_pwrdms(powerdomains_am35x);
> > > + ? ? ? } else {
> > > + ? ? ? ? ? ? ? pwrdm_register_pwrdms(powerdomains_omap3430_common);
> > Is there a way to avoid the big 'if else' here and have the code
> > organized per chipset revision? A mutliple if-else or -even better
> > IMO- a switch-case would make the code more readable.
> 
> We can't avoid it completely because we have to register
> powerdomains_am35x[] [exclusive] OR (powerdomains_omap3430_common[] +
> extras).  What I can do is leave the outside 'if' and turn the code
> inside the 'else' into a switch stmt which should look nicer.

Actually, I had a bug in this version where some domains weren't being
added as they should be for the am35x.  I'll fix that in v2.

Mark
