From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 23 Jan 2017 18:15:56 -0800
Subject: [PATCH v3 20/24] media: imx: Add Camera Interface subdev driver
In-Reply-To: <b7456d40-040d-41b7-45bc-ef6709ab7933@xs4all.nl>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-21-git-send-email-steve_longerbeam@mentor.com>
 <b7456d40-040d-41b7-45bc-ef6709ab7933@xs4all.nl>
Message-ID: <30a80568-6da0-2502-3346-a4b900c7f1ce@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/20/2017 06:38 AM, Hans Verkuil wrote:
> On 01/07/2017 03:11 AM, Steve Longerbeam wrote:
>> +static int vidioc_querycap(struct file *file, void *fh,
>> +			   struct v4l2_capability *cap)
>> +{
>> +	strncpy(cap->driver, "imx-media-camif", sizeof(cap->driver) - 1);
>> +	strncpy(cap->card, "imx-media-camif", sizeof(cap->card) - 1);
>> +	cap->bus_info[0] = 0;
> Should be set to something like 'platform:imx-media-camif'. v4l2-compliance should
> complain about this.

Right, I've fixed this already as part of v4l2-compliance testing.

>
>> +	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
>> +	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
> Set device_caps in struct video_device, then drop these two lines since
> the core will set these up based on the device_caps field in struct video_device.

done.

>
>> +
>> +static int camif_enum_input(struct file *file, void *fh,
>> +			    struct v4l2_input *input)
>> +{
>> +	struct camif_priv *priv = video_drvdata(file);
>> +	struct imx_media_subdev *sensor;
>> +	int index = input->index;
>> +
>> +	sensor = imx_media_find_sensor(priv->md, &priv->sd.entity);
>> +	if (IS_ERR(sensor)) {
>> +		v4l2_err(&priv->sd, "no sensor attached\n");
>> +		return PTR_ERR(sensor);
>> +	}
>> +
>> +	if (index >= sensor->input.num)
>> +		return -EINVAL;
>> +
>> +	input->type = V4L2_INPUT_TYPE_CAMERA;
>> +	strncpy(input->name, sensor->input.name[index], sizeof(input->name));
>> +
>> +	if (index == priv->current_input) {
>> +		v4l2_subdev_call(sensor->sd, video, g_input_status,
>> +				 &input->status);
>> +		v4l2_subdev_call(sensor->sd, video, querystd, &input->std);
> Wrong op, use g_tvnorms instead.

done.


Steve
