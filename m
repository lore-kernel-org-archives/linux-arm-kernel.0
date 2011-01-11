From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 11 Jan 2011 12:15:52 +0900
Subject: Locking in the clk API
In-Reply-To: <201101111016.42819.jeremy.kerr@canonical.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>
Message-ID: <20110111031552.GJ3760@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 10:16:42AM +0800, Jeremy Kerr wrote:
> * clk_enable: may sleep
> 
> * clk_disable: may not sleep, but it's possible to make the global
>   clk_disable() atomic and defer the actual disable (clk->ops.disable()) to a
>   non-atomic context.
> 
> * clk_get_rate: may not sleep
> 
> * clk_set_rate: may sleep
> 
> As we build up our requirements, we can adjust as suitable.
> 
This looks like a complete disaster, and is also completely inconsistent
with how the API is being used by the vast majority of users today. You
have an API that can or can not sleep with no indication as to which is
which based off of the API naming, which is just asking for trouble.

As it is today, most users expect that these are all usable from atomic
context, and as far as I can tell the only special case you have are for
some crap busses with insane latencies. In this case you should simply
pile on _cansleep() versions of the API and make it apparent that those
drivers are the special cases, not the other way around.

Having half of the API sleepable and the other not with no indication of
which is which simply makes it completely unusable and error prone for
both atomic and non-atomic contexts.
