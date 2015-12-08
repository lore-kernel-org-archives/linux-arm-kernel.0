From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 08 Dec 2015 10:19:26 -0800
Subject: [PATCH v2 3/5] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <87fuzdiwcl.fsf@eliezer.anholt.net> (Eric Anholt's message of
 "Mon, 07 Dec 2015 17:04:58 -0800")
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-4-git-send-email-eric@anholt.net>
 <7hmvtln87l.fsf@deeprootsystems.com>
 <87fuzdiwcl.fsf@eliezer.anholt.net>
Message-ID: <7hvb88ls5t.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Eric Anholt <eric@anholt.net> writes:

> Kevin Hilman <khilman@kernel.org> writes:
>
>> Eric Anholt <eric@anholt.net> writes:
>>
>>> From: Alexander Aring <alex.aring@gmail.com>
>>>
>>> This patch adds support for several power domains on Raspberry Pi,
>>> including USB (so it can be enabled even if the bootloader didn't do
>>> it), and graphics.
>>>
>>> This patch is the combined work of Eric Anholt (who wrote USB support
>>> inside of the Raspberry Pi firmware driver, and wrote the non-USB
>>> domain support) and Alexander Aring (who separated the original USB
>>> work out from the firmware driver).
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>
>>> v2: Add support for power domains other than USB, using the new
>>>     firmware interface, reword commit message (changes by Eric)
>>
>> [...]
>>
>>> +/*
>>> + * Firmware indices for the old power domains interface.  Only a few
>>> + * of them were actually implemented.
>>> + */
>>> +#define RPI_OLD_POWER_DOMAIN_USB		3
>>> +#define RPI_OLD_POWER_DOMAIN_V3D		10
>>> +
>>
>> Is "old" the right word here?  Are there firmware versions that could be
>> used instead?  What happens when the firwmware is updated next time?
>
> Old is a good word.  It's the old interface.

Sure, but "old" is relative and based on experience, folks come to
regret those kinds of names.

> As for what happens when the firmware is updated: Nothing.  The firmware
> is updated all the time, and it maintains backwards compatibility.
> Unless you mean "what happens when a newer, fancier power domain
> interface is created and we need a name for the newer one" and the
> answer is "this is a define entirely within the driver, and we can just
> rename it when we want to."

Sure, it's very contained in this driver, so it's ultimately up to you.
It's not something worth blocking this about, I just wanted to be sure
since I'm not very familiar with how the rpi firmware evolves.

>> [...]
>>
>>> +	/*
>>> +	 * Use the old firmware interface for USB power, so that we
>>> +	 * can turn it on even if the firmware hasn't been updated.
>>> +	 */
>>> +	rpi_init_old_power_domain(rpi_domains, RPI_POWER_DOMAIN_USB,
>>> +				  RPI_OLD_POWER_DOMAIN_USB, "USB");
>>
>> This seems a bit restrictive.
>>
>> To me, it seems that determining "old" or "new" (or revision of fw
>> interface to use) should be described in DT, not hard-coded in the power
>> domain driver.
>>
>> What about an additional DT property to describe that? or possibly
>> another cell in the domain which could be used to optionally set
>> old/legacy.
>
> As the author and maintainer of the code, I don't feel it's restrictive.
> The firmware protocol is defined and is guaranteed to continue to exist,
> it's only useful for this platform, and defining a new set of custom
> devicetree properties for it would only obfuscate the implementation.
> DT is a useful tool for separating out the between-board differences for
> the same piece of hardware across multiple implementations at different
> addresses, while this is neither hardware nor in multiple
> implementations at different addresses.

That being said, firmware revisions are also very often something that
qualifies as a difference between boards.

Anyways, as I said above, I think this is a potential future problem,
but it's not a big deal to me since it's very self contained.

Kevin
