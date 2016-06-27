From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jun 2016 16:37:45 +0200
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <20160627135723.GH1041@n2100.armlinux.org.uk>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com> <20160627094552.GE1041@n2100.armlinux.org.uk>
 <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
 <20160627113143.GF1041@n2100.armlinux.org.uk>
 <842a453d-3295-ffbd-f3dd-67baba1692d2@redhat.com>
 <20160627135723.GH1041@n2100.armlinux.org.uk>
Message-ID: <a4debc32-f25d-0716-d8ad-cb6e19bac1d2@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-06-16 15:57, Russell King - ARM Linux wrote:
> On Mon, Jun 27, 2016 at 02:53:16PM +0200, Hans de Goede wrote:
>> Hi Russell,
>>
>> On 27-06-16 13:31, Russell King - ARM Linux wrote:
>>> I think I covered that - all the paths are indentical in the ARM
>>> architecture code, and have been identical in this respect well before
>>> any of the drivers you've pointed out.
>>
>> They may be identical, but there is no _need_ for them to be identical
>> AFAICT.
>
> Well, the need for this comes from the need for drivers to work on any
> architecture, so all architectures need to implement pm_power_off()
> (and the other hooks) so they work the same way.
>
> So, we can't just change it on ARM and be at odds with everything else.
> We need to have consistency here.  If we want to change it on ARM, we
> need all the other architectures to also change with us.

Which is why I proposed a flag to request the different behavior,
so that for shared code, like the efi code we keep the same
consistent behavior as before.

>> Maybe if so many drivers need fixing, the conditions set
>> down for poweroff are wrong, and we need to fix those instead ?
>
> The drivers which need fixing are the I2C drivers, not the drivers
> calling into the I2C layer.

You mean the i2c-host/controller drivers I assume, right ?
I don't think that is doable, see below.
\
>>> ... and they're all violating the conditions set down for by the
>>> architecture for an orderly poweroff
>>
>> This sounds a lot like "we're doing things this way because we always
>> have been doings things this way", which does not really sound like
>> a good argument to me.
>
> It's all to do with providing a _stable_ interface that works the same
> across all architectures.  We can't have one architecture going off and
> doing something different with a cross-arch interface.
>
>>> Now, we could do as you are suggesting, and route IRQs to the
>>> remaining CPU via all shutdown paths, but that would be papering over
>>> the fundamental bug here: if a function is called with IRQs disabled,
>>> it (or any called function) has no business re-enabling IRQs.
>>
>> Which brings us to the fundamental question why are we disabling
>> irqs in machine_poweroff ?
>
> See above.

Cross-arch compatiblity is important, but working code is even
more important, I really believe this cannot be fixed in a way
which keeps irqs disabled in machine_power_off, see below.

>> Maybe this is necessary on some boards (efi, psci?), but at the
>> same time it breaks things badly on other boards. Thinking about
>> this more I actually believe that on boards with a i2c pmic
>> pm_power_off MUST be called with irqs enabled:
>>
>> (from your second reply:)
>>
>>> More to that, the I2C core layer is setup to allow i2c_transfer() to
>>> be called from non-schedulable contexts:
>>>
>>>                 if (in_atomic() || irqs_disabled()) {
>>>                         ret = adap->trylock_bus(adap, I2C_LOCK_SEGMENT);
>>>                         if (!ret)
>>>                                 /* I2C activity is ongoing. */
>>>                                 return -EAGAIN;
>>>
>>> prior to calling into the adapters ->master_xfer() function.  This
>>> acknowledges that, if i2c_transfer() is called in a context which
>>> is not schedulable or IRQs are disabled, the adapters ->master_xfer()
>>> needs to handle this situation.
>>
>> So what happens if we disable irqs as you suggest and machine_power_off
>> gets called when an i2c transfer is ongoing?
>
> Right... and you also need to ask that very same question again,

No I do not, if irq's are enabled, then the above check will not
trigger, and the code will do a normal lock on the adapter and
wait for the in progress transfer to complete.

> even
> with IRQs enabled.  Enabling IRQs doesn't fix that problem

Actually it does, see above.

> because I
> think you'll find that no one bothers checking that (eg) a write to
> the TWL device actually succeeded.

No one bothers, because with irqs enabled -EAGAIN never happens.

> regmap just propagates the error
> code that it received from the I2C layer, twl_i2c_write() prints an
> error message, and also propagates the error code.  twl_i2c_write_u8()
> again propagates the error code, and twl4030_power_off() just prints
> more about a failure.
>
> Enabling IRQs actually does nothing to solve this underlying problem,
> all it does is paper over the problem and hopes that it goes away.
>
> In order to solve this, it requires an additional step: _all_ the
> drivers doing this _also_ need to check the return value from the I2C
> write return code and retry if it's EAGAIN.  Retry how many times,
> and after what period?

Heuh, what help is retrying going to be here ? Absolutely no help
what so ever, we've disabled all cpus except the one we're running
on and we've disabled irqs on the one we're running on, so if we get
EAGAIN we will always get EAGAIN.

This is exactly why we need scheduling / irqs for i2c pmic drives
pm_power_off, there just us no other feasible way.

The patch you've quoted above allows atomic submits of i2c
transfers for the special case where the i2c-host driver can do an
atomic transfer. I do not know of such drivers, but the only way I
envision this can work is by busy-waiting.

Now lets assume I patch all the i2c-host drivers to support busy
waiting / irq-flag-polling while called atomicly, that still will
not help, since that still leaves the race, since an in progress
i2c transfer started before machine_power_off was called will
likely not be atomic, but instead use irqs, which will now never
happen.

So the only way to make i2c power-off work without interrupts
is to make all i2c transfers on the pmic bus atomic all the time,
iow busy-wait for a slow 100KHz i2c transfer to complete all
the time, which is simply unacceptable.


Which brings us back to square one, we really need irqs to
be enabled for power-off with i2c pmics.

This really is a functional requirement for power-off to be
able to implemented in any sane way on systems with an i2c
pmic.

Regards,

Hans
