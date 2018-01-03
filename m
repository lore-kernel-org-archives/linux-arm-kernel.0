From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:26:27 +0000
Subject: [RESEND PATCH v2 03/15] ASoC: qcom: qdsp6: Add common qdsp6
 helper functions
In-Reply-To: <20180102001907.GL478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-4-srinivas.kandagatla@linaro.org>
 <20180102001907.GL478@tuxbook>
Message-ID: <48c31cb9-b4b6-2f22-6e07-ee1e47b9ca88@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review comments,

On 02/01/18 00:19, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
>> +static inline int q6dsp_map_channels(u8 *ch_map, int ch)
>> +{
>> +	memset(ch_map, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
> 
> This implies that ch_map is always an array of
> PCM_FORMAT_MAX_NUM_CHANNEL elements. As such it would be better to
> express this in the prototype; i.e u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL]
> 
Yep, Will do that.
>> +
>> +	if (ch == 1) {
> 
> This is a switch statement.
> 
Yes, makes more sense.

>> +		ch_map[0] = PCM_CHANNEL_FC;
>> +	} else if (ch == 2) {
> [..]
>> +struct adsp_err_code {
>> +	int		lnx_err_code;
> 
> Indentation, and these could be given more succinct names.
> 
>> +	char	*adsp_err_str;
>> +};
>> +
>> +static struct adsp_err_code adsp_err_code_info[ADSP_ERR_MAX+1] = {
>> +	{ 0, ADSP_EOK_STR},
>> +	{ -ENOTRECOVERABLE, ADSP_EFAILED_STR},
>> +	{ -EINVAL, ADSP_EBADPARAM_STR},
>> +	{ -ENOSYS, ADSP_EUNSUPPORTED_STR},
>> +	{ -ENOPROTOOPT, ADSP_EVERSION_STR},
>> +	{ -ENOTRECOVERABLE, ADSP_EUNEXPECTED_STR},
>> +	{ -ENOTRECOVERABLE, ADSP_EPANIC_STR},
>> +	{ -ENOSPC, ADSP_ENORESOURCE_STR},
>> +	{ -EBADR, ADSP_EHANDLE_STR},
>> +	{ -EALREADY, ADSP_EALREADY_STR},
>> +	{ -EPERM, ADSP_ENOTREADY_STR},
>> +	{ -EINPROGRESS, ADSP_EPENDING_STR},
>> +	{ -EBUSY, ADSP_EBUSY_STR},
>> +	{ -ECANCELED, ADSP_EABORTED_STR},
>> +	{ -EAGAIN, ADSP_EPREEMPTED_STR},
>> +	{ -EAGAIN, ADSP_ECONTINUE_STR},
>> +	{ -EAGAIN, ADSP_EIMMEDIATE_STR},
>> +	{ -EAGAIN, ADSP_ENOTIMPL_STR},
>> +	{ -ENODATA, ADSP_ENEEDMORE_STR},
>> +	{ -EADV, ADSP_ERR_MAX_STR},
> 
> This, element 0x13, is not listed among the defined errors. Is this a
> placeholder?
> 
> How about making this even more descriptive by using the format
> 
> [ADSP_EBADPARAM] = { -EINVAL, ADSP_EBADPARAM_STR },
> 
> That way the mapping table is self-describing.
> 
> And you can use ARRAY_SIZE() instead of specifying the fixed size of
> ADSP_ERR_MAX + 1...
> 
Will give that a try!
>> +	{ -ENOMEM, ADSP_ENOMEMORY_STR},
>> +	{ -ENODEV, ADSP_ENOTEXIST_STR},
>> +	{ -EADV, ADSP_ERR_MAX_STR},
> 
> "Advertise error"?
No, downstream seems to define any unexpected error as -EADV, am not 
sure if this correct, probably we should change this to be more sensible 
one.

> 
>> +};
>> +
>> +static inline int adsp_err_get_lnx_err_code(u32 adsp_error)
> 
> Can this be made internal to some c-file? So that any third party deals
> only with linux error codes?
> 
> 
> How about renaming this q6dsp_errno()?
> 
yep will do that.

>> +{
>> +	if (adsp_error > ADSP_ERR_MAX)
>> +		return adsp_err_code_info[ADSP_ERR_MAX].lnx_err_code;
>> +	else
>> +		return adsp_err_code_info[adsp_error].lnx_err_code;
> 
> I think this would look better if you assign a local variable and have a
> single return. And just hard code the "invalid error code" errno, rather
> than looking up ADSP_ERR_MAX in the list.
> 
>> +}
>> +
>> +static inline char *adsp_err_get_err_str(u32 adsp_error)
> 
> q6dsp_strerror(), to match strerror(3)?
yep!

> 
>> +{
>> +	if (adsp_error > ADSP_ERR_MAX)
>> +		return adsp_err_code_info[ADSP_ERR_MAX].adsp_err_str;
>> +	else
>> +		return adsp_err_code_info[adsp_error].adsp_err_str;
> 
> And I do think that, as with strerror, this should return a human
> readable error, not the stringified define.
okay!
> 
>> +}
> 
> 
> I'm puzzled to why these helper functions lives in a header file, at
> least some aspects of this would better be hidden...
Will try to improve on this in next version.

> 
> Regards,
> Bjorn
> 
