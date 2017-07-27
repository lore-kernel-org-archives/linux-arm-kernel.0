From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 27 Jul 2017 17:23:52 +0530
Subject: [PATCH v2 6/7] mailbox: bcm-flexrm-mailbox: Set msg_queue_len for
 each channel
In-Reply-To: <CAALAos9RoAbZcsyQV_U_aUeVSO9SMYNqNpqOdCF0ytNXK8SrnA@mail.gmail.com>
References: <1500620142-910-1-git-send-email-anup.patel@broadcom.com>
 <1500620142-910-7-git-send-email-anup.patel@broadcom.com>
 <CABb+yY1Pxhgvvit=0eZr66DpLJ3MDEvRPx9dwDPJM8PwiKXiew@mail.gmail.com>
 <CAALAos_yh0bCMZFrSmf-c92pNMBGhLT05YFF0duhmpxgYec+_w@mail.gmail.com>
 <CABb+yY3d1FvfB-NBVHLNfoFXGn9-8nFEdKBhXt4sBTr1vodhYw@mail.gmail.com>
 <CAALAos9T0YtCvgjGCMVPn=dw2JKY=jTxz-v431NgpBCKFo1vVQ@mail.gmail.com>
 <CABb+yY2x1Wb=RZhq+eUnM0wkcih4YkFDrKRgqhs1erGQGH3tdw@mail.gmail.com>
 <CAALAos-aKDw8p2_BFausm+VC4teoAW22239+gnkPfFUaiZxB6w@mail.gmail.com>
 <CABb+yY3fwPTSc0PKh44uvgdbvQJhu-X3O_L5EtumB6ovsaOdSw@mail.gmail.com>
 <CAALAos9RoAbZcsyQV_U_aUeVSO9SMYNqNpqOdCF0ytNXK8SrnA@mail.gmail.com>
Message-ID: <CABb+yY2gj3SBTCzcGim0=c1G9SzAiQ0HxA1F24kjs-jS42Z+dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 11:20 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> On Thu, Jul 27, 2017 at 10:29 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:

>>>>>>> Sorry for the delayed response...
>>>>>>>
>>>>>>> On Fri, Jul 21, 2017 at 9:16 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>>>>>>> Hi Anup,
>>>>>>>>
>>>>>>>> On Fri, Jul 21, 2017 at 12:25 PM, Anup Patel <anup.patel@broadcom.com> wrote:
>>>>>>>>> The Broadcom FlexRM ring (i.e. mailbox channel) can handle
>>>>>>>>> larger number of messages queued in one FlexRM ring hence
>>>>>>>>> this patch sets msg_queue_len for each mailbox channel to
>>>>>>>>> be same as RING_MAX_REQ_COUNT.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>>>>>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/mailbox/bcm-flexrm-mailbox.c | 5 ++++-
>>>>>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
>>>>>>>>> index 9873818..20055a0 100644
>>>>>>>>> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
>>>>>>>>> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
>>>>>>>>> @@ -1683,8 +1683,11 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>>>>>>>>>                 ret = -ENOMEM;
>>>>>>>>>                 goto fail_free_debugfs_root;
>>>>>>>>>         }
>>>>>>>>> -       for (index = 0; index < mbox->num_rings; index++)
>>>>>>>>> +       for (index = 0; index < mbox->num_rings; index++) {
>>>>>>>>> +               mbox->controller.chans[index].msg_queue_len =
>>>>>>>>> +                                               RING_MAX_REQ_COUNT;
>>>>>>>>>                 mbox->controller.chans[index].con_priv = &mbox->rings[index];
>>>>>>>>> +       }
>>>>>>>>>
>>>>>>>> While writing mailbox.c I wasn't unaware that there is the option to
>>>>>>>> choose the queue length at runtime.
>>>>>>>> The idea was to keep the code as simple as possible. I am open to
>>>>>>>> making it a runtime thing, but first, please help me understand how
>>>>>>>> that is useful here.
>>>>>>>>
>>>>>>>> I understand FlexRm has a ring buffer of RING_MAX_REQ_COUNT(1024)
>>>>>>>> elements. Any message submitted to mailbox api can be immediately
>>>>>>>> written onto the ringbuffer if there is some space.
>>>>>>>> Is there any mechanism to report back to a client driver, if its
>>>>>>>> message in ringbuffer failed "to be sent"?
>>>>>>>> If there isn't any, then I think, in flexrm_last_tx_done() you should
>>>>>>>> simply return true if there is some space left in the rung-buffer,
>>>>>>>> false otherwise.
>>>>>>>
>>>>>>> Yes, we have error code in "struct brcm_message" to report back
>>>>>>> errors from send_message. In our mailbox clients, we check
>>>>>>> return value of mbox_send_message() and also the error code
>>>>>>> in "struct brcm_message".
>>>>>>>
>>>>>> I meant after the message has been accepted in the ringbuffer but the
>>>>>> remote failed to receive it.
>>>>>
>>>>> Yes, even this case is handled.
>>>>>
>>>>> In case of IO errors after message has been put in ring buffer, we get
>>>>> completion message with error code and mailbox client drivers will
>>>>> receive back "struct brcm_message" with error set.
>>>>>
>>>>> You can refer flexrm_process_completions() for more details.
>>>>>
>> It doesn't seem to be what I suggest. I see two issues in
>> flexrm_process_completions()
>> 1) It calls mbox_send_message(), which is a big NO for a controller
>> driver. Why should you have one more message stored outside of
>> ringbuffer?
>
> The "last_pending_msg" in each FlexRM ring was added to fit FlexRM
> in Mailbox framework.
>
> We don't have any IRQ for TX done so "txdone_irq" out of the question for
> FlexRM. We only have completions for both success or failures (IO errors).
>
> This means we have to use "txdone_poll" for FlexRM. For "txdone_poll",
> we have to provide last_tx_done() callback. The last_tx_done() callback
> is supposed to return true if last send_data() call succeeded.
>
> To implement last_tx_done() in FlexRM driver, we added "last_pending_msg".
>
> When "last_pending_msg" is NULL it means last call to send_data() succeeded
> and when "last_pending_msg" is != NULL it means last call to send_data()
> did not go through due to lack of space in FlexRM ring.
>
It could be simpler.
Since flexrm_send_data() is essentially about putting the message in
the ring-buffer (and not about _transmission_ failures), the
last_tx_done() should simply return true if requests_ida has not all
ids allocated. False otherwise.

