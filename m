From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 20 Oct 2010 16:09:22 +0200
Subject: [PATCH 3/3] omap: add hwspinlock device
In-Reply-To: <AANLkTimTDCbLP+EeUeo35re0FrMvqV3ozU+v7DZXr_p3@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
	<87r5fmxghm.fsf@deeprootsystems.com>
	<AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
	<AANLkTimTDCbLP+EeUeo35re0FrMvqV3ozU+v7DZXr_p3@mail.gmail.com>
Message-ID: <AANLkTikE_WtBJQOJDNFGcW_4fW+FPvTBCHfrKsaUgZZY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 1:12 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Oct 19, 2010 at 3:02 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
...
>> i2c-omap, which is subsys_initcall (the I2C bus is shared between the
>> A9 and the M3 on some OMAP4 boards).
...
> Man. this is getting ugly. ?I think we need to discuss how to solve
> this at the Plumbers micro-conference. It kind of fits in with the
> whole embedded (ab)use of the device model topic anyway. Actually,
> this particular case isn't bad, but the moving of i2c and spi busses
> to an earlier initcall is just band-aiding the real problem of driver
> probe order dependencies.

+1

On Wed, Oct 20, 2010 at 1:53 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Rather than moving towards having more drivers have to be built in (and
> depend on their probe order) we need to be moving towards building all
> these drivers as modules, including omap-i2c.

+1

This whole thing is a mess, and today it's being solved in the wrong,
non-scalable and error-prone way.

The question is whether we want to gate hwspinlock until this issue is solved ?

On Wed, Oct 20, 2010 at 3:20 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> The issue of probe order still needs to be resolved for those of us who
> do want all the drivers built into the kernel.

What about doing something similar to the way suspend/resume and the
device hierarchy interact ?

device_resume waits for its parent to be resumed before waking up the
device - this sounds similar to what ->probe() should do: wait for its
device dependency to probe first (so in this case, i2c-omap should
wait for hwspinlock).

Conversely, device_suspend waits for all its children to be suspended
before continuing, which sounds just like what ->remove() should do
(so again, in this case, the hwspinlock device should wait for all its
users to be removed before bailing).

This is just a quick thought, I haven't even began to think of all the
use cases and requirements.
