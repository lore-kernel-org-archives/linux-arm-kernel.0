From: khilman@ti.com (Kevin Hilman)
Date: Fri, 29 Jun 2012 09:07:14 -0500
Subject: [PATCH 1/1] ARM: OMAP3: PM: don't explicitly enable the IO-chain
 interrupt
In-Reply-To: <CAAwP0s2F2pfBUpMzDaGJvoDNtQ+mFCTMnN43MoYD=k-rRT1mGw@mail.gmail.com>
 (Javier Martinez Canillas's message of "Fri, 29 Jun 2012 15:25:02
 +0200")
References: <1340933123-30401-1-git-send-email-javier@dowhile0.org>
 <87obo2mg61.fsf@ti.com>
 <CAAwP0s2F2pfBUpMzDaGJvoDNtQ+mFCTMnN43MoYD=k-rRT1mGw@mail.gmail.com>
Message-ID: <87y5n6ky99.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <martinez.javier@gmail.com> writes:

> On Fri, Jun 29, 2012 at 2:55 PM, Kevin Hilman <khilman@ti.com> wrote:
>> +Paul
>>
>> Javier Martinez Canillas <javier@dowhile0.org> writes:
>>
>>> commit 99b59df0 ARM: OMAP3: PM: fix shared PRCM interrupt leave disabled at boot
>>>
>>> set the IRQ_NOAUTOEN flag to the PCRM IO-chain irq to avoid this
>>> interrupt until the PM core code is ready to handle the interrupts.
>>>
>>> It seems that this is not needed anymore after the OMAP PRCM I/O chain
>>> code re-implementation introduced on merge commit:
>>>
>>> 9a17d88 Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/
>>>
>>> The IRQ_NOAUTOEN flags is not set for the PRCM I/O irq anymore on the
>>> new implementation. This has the effect that a request_irq() for the
>>> PRCM I/O chain irq will auto-enable the requested IRQ and a later call
>>> to enable_irq() will lead to the following warning:
>>
>> I noticed that warning too, but I don't think $SUBJECT patch is the
>> right fix.
>>
>> We still need the IRQ_NOAUTOEN so that cases where PM is not enabled,
>> the IO chain interrupts are not enabled.
>>
>> Looking closer, it looks like the merge of omap-devel-c-for-3.6 removed
>> the IRQ_NOAUTOEN in the merge resolution, which wasn't right.
>>
>> I'll cook up a fix for this.
>>
>> Kevin
>>
>>
>
> Hi Kevin,
>
> Yes, I can confirme you that the IRQ_NOAUTOEN was gone. I didn't know
> if the right solution was to set that flag again or to just remove the
> duplicated enable_irq(). I should had tag my patch with RFC instead of
> PATCH I guess :-)

No worries.   I just sent a patch adding back the IRQ_NOAUTOEN.

Thanks for reporting the bug.  I had noticed the boot time errors to but
had not yet got to looking into them.  Your patch made me dig deeper.

Thanks,

Kevin
