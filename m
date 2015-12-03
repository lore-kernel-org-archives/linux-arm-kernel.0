From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2015 16:41:18 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
 <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
 <20151203133727.GN8644@n2100.arm.linux.org.uk>
 <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
Message-ID: <20151203164118.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:12:06PM +0000, Peter Rosin wrote:
> Since it seems like a race is at the bottom of the observed problems, I'm
> going to look for things that look racy. The things that stand out to me
> are:
> 
> * uaccess.h:modify_domain() does a read-modify-write on DACR using
>   get_domain and set_domain, and I don't see any locking. Is that
>   safe? Why?

It's safe:
* the DACR is per-CPU
* all exceptions preserve the original DACR value when they return.
  This is done by storing the DACR value at entry onto the stack, along
  with the register set, and restoring it along with the register set
  on exit from exception processing, as if "nothing ever happened".
  This includes if the exception processing caused a switch to another
  thread.

> * uaccess_with_memcpy.c:__copy_to_user() has a mode in which it copies
>   "non-atomically" (if faulthandler_disabled() returns 0). If a fault
>   happens during __copy_to_user, what prevents some other thread from
>   clobbering DACR?

See the second point above.  Moreover, if we sleep in down_read(),
then __switch_to() reads the current DACR value and saves it in the
thread information, and will restore that value when resuming the
thread - even if the thread has been migrated to a different CPU.

> * In uaccess.h:uaccess_save_and_enable(), what prevents a context
>   switch between the get_domain and set_domain calls?

Nothing, but it doesn't matter, because the DACR register is saved
and restored to preserve its value across all exceptions and thread
switches.

I suspect the only way to nail this down is to litter the uaccess
code (virtually every alternate line) with:

	BUG_ON(get_domain() & domain_mask(DOMAIN_USER) ==
	       domain_val(DOMAIN_USER, DOMAIN_NOACCESS));

to narrow down the exact point where the domain register seemingly
gets reset.  Maybe it'll provide some hint.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
