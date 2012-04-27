From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 22:07:49 +0800
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <20120426152906.GP9142@game.jcrosoft.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-3-git-send-email-shawn.guo@linaro.org>
 <20120426152906.GP9142@game.jcrosoft.org>
Message-ID: <20120427140746.GD2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 05:29:06PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> I like it but I think it's more time to put soc init that machine init
> 
Yes, just like other hooks in struct machine_desc, when there is no
machine specific but only soc specific setup need to get done, the hook
is pretty much like a soc specific one.  But when you get some machine
specific setup besides soc one, you will be happy to have it.  Taking
board "Carmeva" as exmaple, it will be something like the following.

static void __init carmeva_init_late(void)
{
	at91_init_late();
	carmeva_specific_late_init();
}

MACHINE_START(CARMEVA, "Carmeva")
        /* Maintainer: Conitec Datasystems */
        .timer          = &at91rm9200_timer,
        .map_io         = at91_map_io,
        .init_early     = carmeva_init_early,
        .init_irq       = at91_init_irq_default,
        .init_machine   = carmeva_board_init,
        .init_late      = carmeva_init_late,
MACHINE_END

-- 
Regards,
Shawn
