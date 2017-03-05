From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sat, 4 Mar 2017 16:37:43 -0800
Subject: [PATCH v4 13/36] [media] v4l2: add a frame timeout event
In-Reply-To: <20170304105600.GS3220@valkosipuli.retiisi.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-14-git-send-email-steve_longerbeam@mentor.com>
 <20170302155342.GJ3220@valkosipuli.retiisi.org.uk>
 <4b2bcee1-8da0-776e-4455-8d8e7a7abf0a@gmail.com>
 <20170303114506.GM3220@valkosipuli.retiisi.org.uk>
 <59663ea1-b277-1543-e770-6a102ac733a4@gmail.com>
 <20170304105600.GS3220@valkosipuli.retiisi.org.uk>
Message-ID: <03c9b05c-d3ba-c890-f9fa-ad5e1a49430c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/04/2017 02:56 AM, Sakari Ailus wrote:
> Hi Steve,
>
> On Fri, Mar 03, 2017 at 02:43:51PM -0800, Steve Longerbeam wrote:
>>
>>
>> On 03/03/2017 03:45 AM, Sakari Ailus wrote:
>>> On Thu, Mar 02, 2017 at 03:07:21PM -0800, Steve Longerbeam wrote:
>>>>
>>>>
>>>> On 03/02/2017 07:53 AM, Sakari Ailus wrote:
>>>>> Hi Steve,
>>>>>
>>>>> On Wed, Feb 15, 2017 at 06:19:15PM -0800, Steve Longerbeam wrote:
>>>>>> Add a new FRAME_TIMEOUT event to signal that a video capture or
>>>>>> output device has timed out waiting for reception or transmit
>>>>>> completion of a video frame.
>>>>>>
>>>>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>>>>> ---
>>>>>> Documentation/media/uapi/v4l/vidioc-dqevent.rst | 5 +++++
>>>>>> Documentation/media/videodev2.h.rst.exceptions  | 1 +
>>>>>> include/uapi/linux/videodev2.h                  | 1 +
>>>>>> 3 files changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>>>>>> index 8d663a7..dd77d9b 100644
>>>>>> --- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>>>>>> +++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>>>>>> @@ -197,6 +197,11 @@ call.
>>>>>> 	the regions changes. This event has a struct
>>>>>> 	:c:type:`v4l2_event_motion_det`
>>>>>> 	associated with it.
>>>>>> +    * - ``V4L2_EVENT_FRAME_TIMEOUT``
>>>>>> +      - 7
>>>>>> +      - This event is triggered when the video capture or output device
>>>>>> +	has timed out waiting for the reception or transmit completion of
>>>>>> +	a frame of video.
>>>>>
>>>>> As you're adding a new interface, I suppose you have an implementation
>>>>> around. How do you determine what that timeout should be?
>>>>
>>>> The imx-media driver sets the timeout to 1 second, or 30 frame
>>>> periods at 30 fps.
>>>
>>> The frame rate is not necessarily constant during streaming. It may well
>>> change as a result of lighting conditions.
>>
>> I think you mean that would be a _temporary_ change in frame rate, but
>> yes I agree the data rate can temporarily fluctuate. Although I doubt
>> lighting conditions would cause a sensor to pause data transmission
>> for a full 1 second.
>
> Likely not, at least not in typical conditions. The exposure time is still
> quite specific to applications: it could be minutes if you take photos e.g.
> of the night sky.
>
> What I'm saying here is that any static value is likely not both reasonable
> and workable in all potential situations all the time. Still there are cases
> (as yours below) that may happen in relatively common cases on some hardware
> (more common than taking long exposure photos of the night sky with the said
> hardware :)).

I doubt night photography will ever be a use-case for i.MX. The most
common use-case for this driver will be used in automotive applications
such as rear-view or 360 degree view cameras.


>
>>
>>
>>> I wouldn't add an event for this:
>>> this is unreliable and 30 times the frame period is an arbitrary value
>>> anyway. No other drivers do this either.
>>
>> If no other drivers do this I don't mind removing it. It is really meant
>> to deal with the ADV718x CVBS decoder, which often simply stops sending
>> data on the BT.656 bus if there is an interruption in the input analog
>> signal. But I agree that user space could detect this timeout instead.
>> Unless I hear from someone else that they would like to keep this
>> feature I'll remove it in version 5.
>
> That's a bit of a special situation --- still there are alike conditions on
> existing hardware. You should return the buffers to the user with the ERROR
> flag set --- or return -EIO from VIDIOC_DQBUF, if the condition will
> persist:

On i.MX an EOF timeout is not recoverable without a stream restart, so
I decided to call vb2_queue_error() when the timeout occurs (instead
of sending an event). The user will then get -EIO when it attempts to
queue or dequeue further buffers.


>
> <URL:https://www.linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/vidioc-qbuf.html>
>
> Do you already obtain the frame rate from the image source (e.g. tuner,
> sensor, decoder) and multiply the frame time by some number in the current
> implementation?

No the timeout is a constant value, regardless of the source frame
rate. Should the timeout be based on a constant time, or based on a
constant # of frames? I really don't think it matters much, what matters
is that it be long enough to be reasonably sure no data is forthcoming,
for most use-cases.

Steve



> Not all sub-device drivers may implement g_frame_interval()
> so I'd disable the timeout in that case.
>
