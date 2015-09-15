From: emilio.lopez@collabora.co.uk (=?UTF-8?Q?Emilio_L=c3=b3pez?=)
Date: Tue, 15 Sep 2015 17:24:50 -0300
Subject: [PATCH v2 2/3] platform/chrome: Support reading/writing the vboot
 context
In-Reply-To: <CABxcv=mnCNQPtVBU4tPOWD237_-RojoW+RVLTj+F=3PHbUHfQQ@mail.gmail.com>
References: <1442234049-18637-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442234049-18637-3-git-send-email-emilio.lopez@collabora.co.uk>
 <CABxcv=m23sfK=jOCswirQRB1SbP70VnomKp6hhwFhRLHiabq4w@mail.gmail.com>
 <55F86E74.9010907@collabora.co.uk>
 <CABxcv=mnCNQPtVBU4tPOWD237_-RojoW+RVLTj+F=3PHbUHfQQ@mail.gmail.com>
Message-ID: <55F87E92.8000609@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 15/09/15 16:43, Javier Martinez Canillas wrote:
> Hello Emilio,
>
> On Tue, Sep 15, 2015 at 9:16 PM, Emilio L?pez
> <emilio.lopez@collabora.co.uk> wrote:
>
> [snip]
>
>>>>
>>>>    obj-$(CONFIG_CHROMEOS_LAPTOP)  += chromeos_laptop.o
>>>>    obj-$(CONFIG_CHROMEOS_PSTORE)  += chromeos_pstore.o
>>>> -cros_ec_devs-objs               := cros_ec_dev.o cros_ec_sysfs.o
>>>> cros_ec_lightbar.o
>>>> +cros_ec_devs-objs               := cros_ec_dev.o
>>>> +cros_ec_devs-objs               += cros_ec_lightbar.o
>>>> +cros_ec_devs-objs               += cros_ec_sysfs.o
>>>> +cros_ec_devs-objs               += cros_ec_vbc.o
>>>
>>>
>>> Why are you changing the Makefile? AFAIK += is usually used when the
>>> compilation is conditional based on a Kconfig symbol but since these
>>> are build unconditionally, I'll just keep it as foo := bar baz
>>
>>
>> As far as I'm aware, += is append[0]. It's used for stuff like
>> obj-$(CONFIG_CHROMEOS_LAPTOP)  += chromeos_laptop.o
>> because the left part will resolve to "obj-y" or similar, and you want to
>> add to it, not replace it. I only changed the Makefile here because the line
>> was growing too long, and I thought it looked neater this way; it shouldn't
>> cause any functional change apart from the intended one.
>>
>> [0] https://www.gnu.org/software/make/manual/html_node/Appending.html
>>
>
> Yes, I know how Kbuild works. What I tried to say is that you usually
> append based on a Kconfig symbol. In fact even you are mentioning such
> an example.
> So appending unconditionally like you are doing makes the Makefile
> harder to read IMHO. If the line grows to long you can use a backlash
> (\) char to split the line.

I guess it just boils down to personal preference; I don't feel that 
strongly about it, I'll change it in v3

(...)
>>>> +       struct device *dev = container_of(kobj, struct device, kobj);
>>>> +       struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
>>>> +                                             class_dev);
>>>> +       struct cros_ec_device *ecdev = ec->ec_dev;
>>>> +       struct ec_params_vbnvcontext *params;
>>>> +       struct cros_ec_command *msg;
>>>> +       int err;
>>>> +       const size_t para_sz = sizeof(struct ec_params_vbnvcontext);
>>>> +       const size_t resp_sz = sizeof(struct ec_response_vbnvcontext);
>>>> +       const size_t payload = max(para_sz, resp_sz);
>>>> +
>>>> +       msg = kmalloc(sizeof(*msg) + payload, GFP_KERNEL);
>>>> +       if (!msg)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       params = (struct ec_params_vbnvcontext *)msg->data;
>>>> +       params->op = EC_VBNV_CONTEXT_OP_READ;
>>>> +
>>>> +       msg->version = EC_VER_VBNV_CONTEXT;
>>>> +       msg->command = EC_CMD_VBNV_CONTEXT;
>>>> +       msg->outsize = sizeof(params->op);
>>>
>>>
>>> Shouldn't this be para_sz ? Since you are sending to the EC the whole
>>> struct ec_params_vbnvcontext and not only the op field.
>>>
>>> Or if the EC only expects to get the u32 op field, then I think your
>>> max payload calculation is not correct.
>>
>>
>> The params struct is the same for both read and write ops, so it has the op
>
> That's not true, struct ec_response_vbnvcontext has only the block
> field while struct ec_param_vbnvcontext has both the op and block
> fields.

The former is a response struct, not a params struct.

>> flag and a buffer for the write op. During the read op I believe there's no
>> need to send this potentially-garbage-filled buffer to the EC, so outsize is
>> set accordingly here.
>
> Yes, I agree with you but then as I mentioned I think your payload
> calculation is wrong since you want instead max(sizeof(struct
> ec_response_vbnvcontext), sizeof(param->op)). Otherwise you are
> allocating 4 bytes more than needed.

Yeah, I can see that. If I do that though, max(...) would be less than 
the size of the full params struct, and casting data to it could lead to 
subtle bugs in the future. I can change it and add a comment mentioning 
this, deal?

(...)

> with the needed changes, feel free to add my:
>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Ok, thanks!

Emilio
