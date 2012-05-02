From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 2 May 2012 04:51:44 +0200
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <201204300846.41118.arnd@arndb.de>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <20120428053001.GY9142@game.jcrosoft.org>
 <20120428065348.GC9924@S2101-09.ap.freescale.net>
 <201204300846.41118.arnd@arndb.de>
Message-ID: <20120502025144.GA19477@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:46 Mon 30 Apr     , Arnd Bergmann wrote:
> On Saturday 28 April 2012, Shawn Guo wrote:
> > On Sat, Apr 28, 2012 at 07:30:01AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 10:30 Sat 28 Apr     , Shawn Guo wrote:
> > > > On Fri, Apr 27, 2012 at 04:26:01PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > we discuss with Arnd we came back with 2 ideas one is to use a machine
> > > > > specific initcall or compatible specifc initcall
> > > > 
> > > > Do you mean an initcall with machine/compatible detection inside?  The
> > > > whole point of the hooks in struct machine_desc  is to save the
> > > > machine/compatible detection.  You already use .init_machine as
> > > > an arch_initcall time hook, and what .init_late provides you is just
> > > > a late_initcall time hook.  If you want to detect machine/compatible
> > > > in your late_initcall rather than using this hook, you should not
> > > > use .init_machine for the same reason.
> > > on DT we just do this
> > > 
> > I'm talking about non-DT case.  Sadly, there are still so many non-DT
> > board files in arch/arm/mach-at91.
> 
> It depends on whether we want to allow non-DT board files for multiplatform
> kernels. We clearly can allow them, but I think we can spare some trouble
> and also make the configuration simpler if we just disallow it, and
> make only those platforms that are converted to both allow multiplat
> and DT boot as sub-options under the top-level multiplatform kernel
> option. If we do that, we can keep a lot of initcalls in the platform
> code and just add an "if (!of_have_populated_dt())" in them or a check
> for the respective device.
I agree with Arnd

and in your patch you export sensitive SoC function that no board Maintainer
will ever have to care about

As example on at91 you ask the baord maintainer to call the clock shutdown
to disable the non used clock

if we use the soc_desc or the conditional initcall we will avoid a lot of
trouble

I'll send a patch for soc_desc and conditional initcall
will see which Russell prefer.

Best Regards,
J.
> 
> > > so the hook start to make not too much sense
> > > at machine level
> > > 
> > > as this is for nearly all of them purely soc
> > > 
> > This reminds me an argument against soc_desc stuff.  With DT adopted,
> > the struct machine_desc (hooks inside it) becomes purely soc specific,
> > so why do we need soc_desc then?
> 
> Ah, good point. I was wondering what happened to that discussion.
> 
> On a related note, I have looked up what kinds of initcalls are in
> the platform code:
> 
> $ git grep -h ^[a-z_]*_initcall arch/arm/ | cut -f 1 -d \( | sort | uniq -c | sort -n      1 subsys_initcall_sync
>       2 postcore_initcall_sync
>       5 console_initcall
>       7 fs_initcall
>       9 early_initcall
>      14 __initcall
>      34 device_initcall
>      35 postcore_initcall
>      43 core_initcall
>      49 late_initcall
>      87 subsys_initcall
>     128 arch_initcall
> 
> I think that if we do the late_initcall mechanism that you proposed,
> we will probaly need the same for subsyste_initcall, and although
> we already have mach_desc->init_machine() at the arch_initcall
> level, it seems that there are a lot of other users that don't
> use it (for good or for not so good reasons, I have not checked)
> and that would definitely benefit from the method that Jean-Christophe
> posted. I think we will end up wanting both in any case.
> 
> 	Arnd
> 
