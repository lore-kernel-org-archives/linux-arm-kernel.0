From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Wed, 23 Aug 2017 10:14:44 +0530
Subject: [PATCH 13/18] rpmsg: glink: Add rx done command
In-Reply-To: <67a2b4db-fabb-9787-6813-7bd001814bfc@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
 <1502903951-5403-14-git-send-email-sricharan@codeaurora.org>
 <a5f890fe-7405-ff03-9a43-0e4d62683cb6@codeaurora.org>
 <67a2b4db-fabb-9787-6813-7bd001814bfc@codeaurora.org>
Message-ID: <6b36382b-8889-0a10-d276-fe6d5bd1874e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/22/2017 7:46 PM, Sricharan R wrote:
> Hi,
>>> +??? /* Take it off the tree of receive intents */
>>> +??? if (!intent->reuse) {
>>> +??????? spin_lock(&channel->intent_lock);
>>> +??????? idr_remove(&channel->liids, intent->id);
>>> +??????? spin_unlock(&channel->intent_lock);
>>> +??? }
>>> +
>>> +??? /* Schedule the sending of a rx_done indication */
>>> +??? spin_lock(&channel->intent_lock);
>>> +??? list_add_tail(&intent->node, &channel->done_intents);
>>> +??? spin_unlock(&channel->intent_lock);
>>> +
>>> +??? schedule_work(&channel->intent_work);
>> Adding one more parallel path will hit performance, if this worker could not get CPU cycles
>> or blocked by other RT or HIGH_PRIO worker on global worker pool.
>   The idea is, by design to have parallel non-blocking paths for rx and tx (that is done as a
>   part of rx by sending the rx_done command), otherwise trying to send the rx_done
>   command in the rx isr context is a problem since the tx can wait for the FIFO space and
>   in worst case, can even lead to a potential deadlock if both the local and remote try
>   the same. Having said that, instead of queuing this work in to the global queue, this
>   can be put in to a local glink edge owned queue (or) a threaded isr ?, downstream does the
>   rx_done in a client specific worker.

Yes, mixing RX and TX path will cause dead lock. I am okay to use 
specific queue with HIGH_PRIO or a threaded isr.
down stream uses both client specific worker and client RX cb [this mix 
the TX and RX path] which want to avoid.
>
> Regards,
>   Sricharan
>
