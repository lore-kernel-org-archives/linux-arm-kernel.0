From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 9 Oct 2014 12:31:43 +0200
Subject: [PATCH 01/44] kernel: Add support for poweroff handler call chain
In-Reply-To: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-2-git-send-email-linux@roeck-us.net>
Message-ID: <20141009103143.GA6787@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +/**
> + *	register_poweroff_handler_simple - Register function to be called to power off
> + *					   the system
> + *	@handler:	Function to be called to power off the system
> + *	@priority:	Handler priority. For priority guidelines see
> + *			register_poweroff_handler.
> + *
> + *	This is a simplified version of register_poweroff_handler. It does not
> + *	take a notifier as argument, but a function pointer. The function
> + *	registers a poweroff handler with specified priority. Poweroff
> + *	handlers registered with this function can not be unregistered,
> + *	and only a single poweroff handler can be installed using it.
> + *
> + *	This function must not be called from modules and is therefore
> + *	not exported.
> + *
> + *	Returns -EBUSY if a poweroff handler has already been registered
> + *	using register_poweroff_handler_simple. Otherwise returns zero,
> + *	since atomic_notifier_chain_register() currently always returns zero.
> + */
> +int register_poweroff_handler_simple(void (*handler)(void), int priority)
> +{
> +	char symname[KSYM_NAME_LEN];
> +
> +	if (poweroff_handler_data.handler) {
> +		lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
> +				   symname);
> +		pr_warn("Poweroff function already registered (%s)", symname);
> +		lookup_symbol_name((unsigned long)handler, symname);
> +		pr_cont(", cannot register %s\n", symname);
> +		return -EBUSY;
> +	}

Dunno, are you maybe overdoing the debugging infrastructure a bit?
This is not going to happen in production, and if it does happen,
developer can look the symbol name himself.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
