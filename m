From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 2 Nov 2017 11:49:17 +0000
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <CABb+yY3Gd3u-_xNPSqJT_+yVHGMs7pgt3Bc4faGvN2KwOsm6_w@mail.gmail.com>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
 <CABb+yY16-B9vReRjLopV1RsyB8a=c5X9XaomtTj44520XrDdmA@mail.gmail.com>
 <4268c9d9-dc1e-0bd7-3fac-790c2d42b54b@arm.com>
 <CABb+yY3Gd3u-_xNPSqJT_+yVHGMs7pgt3Bc4faGvN2KwOsm6_w@mail.gmail.com>
Message-ID: <5af1c28f-50db-9f5a-2c60-71cacab4a3ab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/11/17 11:26, Jassi Brar wrote:
> On Thu, Nov 2, 2017 at 4:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

>>
>> No that non-zero value is not client specific, it's entirely controller
>> specific.
>>
> ??
> For example BCM2835 has such a controller. Have a look at
> bcm2835_send_data() and let me know what is that controller specific
> value.
>

You can keep finding one or the other platform that has a deviation.
Come on there are generic infrastructure support in many subsystem that
are just used in one or two platforms. I hope you agree for this
enhancement to the mailbox framework as it's more commonly used mode.
I am not saying this patch is final, but I just want an agreement to add
such a support.

[...]

>>> 1) Where does the  "whatever_value_to_trigger_signal"  come from?
>>
>> Controller specific.
>>
>>> That has to come from client.
>>
>> No.
>>
> Again, let me know what does the controller expect 'val' to be
> 
>   writel(val, MAILBOX_A2B_CMD(chans->idx))
> 

It depends on the controller. Whatever value that can generate a signal
to remote.

> 
> Your entire post is based on your assertion that the controller
> expects a particular non-zero value to trigger a signal, which is
> wrong.

Why do you think that ? There are lots of example in the mailbox today.
Please have a look at few example which don't use data passed from the
client:

1. pcc_send_data (drivers/mailbox/pcc.c)
2. sti_mbox_send_data (drivers/mailbox/mailbox-sti.c)
3. qcom_apcs_ipc_send_data (drivers/mailbox/qcom-apcs-ipc-mailbox.c)
4. tegra_hsp_doorbell_send_data (drivers/mailbox/tegra-hsp.c)

And SCMI fits the above case.

Also you keep saying I am making this change to get SCMI with ARM MHU.
Honestly I don't care much about that, I need better support from
mailbox framework if possible for any platforms running SCMI. So please
stop assuming my changes are motivated by that. SCMI is designed to
solve more generic consolidation issues, so I am more focused on that
than getting it run on some development platform I have with ARM MHU.
Believe me that's least of my concern.

-- 
Regards,
Sudeep
