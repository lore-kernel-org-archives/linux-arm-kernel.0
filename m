From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Mar 2015 15:47:01 +0100
Subject: [PATCH v2] ring-buffer: Replace this_cpu_*() with __this_cpu_*()
In-Reply-To: <20150317104038.312e73d1@gandalf.local.home>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
 <20150317101113.32f5618a@gandalf.local.home>
 <20150317104038.312e73d1@gandalf.local.home>
Message-ID: <20150317144701.GJ10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guten Morgen Steven,

On Tue, Mar 17, 2015 at 10:40:38AM -0400, Steven Rostedt wrote:
>  static __always_inline void trace_recursive_unlock(void)
>  {
> -	unsigned int val = this_cpu_read(current_context);
> +	unsigned int val = __this_cpu_read(current_context);
> +	unsigned int val2;
>  
> -	val--;
> -	val &= this_cpu_read(current_context);
> -	this_cpu_write(current_context, val);
> +	val2 = val - 1;
> +	val &= val2;
> +	__this_cpu_write(current_context, val);
You could use:

	unsigned int val = __this_cpu_read(current_context);

	val = val & (val - 1);

	__this_cpu_write(current_context, val);

and save a few lines and still make it more readable (IMHO).

BTW, this patch makes the additional lines in the trace disappear, so if
you think that makes a Tested-by applicable, feel free to add it.

Best regards
Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
