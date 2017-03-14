From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 14 Mar 2017 09:43:09 -0700
Subject: [PATCH v5 15/39] [media] v4l2: add a frame interval error event
In-Reply-To: <1489508491.28116.8.camel@ndufresne.ca>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-16-git-send-email-steve_longerbeam@mentor.com>
 <5b0a0e76-2524-4140-5ccc-380a8f949cfa@xs4all.nl>
 <ec05e6e0-79f2-2db2-bde9-4aed00d76faa@gmail.com>
 <6b574476-77df-0e25-a4d1-32d4fe0aec12@xs4all.nl>
 <5d5cf4a4-a4d3-586e-cd16-54f543dfcce9@gmail.com>
 <aa6a5a1d-18fd-8bed-a349-2654d2d1abe0@xs4all.nl>
 <20170313104538.GF21222@n2100.armlinux.org.uk>
 <1489508491.28116.8.camel@ndufresne.ca>
Message-ID: <429b04e6-3922-6568-fc3f-036dc632a55b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/14/2017 09:21 AM, Nicolas Dufresne wrote:
> Le lundi 13 mars 2017 ? 10:45 +0000, Russell King - ARM Linux a ?crit :
>> On Mon, Mar 13, 2017 at 11:02:34AM +0100, Hans Verkuil wrote:
>>> On 03/11/2017 07:14 PM, Steve Longerbeam wrote:
>>>> The event must be user visible, otherwise the user has no indication
>>>> the error, and can't correct it by stream restart.
>>> In that case the driver can detect this and call vb2_queue_error. It's
>>> what it is there for.
>>>
>>> The event doesn't help you since only this driver has this issue. So nobody
>>> will watch this event, unless it is sw specifically written for this SoC.
>>>
>>> Much better to call vb2_queue_error to signal a fatal error (which this
>>> apparently is) since there are more drivers that do this, and vivid supports
>>> triggering this condition as well.
>> So today, I can fiddle around with the IMX219 registers to help gain
>> an understanding of how this sensor works.  Several of the registers
>> (such as the PLL setup [*]) require me to disable streaming on the
>> sensor while changing them.
>>
>> This is something I've done many times while testing various ideas,
>> and is my primary way of figuring out and testing such things.
>>
>> Whenever I resume streaming (provided I've let the sensor stop
>> streaming at a frame boundary) it resumes as if nothing happened.  If I
>> stop the sensor mid-frame, then I get the rolling issue that Steve
>> reports, but once the top of the frame becomes aligned with the top of
>> the capture, everything then becomes stable again as if nothing happened.
>>
>> The side effect of what you're proposing is that when I disable streaming
>> at the sensor by poking at its registers, rather than the capture just
>> stopping, an error is going to be delivered to gstreamer, and gstreamer
>> is going to exit, taking the entire capture process down.
> Indeed, there is no recovery attempt in GStreamer code, and it's hard
> for an higher level programs to handle this. Nothing prevents from
> adding something of course, but the errors are really un-specific, so
> it would be something pretty blind. For what it has been tested, this
> case was never met, usually the error is triggered by a USB camera
> being un-plugged, a driver failure or even a firmware crash. Most of
> the time, this is not recoverable.
>
> My main concern here based on what I'm reading, is that this driver is
> not even able to notice immediately that a produced frame was corrupted
> (because it's out of sync). From usability perspective, this is really
> bad.

First, this is an isolated problem, specific to bt.656 and it only
occurs when disrupting the analog video source signal in some
way (by unplugging the RCA cable from the ADV718x connector
for example).

Second, there is no DMA status support in i.MX6 to catch these
shifted bt.656 codes, and the ADV718x does not provide any
status indicators of this event either. So monitoring frame intervals
is the only solution available, until FSL/NXP issues a new silicon rev.


>   Can't the driver derive a clock from some irq and calculate for
> each frame if the timing was correct ?

That's what is being done, essentially.

>   And if not mark the buffer with
> V4L2_BUF_FLAG_ERROR ?

I prefer to keep the private event, V4L2_BUF_FLAG_ERROR is too
unspecific.

Steve


>
>> This severely restricts the ability to be able to develop and test
>> sensor drivers.
>>
>> So, I strongly disagree with you.
>>
>> Loss of capture frames is not necessarily a fatal error - as I have been
>> saying repeatedly.  In Steve's case, there's some unknown interaction
>> between the source and iMX6 hardware that is causing the instability,
>> but that is simply not true of other sources, and I oppose any idea that
>> we should cripple the iMX6 side of the capture based upon just one
>> hardware combination where this is a problem.
> Indeed, it happens all the time with slow USB port and UVC devices.
> Though, the driver is well aware, and mark the buffers with
> V4L2_BUF_FLAG_ERROR.
>
>> Steve suggested that the problem could be in the iMX6 CSI block - and I
>> note comparing Steve's code with the code in FSL's repository that there
>> are some changes that are missing in Steve's code to do with the CCIR656
>> sync code setup, particularly for >8 bit.  The progressive CCIR656 8-bit
>> setup looks pretty similar though - but I think what needs to be asked
>> is whether the same problem is visible using the FSL/NXP vendor kernel.
>>
>>
>> * - the PLL setup is something that requires research at the moment.
>> Sony's official position (even to their customers) is that they do not
>> supply the necessary information, instead they expect customers to tell
>> them the capture settings they want, and Sony will throw the values into
>> a spreadsheet, and they'll supply the register settings back to the
>> customer.  Hence, the only way to proceed with a generic driver for
>> this sensor is to experiment, and experimenting requires the ability to
>> pause the stream at the sensor while making changes.  Take this away,
>> and we're stuck with the tables-of-register-settings-for-set-of-fixed-
>> capture-settings approach.  I've made a lot of progress away from this
>> which is all down to the flexibility afforded by _not_ killing the
>> capture process.
