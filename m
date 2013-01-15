From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 15 Jan 2013 12:10:43 +0530
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast receiver
In-Reply-To: <20130114153612.GF7990@e106331-lin.cambridge.arm.com>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.02.1301141204421.7475@ionos>
 <20130114112951.GC7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141247020.7475@ionos>
 <20130114121247.GD7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141318460.7475@ionos>
 <20130114153612.GF7990@e106331-lin.cambridge.arm.com>
Message-ID: <50F4F9EB.3010405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 January 2013 09:06 PM, Mark Rutland wrote:
> On Mon, Jan 14, 2013 at 02:17:26PM +0000, Thomas Gleixner wrote:
>> On Mon, 14 Jan 2013, Mark Rutland wrote:
>>> On Mon, Jan 14, 2013 at 11:50:55AM +0000, Thomas Gleixner wrote:
>>>> On Mon, 14 Jan 2013, Mark Rutland wrote:
>>>>
>>>>> On Mon, Jan 14, 2013 at 11:06:31AM +0000, Thomas Gleixner wrote:
>>>>>> On Wed, 9 Jan 2013, Mark Rutland wrote:
>>>>>>> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>>>>>>> +extern int tick_receive_broadcast(void);
>>>>>>> +#else
>>>>>>> +static inline int tick_receive_broadcast(void)
>>>>>>> +{
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>
>>>>>> What's the inline function for? If an arch does not have broadcasting
>>>>>> support it should not have a receive broadcast function call either.
>>>>>
>>>>> That was how this was originally structured [1], but Santosh suggested this
>>>>> would break the build for !GENERIC_CLOCKEVENTS_BROADCAST [1]. It means that the
>>>>> arch-specific receive path (i.e. IPI handler) doesn't have to be #ifdef'd,
>>>>> which makes it less ugly.
>>>>
>>>> Hmm. If you want to keep the IPI around unconditionally the inline
>>>> makes some sense, though the question is whether keeping an unused IPI
>>>> around makes sense in the first place. I'd rather see a warning that
>>>> an unexpected IPI happened than a silent inline function being called.
>>>
>>> How about I add a warning (e.g. "Impossible timer broadcast received.") and
>>> return -EOPNOTSUPP when !GENERIC_CLOCKEVENTS_BROADCAST?
>>
>> You still need to do something with the return value in the arch IPI
>> code, right?
>
> Good point. Having the stub when !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST is
> clearly problematic.
>
> I'll go with your original suggestion, removing the tick_receive_broadcast stub
> for !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST and I'll #idef the IPI_TIMER handler.
> That way it'll fall down to the standard warning for an unexpected/unknown IPI
> for arch/arm at least.
>
The alternative is fine by me.

Regards
santosh
