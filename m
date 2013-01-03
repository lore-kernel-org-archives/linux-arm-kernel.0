From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 08:07:53 +0000
Subject: [PATCH 1/2] timer: vt8500: Move system timer to clocksource
In-Reply-To: <1357199114.25181.48.camel@joe-AO722>
References: <1357183510-8476-1-git-send-email-linux@prisktech.co.nz>
 <20130103073540.GB11309@core.coreip.homeip.net>
 <1357199114.25181.48.camel@joe-AO722>
Message-ID: <201301030807.53550.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Joe Perches wrote:
> Also I think it'd be nicer to write something like:
> 
>         struct device_node *np;
>         int timer_irq;
>         const char *reason;
> 
>         np = of_find_matching_node(NULL, vt8500_timer_ids);
>         if (!np) {
>                 reason = "timer";
>             goto error;
>         }
>         regbase = of_iomap(np, 0);
>         if (!regbase) {
>                 reason = "iobase";
>                 goto error_put;
>         }
>         timer_irq = irq_of_parse_and_map(np, 0);
>         if (!timer_irq) {
>                 reason = "irq";
>                 goto error_remap;
>         }
>  
>         ...
> 
> error_remap:
>         unmap...;
> error_put:
>         of_node_put(np);
> error:
>         pr_err("%s: Missing %s description in Device Tree\n",
>                __func__, reason);
>         return;

Right, but that would be a separate cleanup patch, since the patch that
Tony posted is just supposed to move the code around and change as little
else as possible in the process. The cleanup can come either right before
or right after the move.

	Arnd
