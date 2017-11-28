From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 28 Nov 2017 13:35:02 +0000
Subject: [PATCH v2] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20171128125903.GA13019@kroah.com>
References: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
 <20170831160430.GB11200@kroah.com> <20171103151711.GA22453@kroah.com>
 <5A1C2FEB.2080006@nxp.com> <20171128125903.GA13019@kroah.com>
Message-ID: <5A1D6605.2080101@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/28/2017 02:59 PM, Greg KH wrote:
> On Mon, Nov 27, 2017 at 03:32:28PM +0000, Laurentiu Tudor wrote:
>>
>>
>> On 11/03/2017 05:17 PM, Greg KH wrote:
>>> On Thu, Aug 31, 2017 at 06:04:30PM +0200, Greg KH wrote:
>>>> On Mon, Aug 28, 2017 at 01:54:05PM +0300, laurentiu.tudor at nxp.com wrote:
>>>>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>>>>
>>>>> Move the source files out of staging into their final locations:
>>>>>     -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>>>>     -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>>>>>     -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>>>>>     -README.txt, providing and overview of DPAA goes to
>>>>>      Documentation/dpaa2/overview.txt
>>>>>
>>>>> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
>>>>> Update dpaa2_eth and dpio staging drivers.
>>>>>
>>>>> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> This is going to have to wait until I get a chunk of time to do the
>>>> review.  Probably after 4.13-final is out.
>>>
>>> Ok, review comments as I go through the code:
>>> 	mc-sys.c             323 EXPORT_SYMBOL(mc_send_command);
>>>
>>> should be EXPORT_SYMBOL_GPL(fsl_mc_send_command); to match up with your
>>> other exports and global namespace, right?
>>>
>>> You export a lot of dpcon_* symbols that no one uses, please do not do
>>> that.  Verify that all of them are actually used right now, if not,
>>> remove them.  If you think you are going to use them in the future,
>>> wonderful, add them in then.
>>>
>>> Same for your dpaa2_* exported symbols, most are not used from what I
>>> can see.
>>>
>>> struct dpaa2_io {
>>>           atomic_t refs;
>>>
>>> That's a kref, please use it instead of trying to roll your own.
>>>
>>> And even for this, your locking is not correct (i.e. you do not have
>>> any), that needs to be fixed so that teardown works correctly.
>>>
>>> You have a lot of WARN_ON() calls, that's going to be ignored and should
>>> all not be needed now that the code is debugged and working properly.
>>> Please remove them, or turn them into dev_err() calls with a real if ()
>>> check instead.
>>>
>>> You are checking "strings" for the type of device in a lot of places,
>>> like this:
>>> 	        if (strcmp(obj_desc->type, "dprc") == 0) {
>>> why are you not just using the built-in driver model .type field and
>>> comparing that to the different type structures?  It's much easier, and
>>> you don't have to again, "roll your own".  See the USB or Greybus code
>>> for examples of busses that have different "types" of devices on them at
>>> the same time.
>>>
>>> Ok, that's enough for now, please work on this, and we can go from
>>> there...
>>>
>>
>> What would the next steps be, now that the patches are in staging-next?
>> Are there plans for a new round of review?
>
> Send a patch that moves the files you think should be moved at this
> point in time, as I'm not quite sure which ones exactly you feel are
> ready to go.

The initial plan was to strictly move the things needed by this bus 
driver, thus leaving some source files at a later time. To the point, 
these files:
   "drivers/staging/fsl-mc/bus/dpbp*.*"
   "drivers/staging/fsl-mc/bus/dpcon*.*"
and this whole dir:
   "drivers/staging/fsl-mc/bus/dpio/*".

I'll prepare the patch so that it's more visible what files are to be moved.

---
Thanks & Best Regards, Laurentiu
