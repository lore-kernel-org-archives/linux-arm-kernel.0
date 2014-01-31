From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 31 Jan 2014 18:04:39 -0500
Subject: [PATCH] usb: dwc3: keystone: switch to use runtime pm
In-Reply-To: <20140131221553.GF2502@saruman.home>
References: <1391174426-13773-1-git-send-email-grygorii.strashko@ti.com>
 <20140131151955.GB20736@saruman.home> <52EBC499.2070302@ti.com>
 <20140131154721.GD20736@saruman.home> <52EBC650.50305@ti.com>
 <20140131164534.GL20736@saruman.home> <52EBF790.3090407@ti.com>
 <20140131221553.GF2502@saruman.home>
Message-ID: <52EC2C07.702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 January 2014 05:15 PM, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Jan 31, 2014 at 02:20:48PM -0500, Santosh Shilimkar wrote:
> 
> [ snip ]
> 
>>> note that because of pm_runtime_set_active() that first
>>> pm_runtime_get_sync() in probe() will simply increase the reference
>>> counter without calling my ->runtime_resume() callback, which is exactly
>>> what we want, as that would completely avoid situations of bad context
>>> being restored because of that initial pm_runtime_get_sync().
>>>
>> Thanks for making your point bit clear. 
> 
> no problem.
> 
>>> Then, we can even make pm_runtime completely async easily, because
>>> clk_prepare() was called only on probe() (or before it, for that
>>> matter).
>>>
>>> Bottomline is, if you can guarantee me that clk_get(), clk_prepare(),
>>> clk_enable() and pm_runtime_set_active() will be called properly before
>>> my probe, i'll be more than happy to comply with your request above as
>>> that will greatly simplify my driver.
>>>
>> Which is the case at least I see on Keystone. And hence the patch from
> 
> I was going over pm_domain.c and drivers/base/power/clock_ops.c and none
> of them enable pm_runtime or make sure pm_runtime_set_active() is
> called.
> 
>> Grygorii works. I also noticed your proposal for wider platform to
>> enforce above behavior which seems to be a good idea.
> 
> it'll take months to stabilize though ;-)
> 
>>> Just make, also, that if this clock is shared between dwc3-keystone
>>> wrapper and dwc3 core, you clk_get() on both driver's probe.
>>>
>> I understand. In summary, whichever patch you pick(yours) or Grygorii's,
>> its completely safe to remove the clock handling from Keystone USB driver.
> 
> alright, since I can't really test, I'll take this as a true statement.
> If there are any regressions I can blame you, hehehe.
> 
No problem... :D
Grygorii patch has been working well so all good with that
