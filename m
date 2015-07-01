From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 1 Jul 2015 18:04:29 +0200
Subject: [PATCH v2 4/4] ARM: mvebu: Warn about the wake-up sources not
 taken into account in suspend
In-Reply-To: <1435684740-24912-5-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
 <1435684740-24912-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150701180429.3c3ef6de@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Jun 2015 19:19:00 +0200, Gregory CLEMENT wrote:
> On the Armada 370/XP/38x/39x SoCs when the suspend to ram feature is
> supported, the SoC is shutdown and will be waken up by an external

waken -> woken

> micro-controller, so there is no possibility to setup wake-up source

source -> sources

> from Linux. However, in standby mode, the SoCs stay powered and it is

stay powered -> stays powered on

> possible to wake-up from any interrupt sources. As, when user decide to
> setup a wake-up source, there is no way to know if they will be
> wake-up source from suspend or from standby, then we chose allowing to
> setup all the interrupt as wake-up sources.

Hum. "Since when the users configures the enabled wake-up sources there
is no way to know if the user will be doing suspend to RAM or standby,
we just allow all wake-up sources to be enabled, and only warn when
entering suspend to RAM".

> diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
> index 264073a777d8..4402dcfa7c56 100644
> --- a/arch/arm/mach-mvebu/pm.c
> +++ b/arch/arm/mach-mvebu/pm.c
> @@ -235,6 +235,7 @@ static int mvebu_pm_enter(suspend_state_t state)
>  		cpu_do_idle();
>  		break;
>  	case PM_SUSPEND_MEM:
> +		pr_warn("None of the wakeup sources will be taken into account in suspend to ram\n");

We already had some discussion about this, and I believe this continue
to be confusing: there are some wake-up sources taken into account when
in suspend to RAM: the special button used by the micro-controller. It
is indeed not a wake-up source in the Linux sense, but it is still a
wake-up source. With such a message, the user may believe that there is
simply no way of resuming the platform.

Maybe just:

	pr_warn("Entering suspend to RAM. Only special wake-up sources will resume the system\n");

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
