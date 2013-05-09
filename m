From: s-anna@ti.com (Suman Anna)
Date: Thu, 9 May 2013 18:43:59 -0500
Subject: [PATCHv2 2/4] mailbox: Introduce a new common API
In-Reply-To: <CAJe_Zhffm9FOk83dAdX194gN3r5JnG78sdcWNv6WnWCsTF3YuA@mail.gmail.com>
References: <1367824946-6160-1-git-send-email-jaswinder.singh@linaro.org>
 <1367825046-6229-1-git-send-email-jaswinder.singh@linaro.org>
 <518BCF4B.1060504@ti.com>
 <CAJe_Zhd=FDV3YP=XR8Yay1iy_geAt3tqj+diUxrVkd2BFSfb-g@mail.gmail.com>
 <518BD197.2030502@ti.com>
 <CABb+yY2CnO5RiQNdcB_L5ZiGi829Ys0ODH2UmhtZxj=aJo3ioQ@mail.gmail.com>
 <518BE566.5090504@ti.com>
 <CAJe_Zhffm9FOk83dAdX194gN3r5JnG78sdcWNv6WnWCsTF3YuA@mail.gmail.com>
Message-ID: <518C34BF.7080408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi,

>>>
>>> Perhaps we should change the following
>>>
>>>    void ipc_link_txdone(struct ipc_link *link, enum xfer_result r)
>>> to
>>>    void ipc_link_txdone(struct ipc_link *link, enum xfer_result r, void *data)
>>>
>>> So that the API could pass that onto clients ?
>>
>> That's if the controller needs to pass some data back to client. I am
>> fine with that as well,
> No, I misunderstood you wanted request_token_t to be replaced with the
> pointer of request that was executed.
> 
>> but I am talking mainly about providing a client
>> user data ptr back to it during callbacks.
>>
>> struct ipc_client {
>>         char *chan_name;
>> +       void *cl_data; /* store it to ipc_chan as well */
>> -       void (*rxcb)(void *data);
>> -       void (*txcb)(request_token_t t, enum xfer_result r);
>> +       void (*rxcb)(void *cl_data, void *data);
>> +       void (*txcb)(request_token_t t, enum xfer_result r, void *cl_data);
>>         ...
>> }
>>
>> I am obviously interested in the rxcb. The controller implementations do
>> not see the cl_data.
>>
> OK I see what you mean. However the API storing and passing back
> ad-hoc data to clients doesn't seem very neat.
> 
> Such purposes are usually served by :
> 
> - void (*rxcb)(void *data);
> + void (*rxcb)(struct ipc_client *cl, void *data);  /* client for
> which data was received */
> 
> - void (*txcb)(request_token_t t, enum xfer_result r);
> + void (*txcb)(struct ipc_client *cl, request_token_t t, enum
> xfer_result r); /* client whose data was sent */
> 
> You could then get relevant omap_rproc using container_of() on 'cl',
> in rxcb() and txcb().

The reason that I didn't suggest that way is because we do not use
ipc_client for any runtime API, and we would have to store the returned
handle anyway. I see ipc_client simply as a ipc_channel_request_info
structure, a one-time usage perspective. I made the suggestion as it
seemed in line if you had a xxx_register_callback API wherein you would
use a void *context if you want something back.

> 
> Apart from this, in txcb, perhaps we should drop request_token_t in
> favor of the request's pointer (void *data) that was last executed.
> That should make things easier for clients.

Yes, that would be nice too.

regards
Suman
