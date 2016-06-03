From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 3 Jun 2016 18:41:52 +0530
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <57516774.5080008@gmail.com>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
 <574C5CBF.7060002@gmail.com>
 <1464683762.14604.59.camel@mtksdaap41> <574DEE40.9010008@gmail.com>
 <1464775020.11122.40.camel@mtksdaap41> <574FF264.7050209@gmail.com>
 <1464934356.15175.31.camel@mtksdaap41> <57516774.5080008@gmail.com>
Message-ID: <CABb+yY2aOncqM-fOiq_ZBink0Fth6Drd30ZMe3-bXNkodW2dVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 4:48 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 03/06/16 08:12, Horng-Shyang Liao wrote:
>> On Thu, 2016-06-02 at 10:46 +0200, Matthias Brugger wrote:

>>> I keep thinking about how to get rid of the two data structures,
>>> task_busy_list and the task_release_wq. We need the latter for the only
>>> sake of getting a timeout.
>>>
>>> Did you have a look on how the mailbox framework handles this?
>>> By the way, what is the reason to not implement the whole driver as a
>>> mailbox controller? For me, this driver looks like a good fit.
>>
>>
>> CMDQ needs to encode commands for GCE hardware. We think this behavior
>> should be put in CMDQ driver, and client just call CMDQ functions.
>> Therefore, if we want to use mailbox framework, cmdq_rec must be
>> mailbox client, and the others must be mailbox controller.
>>
>
> You mean the functions to fill the cmdq_rec and execute it?
> I think this should be part of the driver.
>
> Jassi, can you have a look on the interface this driver exports [0].
> They are needed to actually create the message which will be send.
> Could something like this be part of a mailbox driver?
>
> [0] https://patchwork.kernel.org/patch/9140221/
>
Packet creating/parsing should not be a part of controller driver. As
the log of this patch says, today it is used for only display but in
future it could work with other h/w as well, so it makes sense to have
mailbox api do the message queuing, the controller driver do the
send/receive and client drivers implement display and other h/w
specific packaging of data (protocol handling).

So yes, I think this could use mailbox api.

Cheers.
