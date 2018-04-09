From: peda@axentia.se (Peter Rosin)
Date: Mon, 9 Apr 2018 14:12:56 +0200
Subject: [PATCH 0/5] Add tda998x (HDMI) support to atmel-hlcdc
In-Reply-To: <20180409120217.GQ16141@n2100.armlinux.org.uk>
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409111733.GP16141@n2100.armlinux.org.uk>
 <bbc7a992-5f17-c108-2b6a-01a585e6e315@axentia.se>
 <20180409120217.GQ16141@n2100.armlinux.org.uk>
Message-ID: <56a4e7ac-62b1-9f0e-5d30-cfc9dae0fb2e@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-09 14:02, Russell King - ARM Linux wrote:
> On Mon, Apr 09, 2018 at 01:44:22PM +0200, Peter Rosin wrote:
>> On 2018-04-09 13:17, Russell King - ARM Linux wrote:
>>> On Mon, Apr 09, 2018 at 12:59:13PM +0200, Peter Rosin wrote:
>>>> During this, I found that the tda998x driver never sets the format in
>>>> the connector display_info. Thus, the atmel-hlcdc driver fails to select
>>>> output format. Since I had similar problems with ds90c185 lvds encoder
>>>> I added patches to override the atmel-hlcdc output format via a DT
>>>> property and things start to play together.
>>>
>>> That sounds like a hack.  The tda998x driver doesn't set the format
>>> because it pre-dates the addition of this information in the display
>>> info structure, and none of its current users require that information.
>>>
>>> As you're the first to require it, rather than working around the
>>> driver by adding stuff to DT, it would be much better to improve the
>>> driver by adding this information.
>>>
>>> Thanks.
>>
>> Even if I improved the tda998x driver, it would not be correct.
>>
>> The background is that while the atmel-hlcdc driver supports rgb888,
>> our PCB is only wired for rgb565. And the tda19988 has rgb888 input
>> (we have the lsb bits tied to ground on our PCB). So, the tda998x
>> driver can request rgb888 and the atmel-hlcdc driver can say ok,
>> but it still would not be correct. So, where exactly do you suggest
>> that I model the narrowing of the display format?
> 
> That isn't described in your covering email to the series - instead,
> your cover sounds like you're working around a deficiency in the
> tda998x driver.

Sorry, my bad, And sorry for the confusion.

> I think you need to make it clear that the reason you need the DT
> property is because of the way the hardware is wired, not because of
> the missing bus format in the TDA998x driver.  From what you've just
> described, the missing bus format is merely incidental to the issue,
> and whether TDA998x provided this or not, you'd still need to override
> it.

I'll reword if/when I send v2.

> If we were to add the bus format to the tda998x at a later date, I
> would hope your driver would ignore it in this situation?

Assuming that by "your driver" you mean the atmel-hlcdc driver (which
isn't mine), then yes, with the override in place anything the tda998x
driver says about the connector format will still result in what the
forced output mode says from the atmel-hlcdc driver.

Cheers,
Peter
