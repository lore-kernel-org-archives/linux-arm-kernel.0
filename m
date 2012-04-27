From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Apr 2012 16:26:01 +0200
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <20120427140746.GD2234@S2101-09.ap.freescale.net>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-3-git-send-email-shawn.guo@linaro.org>
 <20120426152906.GP9142@game.jcrosoft.org>
 <20120427140746.GD2234@S2101-09.ap.freescale.net>
Message-ID: <20120427142601.GU9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:07 Fri 27 Apr     , Shawn Guo wrote:
> On Thu, Apr 26, 2012 at 05:29:06PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > I like it but I think it's more time to put soc init that machine init
> > 
> Yes, just like other hooks in struct machine_desc, when there is no
> machine specific but only soc specific setup need to get done, the hook
> is pretty much like a soc specific one.  But when you get some machine
> specific setup besides soc one, you will be happy to have it.  Taking
> board "Carmeva" as exmaple, it will be something like the following.
> 
> static void __init carmeva_init_late(void)
> {
> 	at91_init_late();
> 	carmeva_specific_late_init();
> }
> 
> MACHINE_START(CARMEVA, "Carmeva")
>         /* Maintainer: Conitec Datasystems */
>         .timer          = &at91rm9200_timer,
>         .map_io         = at91_map_io,
>         .init_early     = carmeva_init_early,
>         .init_irq       = at91_init_irq_default,
>         .init_machine   = carmeva_board_init,
>         .init_late      = carmeva_init_late,
> MACHINE_END
no really don't like this idea to duplicate code
I didn't like either for timer, or any other common init

we discuss with Arnd we came back with 2 ideas one is to use a machine
specific initcall or compatible specifc initcall or the second one is to
resurect Marc patch series to introduce soc_desc

and on at91 Ill not touch it as the old style board can NOT be compiled with
other soc (only one at91 soc at a time).

And I'll not fix it as we move to the DT which I fix to be able to be compiled
in the multiarch kernel.

Best Regards,
J.
