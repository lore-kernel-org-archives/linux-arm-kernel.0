From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 16 Sep 2015 00:26:09 +0200
Subject: [PATCH v2 2/3] platform/chrome: Support reading/writing the vboot
 context
In-Reply-To: <55F87E92.8000609@collabora.co.uk>
References: <1442234049-18637-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442234049-18637-3-git-send-email-emilio.lopez@collabora.co.uk>
 <CABxcv=m23sfK=jOCswirQRB1SbP70VnomKp6hhwFhRLHiabq4w@mail.gmail.com>
 <55F86E74.9010907@collabora.co.uk>
 <CABxcv=mnCNQPtVBU4tPOWD237_-RojoW+RVLTj+F=3PHbUHfQQ@mail.gmail.com>
 <55F87E92.8000609@collabora.co.uk>
Message-ID: <CABxcv=kqigrfX3ruOUW=wJU1cAs1DmN41AmrUjYRB5f0phhy7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Emilio,

On Tue, Sep 15, 2015 at 10:24 PM, Emilio L?pez
<emilio.lopez@collabora.co.uk> wrote:

[snip]

>>>>> +
>>>>> +       params = (struct ec_params_vbnvcontext *)msg->data;
>>>>> +       params->op = EC_VBNV_CONTEXT_OP_READ;
>>>>> +
>>>>> +       msg->version = EC_VER_VBNV_CONTEXT;
>>>>> +       msg->command = EC_CMD_VBNV_CONTEXT;
>>>>> +       msg->outsize = sizeof(params->op);
>>>>
>>>>
>>>>
>>>> Shouldn't this be para_sz ? Since you are sending to the EC the whole
>>>> struct ec_params_vbnvcontext and not only the op field.
>>>>
>>>> Or if the EC only expects to get the u32 op field, then I think your
>>>> max payload calculation is not correct.
>>>
>>>
>>>
>>> The params struct is the same for both read and write ops, so it has the
>>> op
>>
>>
>> That's not true, struct ec_response_vbnvcontext has only the block
>> field while struct ec_param_vbnvcontext has both the op and block
>> fields.
>
>
> The former is a response struct, not a params struct.
>

I misread read/write as request/response in the previous email, sorry
about that.

>>> flag and a buffer for the write op. During the read op I believe there's
>>> no
>>> need to send this potentially-garbage-filled buffer to the EC, so outsize
>>> is
>>> set accordingly here.
>>
>>
>> Yes, I agree with you but then as I mentioned I think your payload
>> calculation is wrong since you want instead max(sizeof(struct
>> ec_response_vbnvcontext), sizeof(param->op)). Otherwise you are
>> allocating 4 bytes more than needed.
>
>
> Yeah, I can see that. If I do that though, max(...) would be less than the
> size of the full params struct, and casting data to it could lead to subtle
> bugs in the future. I can change it and add a comment mentioning this, deal?
>

But by setting outsize to sizeof(params->op) you are allocating less
than the params struct anyways in the transport driver. Take a look
for example to cros_ec_cmd_xfer_i2c():

http://lxr.free-electrons.com/source/drivers/mfd/cros_ec_i2c.c#L187

But I don't have a strong opinion on this tbh, I was just pointing out
that it's strange that max(insize,outsize) does not match
msg->{insize,outsize}.

> (...)
>
>> with the needed changes, feel free to add my:
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
>
> Ok, thanks!
>
> Emilio

Best regards,
Javier
