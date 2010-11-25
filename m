From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 25 Nov 2010 08:40:27 +0200
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <536589.12568.qm@web180310.mail.gq1.yahoo.com>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
	<536589.12568.qm@web180310.mail.gq1.yahoo.com>
Message-ID: <AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 5:59 AM, David Brownell <david-b@pacbell.net> wrote:
> My rule of thumb is that nothing is "generic"
> until at least three whatever-it-is instances
> plug in to it. ?Sometimes this is called
> the "Rule of Three".
>
> Other than OMAP, what's providing hardware
> spinlocks that plug into this framework?

We are not aware of any.

That's why the first iteration was just an omap-specific misc driver.

But we were asked not to pollute device drivers with omap-specific
interfaces (see the discussion on [1]). I think it's a good goal (it
will keep the IPC drivers that will come from TI platform-agnostic),
so we split the driver into a generic interface plus small
omap-specific implementation.

This way platforms [2] can easily plug into the framework anything
they need to achieve multi-core synchronization. E.g., even in case a
platform doesn't have dedicated silicon, but still need this
functionality, it can still plug in an implementation which is based
on Peterson's shared memory mutual exclusion algorithm (see
http://en.wikipedia.org/wiki/Peterson's_algorithm).

The third alternative is to have this driver completely hidden inside
the omap folders and deliver pdata func pointer to drivers that use
it. I am not fond of this, since the driver really only have a tiny
omap-specific part, and most of it should really sit in drivers/. In
addition, it will probably kill the chance of others using it too.

[1] http://lkml.org/lkml/2010/10/22/317
[2] this is mainly aimed at non-coherent heterogeneous processors that
do not support fancy synchronization primitives

>
> - Dave
>
>
