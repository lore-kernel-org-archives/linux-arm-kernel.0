From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 4 Apr 2017 14:58:08 +0200
Subject: [PATCH 1/2] [media] cec: Move capability check inside #if
In-Reply-To: <20170404125409.ay5yszwdkdxb6nvx@dell>
References: <20170404123219.22040-1-lee.jones@linaro.org>
 <4920d83a-8983-36cc-936d-9e0989e833ce@xs4all.nl>
 <20170404125409.ay5yszwdkdxb6nvx@dell>
Message-ID: <d4160e53-3410-5eb9-8378-932ec0aef463@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2017 02:54 PM, Lee Jones wrote:
> On Tue, 04 Apr 2017, Hans Verkuil wrote:
> 
>> On 04/04/2017 02:32 PM, Lee Jones wrote:
>>> If CONFIG_RC_CORE is not enabled then none of the RC code will be
>>> executed anyway, so we're placing the capability check inside the
>>>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  drivers/media/cec/cec-core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/cec/cec-core.c b/drivers/media/cec/cec-core.c
>>> index 37217e2..06a312c 100644
>>> --- a/drivers/media/cec/cec-core.c
>>> +++ b/drivers/media/cec/cec-core.c
>>> @@ -234,10 +234,10 @@ struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
>>>  		return ERR_PTR(res);
>>>  	}
>>>  
>>> +#if IS_REACHABLE(CONFIG_RC_CORE)
>>>  	if (!(caps & CEC_CAP_RC))
>>>  		return adap;
>>>  
>>> -#if IS_REACHABLE(CONFIG_RC_CORE)
>>>  	/* Prepare the RC input device */
>>>  	adap->rc = rc_allocate_device(RC_DRIVER_SCANCODE);
>>>  	if (!adap->rc) {
>>>
>>
>> Not true, there is an #else further down.
> 
> I saw the #else.  It's inert code that becomes function-less.

No, it isn't. It clears the CAP_RC bit so it isn't returned in the CEC_ADAP_G_CAPS ioctl.
Drivers set this cap bit if they want RC support (they typically want it), but if the
config option isn't there then the capability should be removed.

Regards,

	Hans

> 
>> That said, this code is clearly a bit confusing.
>>
>> It would be better if at the beginning of the function we'd have this:
>>
>> #if !IS_REACHABLE(CONFIG_RC_CORE)
>> 	caps &= ~CEC_CAP_RC;
>> #endif
>>
>> and then drop the #else bit and (as you do in this patch) move the #if up.
>>
>> Can you make a new patch for this?
> 
> Sure.
> 
