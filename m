From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 8 Feb 2011 15:28:26 +0800
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <4D50B8C0.7050701@bluewatersys.com>
References: <1297058877.800158.458894385837.1.gpush@pororo>
	<201102081054.58005.jeremy.kerr@canonical.com>
	<4D50B8C0.7050701@bluewatersys.com>
Message-ID: <201102081528.27108.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

> If a platform does not provide ops->get_rate and a driver writer does
> not know this, they could naively use the 0 return from clk_get_rate in
> calculations, which is especially bad if they ever divide by the rate.

This would be fairly evident on first boot though :)

> At the very least the documentation for clk_get_rate should state that
> the return value needs to be checked and that 0 means the rate is unknown.

Yes, sounds good. I was hesitant to change the documentation for parts of the 
API that are unchanged, but since we're formalising this 'return 0' behaviour, 
it seems reasonable to update the comment in this case.

> We do currently have the slightly indirect route to getting a clock of
> doing: clk_get -> __clk_get -> clk->ops->get. I'm guessing that the long
> term goal is to remove the middle step once everything is using the
> common clock api?

That may never happen; I imagine that some platforms won't be converted at 
all.

 __clk_get has previously been used as a platform-specific hook to do 
refcounting, which is exactly what we're doing here (via ops->get), so thought 
it was best to use the existing __clk_get name to do this.

> Also, how come you decided to keep the clk_get -> __clk_get call in
> clkdev.c, but ifdef'ed clk_put? If you just leave clk_put as is in
> clkdev.c and change clk_put to __clk_put in the generic clock code then
> you need zero changes to clkdev.c

Yep, makes sense, I'll look at doing this.

> Okay. Should we document for the implementer that clk_enable/disable
> must not sleep then? I don't think atomically is necessarily the right
> word to use here. For example Documentation/serial/driver uses "This
> call must not sleep".

OK, I'll clarify the comment.

Cheers,


Jeremy
