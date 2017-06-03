From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sat, 3 Jun 2017 11:02:21 -0700
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <20170530065632.GK29527@valkosipuli.retiisi.org.uk>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170529155511.GI29527@valkosipuli.retiisi.org.uk>
 <c50c3c5f-71cf-fa73-f5a8-a4b5f59a87dc@gmail.com>
 <20170530065632.GK29527@valkosipuli.retiisi.org.uk>
Message-ID: <ab04379b-d005-1251-343b-5e490ee6e72d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,


On 05/29/2017 11:56 PM, Sakari Ailus wrote:
> Hi Steve,
> 
> On Mon, May 29, 2017 at 02:50:34PM -0700, Steve Longerbeam wrote:
>>> <snip>
>>>
>>>> +
>>>> +static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
>>>> +{
>>>> +	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
>>>> +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
>>>> +	int ret = 0;
>>>> +
>>>> +	mutex_lock(&sensor->lock);
>>> Could you use the same lock for the controls as you use for the rest? Just
>>> setting handler->lock after handler init does the trick.
>>
>> Can you please rephrase, I don't follow. "same lock for the controls as
>> you use for the rest" - there's only one device lock owned by this driver
>> and I am already using that same lock.
> 
> There's another in the control handler. You could use your own lock for the
> control handler as well.

I still don't understand.

> 
>>
>>
>>> <snip>
>>>> +
>>>> +static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>>>> +{
>>>> +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
>>>> +	int ret = 0;
>>>> +
>>>> +	mutex_lock(&sensor->lock);
>>>> +
>>>> +#if defined(CONFIG_MEDIA_CONTROLLER)
>>>> +	if (sd->entity.stream_count > 1)
>>> The entity stream_count isn't connected to the number of times s_stream(sd,
>>> true) is called. Please remove the check.
>>
>> It's incremented by media_pipeline_start(), even if the entity is already
>> a member of the given pipeline.
>>
>> I added this check because in imx-media, the ov5640 can be streaming
>> concurrently to multiple video capture devices, and each capture device
>> calls
>> media_pipeline_start() at stream on, which increments the entity stream
>> count.
>>
>> So if one capture device issues a stream off while others are still
>> streaming,
>> ov5640 should remain at stream on. So the entity stream count is being
>> used as a streaming usage counter. Is there a better way to do this? Should
>> I use a private stream use counter instead?
> 
> Different drivers may use media_pipeline_start() in different ways. Stream
> control shouldn't depend on that count. This could cause issues in using the
> driver with other ISP / receiver drivers.
> 
> I think it should be enough to move the check to the imx driver in this
> case.


I will remove this check.


>>>> +
>>>> +static int ov5640_remove(struct i2c_client *client)
>>>> +{
>>>> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>>>> +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
>>>> +
>>>> +	regulator_bulk_disable(OV5640_NUM_SUPPLIES, sensor->supplies);
>>> Ditto.
>>
>> I don't understand. regulator_bulk_disable() is still needed, am I missing
>> something?
> 
> You still need to enable it first. I don't see that being done in probe. As
> the driver implements the s_power() op, I don't see a need for powering the
> device on at probe time (and conversely off at remove time).

Oh you're right, it must have been left over from a previous revision
I guess. Yes, regulator_bulk_enable|disable() is only called in
ov5640_set_power(). I'll remove regulator_bulk_disable() from
probe/remove.

Steve
