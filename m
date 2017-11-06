From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Mon, 6 Nov 2017 14:20:08 +0000
Subject: [PATCH v2] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20171103151711.GA22453@kroah.com>
References: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
 <20170831160430.GB11200@kroah.com> <20171103151711.GA22453@kroah.com>
Message-ID: <5A006F97.1080409@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/03/2017 05:17 PM, Greg KH wrote:
> On Thu, Aug 31, 2017 at 06:04:30PM +0200, Greg KH wrote:
>> On Mon, Aug 28, 2017 at 01:54:05PM +0300, laurentiu.tudor at nxp.com wrote:
>>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>>
>>> Move the source files out of staging into their final locations:
>>>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>>>    -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>>>    -README.txt, providing and overview of DPAA goes to
>>>     Documentation/dpaa2/overview.txt
>>>
>>> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
>>> Update dpaa2_eth and dpio staging drivers.
>>>
>>> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>
>> This is going to have to wait until I get a chunk of time to do the
>> review.  Probably after 4.13-final is out.
>
> Ok, review comments as I go through the code:
> 	mc-sys.c             323 EXPORT_SYMBOL(mc_send_command);
>
> should be EXPORT_SYMBOL_GPL(fsl_mc_send_command); to match up with your
> other exports and global namespace, right?

Right. There's an inconsistent mixture of EXPORT_SYMBOL() and 
EXPORT_SYMBOL_GPL() usage. I'll change them all to EXPORT_SYMBOL_GPL().

> You export a lot of dpcon_* symbols that no one uses, please do not do
> that.  Verify that all of them are actually used right now, if not,
> remove them.  If you think you are going to use them in the future,
> wonderful, add them in then.

Actually, most of the dpcon_* APIs are used in the ethernet driver here: 
drivers/staging/fsl-dpaa2/ethernet. I think i saw only a couple of 
functions that are not used so I'll drop those.

> Same for your dpaa2_* exported symbols, most are not used from what I
> can see.

I'll check these too and drop the unused ones.

> struct dpaa2_io {
>          atomic_t refs;
>
> That's a kref, please use it instead of trying to roll your own.
>
> And even for this, your locking is not correct (i.e. you do not have
> any), that needs to be fixed so that teardown works correctly.

I think we can drop this refcount altogether as it's not used. Roy, any 
comment on this?

> You have a lot of WARN_ON() calls, that's going to be ignored and should
> all not be needed now that the code is debugged and working properly.
> Please remove them, or turn them into dev_err() calls with a real if ()
> check instead.

Right, there are quite of few (100+) WARN_ON()s. I'll go through them 
and clean them up ... most of them seem paranoid checks anyway.

> You are checking "strings" for the type of device in a lot of places,
> like this:
> 	        if (strcmp(obj_desc->type, "dprc") == 0) {
> why are you not just using the built-in driver model .type field and
> comparing that to the different type structures?  It's much easier, and
> you don't have to again, "roll your own".  See the USB or Greybus code
> for examples of busses that have different "types" of devices on them at
> the same time.
>

I had a quick look over greybus and noticed the device types declared in 
drivers/staging/greybus/greybus.h plus some helper macros to check the 
device type. I'll give this a go, though i might return with some 
questions (e.g. I don't yet understand what device_type::release op is 
used for).

---
Thanks & Best Regards, Laurentiu
