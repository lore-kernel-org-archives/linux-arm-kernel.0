From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 17 Jan 2013 10:42:32 -0500 (EST)
Subject: [PATCH 2/3] ARM: convert platform hotplug inline assembly to C
In-Reply-To: <50F8082F.1050906@gmail.com>
References: <1358391205-23943-1-git-send-email-robherring2@gmail.com>
 <1358391205-23943-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1301162338420.6300@xanadu.home> <50F8082F.1050906@gmail.com>
Message-ID: <alpine.LFD.2.02.1301171038590.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jan 2013, Rob Herring wrote:

> On 01/16/2013 10:40 PM, Nicolas Pitre wrote:
> > On Wed, 16 Jan 2013, Rob Herring wrote:
> > 
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> With the addition of set_auxcr/get_auxcr, all the hotplug inline assembly
> >> code for exynos, imx, realview, spear13xx and vexpress can be converted to
> >> C code.
> > 
> > That might not be all safe.  Please see
> > http://article.gmane.org/gmane.linux.ports.arm.kernel/209584
> 
> Other than the OR/AND operations, it's all just inline assembly
> functions that are called, so it gets compiled to the same code. Perhaps
> I should put noinline on the functions so they stay of limited
> complexity. If you don't think doing this in C is okay, then there is
> probably no point in having the set_auxcr/get_auxcr functions.

I think set_auxcr/get_auxcr is fine.

But your patch goes beyond simply converting those.  You also converted 
the cache flush and disable from assembly to C, which on a Cortex A9 
might be unsafe if the stack is modified in the sequence according to 
the discussion I referenced.


Nicolas
