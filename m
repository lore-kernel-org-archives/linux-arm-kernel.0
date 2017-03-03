From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 2 Mar 2017 16:46:20 -0800
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <141eb012-eb24-7558-2bc5-1fe82f6b7b4b@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <141eb012-eb24-7558-2bc5-1fe82f6b7b4b@gmail.com>
Message-ID: <b4221709-5965-ac9a-d73a-ffe61c9bed9f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/02/2017 03:48 PM, Steve Longerbeam wrote:
>
>
> On 03/02/2017 08:02 AM, Sakari Ailus wrote:
>> Hi Steve,
>>
>> On Wed, Feb 15, 2017 at 06:19:16PM -0800, Steve Longerbeam wrote:
>>> v4l2_pipeline_inherit_controls() will add the v4l2 controls from
>>> all subdev entities in a pipeline to a given video device.
>>>
>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>> ---
>>>  drivers/media/v4l2-core/v4l2-mc.c | 48
>>> +++++++++++++++++++++++++++++++++++++++
>>>  include/media/v4l2-mc.h           | 25 ++++++++++++++++++++
>>>  2 files changed, 73 insertions(+)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-mc.c
>>> b/drivers/media/v4l2-core/v4l2-mc.c
>>> index 303980b..09d4d97 100644
>>> --- a/drivers/media/v4l2-core/v4l2-mc.c
>>> +++ b/drivers/media/v4l2-core/v4l2-mc.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/usb.h>
>>>  #include <media/media-device.h>
>>>  #include <media/media-entity.h>
>>> +#include <media/v4l2-ctrls.h>
>>>  #include <media/v4l2-fh.h>
>>>  #include <media/v4l2-mc.h>
>>>  #include <media/v4l2-subdev.h>
>>> @@ -238,6 +239,53 @@ int v4l_vb2q_enable_media_source(struct
>>> vb2_queue *q)
>>>  }
>>>  EXPORT_SYMBOL_GPL(v4l_vb2q_enable_media_source);
>>>
>>> +int __v4l2_pipeline_inherit_controls(struct video_device *vfd,
>>> +                     struct media_entity *start_entity)
>>
>> I have a few concerns / questions:
>>
>> - What's the purpose of this patch? Why not to access the sub-device node
>>   directly?
>
>
> I don't really understand what you are trying to say. That's exactly
> what this function is doing, accessing every subdevice in a pipeline
> directly, in one convenient function call.
>
>
>>
>> - This implementation is only workable as long as you do not modify the
>>   pipeline. Once you disable a link along the pipeline, a device where
>> the
>>   control was inherited from may no longer be a part of the pipeline.
>
> That's correct. It's up to the media driver to clear the video device's
> inherited controls whenever the pipeline is modified, and then call this
> function again if need be.

And here is where I need to eat my words :). I'm not actually
clearing the inherited controls if an upstream link from the
device node link is modified after the whole pipeline has been
configured. If the user does that the controls can become
invalid. Need to fix that by clearing device node controls in
the link_notify callback.

Steve


>
> In imx-media driver, the function is called in link_setup when the link
> from a source pad that is attached to a capture video node is enabled.
> This is the last link that must be made to define the pipeline, so it
> is at this time that a complete list of subdevice controls can be
> gathered by walking the pipeline.
>
