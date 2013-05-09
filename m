From: s-anna@ti.com (Suman Anna)
Date: Thu, 9 May 2013 11:40:55 -0500
Subject: [PATCHv2 2/4] mailbox: Introduce a new common API
In-Reply-To: <CAJe_Zhd=FDV3YP=XR8Yay1iy_geAt3tqj+diUxrVkd2BFSfb-g@mail.gmail.com>
References: <1367824946-6160-1-git-send-email-jaswinder.singh@linaro.org>
 <1367825046-6229-1-git-send-email-jaswinder.singh@linaro.org>
 <518BCF4B.1060504@ti.com>
 <CAJe_Zhd=FDV3YP=XR8Yay1iy_geAt3tqj+diUxrVkd2BFSfb-g@mail.gmail.com>
Message-ID: <518BD197.2030502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2013 11:41 AM, Jassi Brar wrote:
> On 9 May 2013 22:01, Suman Anna <s-anna@ti.com> wrote:
>> Hi Jassi,
>>
>> On 05/06/2013 02:24 AM, Jassi Brar wrote:
>>> +++ b/include/linux/mailbox_client.h
>>> @@ -0,0 +1,85 @@
>>> +/*
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#ifndef __MAILBOX_CLIENT_H
>>> +#define __MAILBOX_CLIENT_H
>>> +
>>> +#include <linux/mailbox.h>
>>> +
>>> +/**
>>> + * struct ipc_client - User of a mailbox
>>> + * @chan_name: the "controller:channel" this client wants
>>> + * @rxcb: atomic callback to provide client the data received
>>> + * @txcb: atomic callback to tell client of data transmission
>>> + * @tx_block: if the ipc_send_message should block until data is transmitted
>>> + * @tx_tout: Max block period in ms before TX is assumed failure
>>> + * @knows_txdone: if the client could run the TX state machine. Usually if
>>> + *    the client receives some ACK packet for transmission. Unused if the
>>> + *    controller already has TX_Done/RTR IRQ.
>>> + * @cntlr_data: Optional controller specific parameters during channel request
>>> + */
>>> +struct ipc_client {
>>> +     char *chan_name;
>>> +     void (*rxcb)(void *data);
>>> +     void (*txcb)(request_token_t t, enum xfer_result r);
>>
>> We have to introduce a callback data pointer, so that the calling
>> clients can retrieve a context object variable or some other useful
>> data within the callback functions, just like most normal callback
>> function declarations and registrations do.
>>
> I meant the request_token_t for the purpose. That's how we do with DMAEngine.

I faced this issue on the rxcb while adopting the
omap_rproc_mbox_callback. omap_remoteproc is a common driver for all the
OMAP co-processors and there can be multiple instances, providing the
same set of features. Look at the code in
drivers/remoteproc/omap_remoteproc.c and you will get the idea. But in
general, the users registering callback functions would prefer to get
some context pointer back.

regards
Suman
