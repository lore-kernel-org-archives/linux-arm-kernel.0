From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 17 Jul 2017 22:16:32 +0200
Subject: [PATCH v2] PM / suspend: Add suspend_target_state()
In-Reply-To: <20170717200628.7018-1-f.fainelli@gmail.com>
References: <20170716023610.4658-1-f.fainelli@gmail.com>
 <20170717200628.7018-1-f.fainelli@gmail.com>
Message-ID: <20170717201631.GA13024@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Have the core suspend/resume framework store the system-wide suspend
> state (suspend_state_t) we are about to enter, and expose it to drivers
> via suspend_target_state() in order to retrieve that. The state is
> assigned in suspend_devices_and_enter().

Do we really want to have variable + inline functions that just read
that variable?

> +static inline suspend_state_t suspend_target_state(void) { return  -ENOSYS; }

I'm pretty sure -ENOSYS is not compatible with suspend_state_t ...

> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 3ecf275d7e44..a296d6e25d52 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -47,6 +47,7 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
>  
>  suspend_state_t mem_sleep_current = PM_SUSPEND_FREEZE;
>  static suspend_state_t mem_sleep_default = PM_SUSPEND_MEM;
> +static suspend_state_t pm_suspend_target_state;

Is there disadvantage of just having this variable non-static?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/40b9fdf6/attachment.sig>
