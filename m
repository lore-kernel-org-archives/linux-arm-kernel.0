From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 03 Jun 2014 15:06:59 +0200
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
In-Reply-To: <CAPDyKFr67c0NfL6+_0mejz2rSjwCLXhhGVqXpicerM1ZwRMNmg@mail.gmail.com>
References: <537E31F7.1030505@gmail.com>	<537F1148.3010102@redhat.com>	<20140523112239.GB12304@sirena.org.uk>	<537F3610.3050104@redhat.com>	<20140523162718.GE22111@sirena.org.uk>	<53806F26.6050706@redhat.com>	<20140525123452.GS22111@sirena.org.uk>	<53824294.1090609@redhat.com>	<20140526103807.GV22111@sirena.org.uk>	<538321AB.4050006@redhat.com>	<20140526142225.GF22111@sirena.org.uk>	<538356DA.7090302@redhat.com>	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>	<53838023.2080807@redhat.com>	<CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>	<5385AF94.90004@redhat.com>	<CAPDyKFpd1mPi1pqTxx=uNG+MsprCngZN-WFnNQrB_1+WuA0faA@mail.gmail.com>	<538DAC58.90001@redhat.com>
 <CAPDyKFr67c0NfL6+_0mejz2rSjwCLXhhGVqXpicerM1ZwRMNmg@mail.gmail.com>
Message-ID: <538DC873.8000809@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/03/2014 02:58 PM, Ulf Hansson wrote:
> On 3 June 2014 13:07, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 06/03/2014 12:14 PM, Ulf Hansson wrote:
>>> On 28 May 2014 11:42, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> <mega snip>
>>
>>>>> If the mmc_of_parse() returns -EPROBE_DEFER, the mmc host driver will
>>>>> return the same error code from it's ->probe(). This provides us with
>>>>> the ability of waiting for the "powerup driver" to be probed.
>>>>
>>>> Ack. Note though that mmc_of_parse will likely not do the probe itself,
>>>> the way I see it it will do a platform_device_register() and let the
>>>> platform bus code do its thing. Downside of this is that
>>>> platform_device_register() will not propagate probe errors such as
>>>> -EPROBE_DEFER, so we need to check afterwards that a driver is actually
>>>> bound, see above.
>>>
>>> Just to confirm your ideas, this is how I see the instantiation of the
>>> device and probe of the "powerup driver" as well.
>>
>> Ok, so given that in another mail thread we've just decided to not use
>> slot subnodes in the devicetree hierarchy, how are we going to represent
>> the powerup-bits in devicetree? I suggest that we represent this with
>> a separate subnode under the mmc host, with its own compatible string.
>>
>> Since reg == 0 is for the card device, and reg 1-7 is for the sdio function
>> devices, I suggest that we use reg = <8> for the powerup subnode. Then
>> the mmc-core can check for such a child subnode, and if it is there
>> instantiate a platform device for it, and then handle the probe as
>> described above.
> 
> Why do we need to put the sdio functions devices in DT?

To define sdio function specific non probable info, such as oob irqs,
also see the "mmc: Add SDIO function devicetree subnode parsing" patch-set
of which I send v3 this morning.

> 
>>
>>>
>>>>
>>>>> If the mmc_of_parse() returns another error code, due to that the
>>>>> "powerup driver" failed to be probed, the mmc host driver's ->probe()
>>>>> will return the same error code and consequentially no power up of the
>>>>> card will be performed at all.
>>>>
>>>> Ack.
>>>>
>>>>> Powerup driver's ->probe():
>>>>> Typically the "powerup driver" will need to register a few callback
>>>>> functions towards the mmc core. Typically at mmc_of_parse(), those
>>>>> callbacks will have to be connected to a particular mmc host.
>>>>>
>>>>> I would like to see three different callbacks, mirroring each of the
>>>>> mmc_ios power_mode states MMC_POWER_OFF|UP|ON.
>>>>
>>>> Hmm, can't we do something with runtime pm here instead? I would be
>>>> nice if we could use the platform bus for this instead of inventing
>>>> a new bus for this.
>>>
>>> We don't need another bus. The driver only have to register some mmc
>>> specific callbacks, that's all I am saying. Of course these parts
>>> can't be re-used for other subsystems, unless we find it useful to
>>> have similar callbacks for all subsystems.
>>>
>>> Still, using runtime PM might work.
>>>
>>> I see these important things that follow if we decide to use runtime
>>> PM to trigger the power up/off sequence.
>>> 1) In cases of !CONFIG_PM_RUNTIME, it means the "powerup driver" once
>>> probed, will keep it's resources enabled forever.
>>
>> Ack.
> 
> So, the consequence is that for CONFIG_PM_SLEEP systems not using
> CONFIG_PM_RUNTIME - we don't have a good solution.
> 
> Is that acceptable?

IMHO yes, if people want maximum power savings they should use
CONFIG_PM_RUNTIME. And since this is all for yet to be added
systems / configs I would expect CONFIG_PM_RUNTIME to be supported
there just fine.

> 
>>
>>> 2) If we want to use runtime PM to control fine grained power
>>> management of the "powerup driver", now this can't be done.
>>
>> We can always add something more elaborate later if needed, the advantage
>> of sticking with a platform-dev represented by its own dt subnode +
>> runtime PM, is that powerup drivers can be used with other busses too,
>> all the other busses will need is to specify the subnode location + address
>> inside the tree, and add code to their subsys core to instantiate the
>> platform device.
>>
>>> 3) The "powerup driver" must be able to cope with two states (on/off),
>>> instead the three MMC_POWER_OFF|UP|ON states.
>>
>> Since we need to powerup before probing, I think this is fine,
>> we will want to do the power-up before we do the OFF -> UP -> ON
>> sequence in mmc_power_up(), and we will want to do the power-down
>> after transitioning to OFF.
>>
>>> 4) The system suspend/resume sequence for the SDIO card, will be more
>>> tricky to handle.
>>
>> See below.
>>
>>> In principle we need to decide what runtime PM should be used for in
>>> this context.
>>
>> I think we should add a powerup_dev pdev pointer to the mmc-card struct,
>> so that sdio drivers which want to shutdown the device to save power can
>> do so (by making the relevant runtime pm calls on the pdev).
> 
> Makes sense.
> 
>>
>> The mmc core will never know if it is safe to actually power down the
>> device again as even if the sdio driver indicates it is ok to shutdown
>> the mmc-host, it may still need the sdio device to stay powered so as to
>> not loose state. Or maybe even for system-wakeup through an oob irq.
> 
> That should already be handled through the flags MMC_PM_KEEP_POWER and
> MMC_PM_WAKE_SDIO_IRQ.

True. So we could have the sdio core do power down / up on the powerup_dev
on suspend / resume and on host mmc_power_on / off.

Regards,

Hans
