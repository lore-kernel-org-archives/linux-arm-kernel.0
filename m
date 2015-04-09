From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 9 Apr 2015 22:54:26 +0300
Subject: [patch 2/2] leds: netxbig: clean up a data type issue
In-Reply-To: <20150409192557.GD1509@kw.sim.vm.gnt>
References: <20150409090712.GF17605@mwanda>
 <20150409192557.GD1509@kw.sim.vm.gnt>
Message-ID: <20150409195426.GP10964@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 09:25:57PM +0200, Simon Guinot wrote:
> On Thu, Apr 09, 2015 at 12:07:12PM +0300, Dan Carpenter wrote:
> > This driver is pretty hardware specific so it's unlikely that we're
> > going to be using it on 64 big endian systems.  Still, the current code
> > causes a static checker warning so we may as well change the type from
> > "unsigned long" to "u32" and remove the casting.
> 
> Hi Dan,
> 
> Thanks for the patch.
> 
> Why do you think it would be an issue to use the u32 type for this
> variables on a 64-bit big-endian machine ? Note that this LED mechanism
> is actually used on ARM 32-bits and x86-64 NAS platforms. The latter are
> not mainlined yet. But indeed, for now, there is no plan to use it on a
> 64-bit big-endian machine.
> 
> Since the whole LED code uses the unsigned long type to hold the delay
> values, if possible, I would prefer to keep the delay_{on,off} variables
> consistent with that.
> 
> Is there an another way to make the "static checker" happy ?

We're writing over 32 bits of a long.  It's a dangerous habbit.

If long is u32 then of_property_read_u32_index() works, obviously.  If
it is a little endian and the last 32 bits have been zeroed out (as they
have been here) then that also works.

If it's big endian and 64 bit then it doesn't work because we're writing
to the wrong 32 bits.

regards,
dan carpenter
