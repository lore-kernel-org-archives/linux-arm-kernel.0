From: Songjun.Wu@microchip.com (Wu, Songjun)
Date: Tue, 10 Jan 2017 15:52:25 +0800
Subject: [PATCH] [media] atmel-isc: add the isc pipeline function
In-Reply-To: <7f13689c-8944-1143-2117-6b8884b65214@xs4all.nl>
References: <20161223092420.30466-1-songjun.wu@microchip.com>
 <7f13689c-8944-1143-2117-6b8884b65214@xs4all.nl>
Message-ID: <b97a4863-d9b1-bb77-0f8f-1ba9d334093b@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Thank you for your comments.

On 1/9/2017 20:10, Hans Verkuil wrote:
>> +
>> +static int isc_s_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +	struct isc_device *isc = container_of(ctrl->handler,
>> +					     struct isc_device, ctrls.handler);
>> +	struct isc_ctrls *ctrls = &isc->ctrls;
>> +
>> +	switch (ctrl->id) {
>> +	case V4L2_CID_BRIGHTNESS:
>> +		ctrls->brightness = ctrl->val & ISC_CBC_BRIGHT_MASK;
>> +		break;
>> +	case V4L2_CID_CONTRAST:
>> +		ctrls->contrast = (ctrl->val << 8) & ISC_CBC_CONTRAST_MASK;
> As I understand it only bits 11-8 contain the contrast in the register?
>
> Wouldn't '(ctrl->val & ISC_CBC_CONTRAST_MASK) << 8' be more readable?
>
> Either that or the mask should be 0xf00, not 0xfff.
>
Actually, bits 12-0 contain the contrast, it is a fixed-point 
number(signed 12 bits 1:3:8), ranges from -2048 to 2047. Then only the 
integral part is output to be adjusted.
Maybe both the fractional part and integral part should be output.
Then the contrast control should be written as below.

v4l2_ctrl_new_std(hdl, ops, V4L2_CID_CONTRAST, -2048, 2047, 1, 1);

Do you have any good suggestion?

>> +		break;
>> +	case V4L2_CID_GAMMA:
>> +		ctrls->gamma_index = ctrl->val;
>> +		break;
>> +	case V4L2_CID_AUTO_WHITE_BALANCE:
>> +		ctrls->awb = ctrl->val;
>> +		if (ctrls->hist_stat != HIST_ENABLED) {
>> +			ctrls->r_gain = 0x1 << 9;
>> +			ctrls->b_gain = 0x1 << 9;
>> +		}
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct v4l2_ctrl_ops isc_ctrl_ops = {
>> +	.s_ctrl	= isc_s_ctrl,
>> +};
>> +
>> +static int isc_ctrl_init(struct isc_device *isc)
>> +{
>> +	const struct v4l2_ctrl_ops *ops = &isc_ctrl_ops;
>> +	struct isc_ctrls *ctrls = &isc->ctrls;
>> +	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
>> +	int ret;
>> +
>> +	ctrls->hist_stat = HIST_INIT;
>> +
>> +	ret = v4l2_ctrl_handler_init(hdl, 4);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_BRIGHTNESS, -1024, 1023, 1, 0);
>> +	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_CONTRAST, -8, 7, 1, 1);
>> +	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAMMA, 0, GAMMA_MAX - 1, 1, 2);
> Why is the maximum GAMMA_MAX - 1? I would assume that GAMMA_MAX is the maximum.
>
> Looks weird. It's either a bug or it needs a comment.
>
>> +	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTO_WHITE_BALANCE, 0, 1, 1, 1);
>> +
>> +	v4l2_ctrl_handler_setup(hdl);
>> +
>> +	return 0;
>> +}
>> +
>> +
>>  static int isc_async_bound(struct v4l2_async_notifier *notifier,
>>  			    struct v4l2_subdev *subdev,
>>  			    struct v4l2_async_subdev *asd)
>> @@ -1047,10 +1435,11 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
>>  {
>>  	struct isc_device *isc = container_of(notifier->v4l2_dev,
>>  					      struct isc_device, v4l2_dev);
>> -
>> +	cancel_work_sync(&isc->awb_work);
>>  	video_unregister_device(&isc->video_dev);
>>  	if (isc->current_subdev->config)
>>  		v4l2_subdev_free_pad_config(isc->current_subdev->config);
>> +	v4l2_ctrl_handler_free(&isc->ctrls.handler);
>>  }
>>
>>  static struct isc_format *find_format_by_code(unsigned int code, int *index)
>> @@ -1081,7 +1470,9 @@ static int isc_formats_init(struct isc_device *isc)
>>
>>  	fmt = &isc_formats[0];
>>  	for (i = 0; i < ARRAY_SIZE(isc_formats); i++) {
>> -		fmt->support = false;
>> +		fmt->isc_support = false;
>> +		fmt->sd_support = false;
>> +
>>  		fmt++;
>>  	}
>>
>> @@ -1092,8 +1483,22 @@ static int isc_formats_init(struct isc_device *isc)
>>  		if (!fmt)
>>  			continue;
>>
>> -		fmt->support = true;
>> -		num_fmts++;
>> +		fmt->sd_support = true;
>> +
>> +		if (i <= RAW_FMT_INDEX_END) {
>> +			for (j = ISC_FMT_INDEX_START;
>> +			     j <= ISC_FMT_INDEX_END; j++)
> Just merge these two lines, easier to read.
>
Do you mean merge these two lines like 'for (j = ISC_FMT_INDEX_START; j 
<= ISC_FMT_INDEX_END; j++)', but the line is over 80 characters

>> +				isc_formats[j].isc_support = true;
>> +
>> +			isc->raw_fmt = fmt;
>> +		}