>>
>> 2) It calls mbox_chan_received_data()  which is for messages received
>> from the remote. And not the way to report failed _transmission_, for
>> which the api calls back mbox_client.tx_done() .  In your client
>> driver please populate mbox_client.tx_done() and see which message is
>> reported "sent fine" when.
>>
>>
>>>>>> There seems no such provision. IIANW, then you should be able to
>>>>>> consider every message as "sent successfully" once it is in the ring
>>>>>> buffer i.e, immediately after mbox_send_message() returns 0.
>>>>>> In that case I would think you don't need more than a couple of
>>>>>> entries out of MBOX_TX_QUEUE_LEN ?
>>>>>
>>>>> What I am trying to suggest is that we can take upto 1024 messages
>>>>> in a FlexRM ring but the MBOX_TX_QUEUE_LEN limits us queuing
>>>>> more messages. This issue manifest easily when multiple CPUs
>>>>> queues to same FlexRM ring (i.e. same mailbox channel).
>>>>>
>>>> OK then, I guess we have to make the queue length a runtime decision.
>>>
>>> Do you agree with approach taken by PATCH5 and PATCH6 to
>>> make queue length runtime?
>>>
>> I agree that we may have to get the queue length from platform, if
>> MBOX_TX_QUEUE_LEN is limiting performance. That will be easier on both
>> of us. However I suspect the right fix for _this_ situation is in
>> flexrm driver. See above.
>
> The current implementation is trying to model FlexRM using "txdone_poll"
> method and that's why we have dependency on MBOX_TX_QUEUE_LEN
>
> I think what we really need is new method for "txdone" to model ring
> manager HW (such as FlexRM). Let's call it "txdone_none".
>
> For "txdone_none", it means there is no "txdone" reporting in HW
> and mbox_send_data() should simply return value returned by
> send_data() callback. The last_tx_done() callback is not required
> for "txdone_none" and MBOX_TX_QUEUE_LEN also has no
> effect on "txdone_none". Both blocking and non-blocking clients
> are treated same for "txdone_none".
>
That is already supported :)

In drivers/dma/bcm-sba-raid.c

sba_send_mbox_request(...)
{
           ......
        req->msg.error = 0;
        ret = mbox_send_message(sba->mchans[mchans_idx], &req->msg);
        if (ret < 0) {
                dev_err(sba->dev, "send message failed with error %d", ret);
                return ret;
        }
        ret = req->msg.error;
        if (ret < 0) {
                dev_err(sba->dev, "message error %d", ret);
                return ret;
        }
          .....
}

Here you _do_ assume that as soon as the mbox_send_message() returns,
the last_tx_done() is true. In other words, this is a case of client
'knows_txdone'.

So ideally you should specify cl->knows_txdone = true during
mbox_request_channel() and have ...

sba_send_mbox_request(...)
{
        ret = mbox_send_message(sba->mchans[mchans_idx], &req->msg);
        if (ret < 0) {
                dev_err(sba->dev, "send message failed with error %d", ret);
                return ret;
        }

        ret = req->msg.error;

       /* Message successfully placed in the ringbuffer, i.e, done */
       mbox_client_txdone(sba->mchans[mchans_idx], ret);

       if (ret < 0) {
                dev_err(sba->dev, "message error %d", ret);
                return ret;
        }

        .....
}

This way MBOX_TX_QUEUE_LEN should be more than enough and pose no bottleneck.


Cheers!
