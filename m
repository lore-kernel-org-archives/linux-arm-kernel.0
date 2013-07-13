From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Jul 2013 22:02:36 +0100
Subject: DT binding review for Armada display subsystem
In-Reply-To: <51E1BBF1.1020009@gmail.com>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <20130712203952.6b7aa927@armhf>
 <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
 <20130713103516.38a55b0b@armhf> <51E13272.5040903@gmail.com>
 <20130713111239.GM24642@n2100.arm.linux.org.uk> <51E1921A.3070207@gmail.com>
 <51E1BBF1.1020009@gmail.com>
Message-ID: <20130713210236.GP24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 13, 2013 at 10:43:29PM +0200, Sylwester Nawrocki wrote:
> I wasn't aware of it, thanks. I've seen a patch from Jiada Wang, it seems
> they're working on v4 with clock object reference counting. Presumably we
> need both clk_get() to be taking reference on the module and reference
> counted clk free, e.g. in cases where clock provider is a hot-pluggable
> device. It might be too paranoid though, I haven't seen hardware
> configurations where a clock source could be unplugged safely when whole
> system is running.

I'm not going to accept refcounting being thrown into clk_get().  The
clkdev API already has refcounting, as much as it needs to.  It just
needs people to use the hooks that I provided back in 2008 when I
created the clkdev API for doing _precisely_ this job.

Have a read through these commits, which backup my statement above:

0318e693d3a56836632bf1a2cfdafb7f34bcc703 - initial commit of the clkdev API
d72fbdf01fc77628c0b837d0dd2fd564fa26ede6 - converting Integrator to clkdev API

and it will show you how to do refcounting.  The common clk API just
needs to stop defining __clk_get() and __clk_put() to be an empty
function and implement them appropriately for it's clk implementation,
like they were always meant to be.

__clk_get() and __clk_put() are the clk-implementation specific parts
of the clkdev API, because the clkdev API is utterly divorsed from the
internals of what a 'struct clk' actually is.  clkdev just treats a
'struct clk' as a completely opaque type and never bothers poking
about inside it.
