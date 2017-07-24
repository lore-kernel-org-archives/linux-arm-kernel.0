From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 24 Jul 2017 22:06:39 +0530
Subject: [PATCH v2 6/7] mailbox: bcm-flexrm-mailbox: Set msg_queue_len for
 each channel
In-Reply-To: <CAALAos_yh0bCMZFrSmf-c92pNMBGhLT05YFF0duhmpxgYec+_w@mail.gmail.com>
References: <1500620142-910-1-git-send-email-anup.patel@broadcom.com>
 <1500620142-910-7-git-send-email-anup.patel@broadcom.com>
 <CABb+yY1Pxhgvvit=0eZr66DpLJ3MDEvRPx9dwDPJM8PwiKXiew@mail.gmail.com>
 <CAALAos_yh0bCMZFrSmf-c92pNMBGhLT05YFF0duhmpxgYec+_w@mail.gmail.com>
Message-ID: <CABb+yY3d1FvfB-NBVHLNfoFXGn9-8nFEdKBhXt4sBTr1vodhYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 9:26 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> Hi Jassi,
>
> Sorry for the delayed response...
>
> On Fri, Jul 21, 2017 at 9:16 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> Hi Anup,
>>
>> On Fri, Jul 21, 2017 at 12:25 PM, Anup Patel <anup.patel@broadcom.com> wrote:
>>> The Broadcom FlexRM ring (i.e. mailbox channel) can handle
>>> larger number of messages queued in one FlexRM ring hence
>>> this patch sets msg_queue_len for each mailbox channel to
>>> be same as RING_MAX_REQ_COUNT.
>>>
>>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>  drivers/mailbox/bcm-flexrm-mailbox.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
>>> index 9873818..20055a0 100644
>>> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
>>> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
>>> @@ -1683,8 +1683,11 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>>>                 ret = -ENOMEM;
>>>                 goto fail_free_debugfs_root;
>>>         }
>>> -       for (index = 0; index < mbox->num_rings; index++)
>>> +       for (index = 0; index < mbox->num_rings; index++) {
>>> +               mbox->controller.chans[index].msg_queue_len =
>>> +                                               RING_MAX_REQ_COUNT;
>>>                 mbox->controller.chans[index].con_priv = &mbox->rings[index];
>>> +       }
>>>
>> While writing mailbox.c I wasn't unaware that there is the option to
>> choose the queue length at runtime.
>> The idea was to keep the code as simple as possible. I am open to
>> making it a runtime thing, but first, please help me understand how
>> that is useful here.
>>
>> I understand FlexRm has a ring buffer of RING_MAX_REQ_COUNT(1024)
>> elements. Any message submitted to mailbox api can be immediately
>> written onto the ringbuffer if there is some space.
>> Is there any mechanism to report back to a client driver, if its
>> message in ringbuffer failed "to be sent"?
>> If there isn't any, then I think, in flexrm_last_tx_done() you should
>> simply return true if there is some space left in the rung-buffer,
>> false otherwise.
>
> Yes, we have error code in "struct brcm_message" to report back
> errors from send_message. In our mailbox clients, we check
> return value of mbox_send_message() and also the error code
> in "struct brcm_message".
>
I meant after the message has been accepted in the ringbuffer but the
remote failed to receive it.
There seems no such provision. IIANW, then you should be able to
consider every message as "sent successfully" once it is in the ring
buffer i.e, immediately after mbox_send_message() returns 0.
In that case I would think you don't need more than a couple of
entries out of MBOX_TX_QUEUE_LEN ?
