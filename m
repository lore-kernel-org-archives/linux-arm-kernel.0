From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 8 Sep 2011 20:51:32 +0200
Subject: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with
	graceful exit
In-Reply-To: <4E64A9AD.7030206@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com>
	<4E64A040.4000801@ru.mvista.com> <4E64A77A.10400@ti.com>
	<20110905104755.GC6918@n2100.arm.linux.org.uk>
	<4E64A9AD.7030206@ti.com>
Message-ID: <CAORVsuVz1XoudfRTehhX_s-5gHE7oc3H1pW2=3cYvY+a38iQYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Mon, Sep 5, 2011 at 12:51 PM, Santosh <santosh.shilimkar@ti.com> wrote:
> On Monday 05 September 2011 04:17 PM, Russell King - ARM Linux wrote:
>>
>> On Mon, Sep 05, 2011 at 04:12:02PM +0530, Santosh wrote:
>>>
>>> On Monday 05 September 2011 03:41 PM, Sergei Shtylyov wrote:
>
> [..]
>
>>>>> /* Static mapping, never released */
>>>>> l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>>>>> - BUG_ON(!l2cache_base);
>>>>> + if (WARN_ON(!l2cache_base))
>>>>> + return -ENODEV;
>>>>
>>>> Rather ENOMEM...
>>>>
>>> Nope. Even though it's related to memory, it's
>>> a memory controller so DEV is right.
>>
>> No it's not. ?The most likely reason ioremap() fails is because:
>>
>> 1. it's run out of memory for the metadata or page tables.
>> 2. you passed it an invalid memory type (unlikely, you're using ioremap
>> ? ?which uses a fixed known good type).
>> 3. the address was>4GB but was not section aligned (also unlikely).
>>
>> Therefore, the error code should be "out of memory" not "no such device".
>
> Got it. Will fix that.
Patch [07/25] has the same code and so will need fixing too.

Regards,
Jean

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
