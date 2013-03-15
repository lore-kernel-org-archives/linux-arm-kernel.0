From: rmallon@gmail.com (Ryan Mallon)
Date: Sat, 16 Mar 2013 10:11:48 +1100
Subject: ep93xx irq-vic regression
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
Message-ID: <5143AAB4.6020406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/13 08:46, H Hartley Sweeten wrote:

>  Hello all,
> 
> Yesterday I tried upgrading my ep93xx system from 3.6.6 to 3.8.3.
> The kernel compiles fine but the machine would not boot. It just
> hangs when the bootloader (RedBoot) tries to exec the kernel.
> 
> I then tried 3.7.0 and it works fine.
> 
> I did a bisect and got down to this commit:
> 
> $ git bisect bad
> 07c9249f1fa90cc8189bed44c0bcece664596a72 is the first bad commit
> commit 07c9249f1fa90cc8189bed44c0bcece664596a72
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Tue Oct 16 18:50:00 2012 +0100
> 
>     ARM: 7554/1: VIC: use irq_domain_add_simple()
> 
> Any ideas on what might be the problem?


I don't know the code very well, but looking at the change we go
from being having the first vic bank being registered with
irq_domain_add_legacy to irq_domain_add_linear (since first_irq
is zero). It looks like the linear domain needs to have it's
revmap initialised with a call to either irq_domain_associate_many
or irq_create_strict_mappings, which I can't find a call to. Are
we left with the first vic bank having no revmap? That's from a
ten minute, uninformed glance at the code though, so I might be
off base :-).

~Ryan
