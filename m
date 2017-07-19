From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Jul 2017 06:37:22 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
In-Reply-To: <5595ca25-f616-c0f8-fb2c-241a951e8848@grimberg.me>
References: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
 <5595ca25-f616-c0f8-fb2c-241a951e8848@grimberg.me>
Message-ID: <933e9d49-ecfd-cc83-c116-29f97211480c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/19/2017 5:20 AM, Sagi Grimberg wrote:
>> Code is moving the completion queue doorbell after processing all completed
>> events and sending callbacks to the block layer on each iteration.
>>
>> This is causing a performance drop when a lot of jobs are queued towards
>> the HW. Move the completion queue doorbell on each loop instead and allow new
>> jobs to be queued by the HW.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   drivers/nvme/host/pci.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index d10d2f2..33d9b5b 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -810,13 +810,12 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
>>         while (nvme_read_cqe(nvmeq, &cqe)) {
>>           nvme_handle_cqe(nvmeq, &cqe);
>> +        nvme_ring_cq_doorbell(nvmeq);
>>           consumed++;
>>       }
>>   -    if (consumed) {
>> -        nvme_ring_cq_doorbell(nvmeq);
>> +    if (consumed)
>>           nvmeq->cqe_seen = 1;
>> -    }
>>   }
> 
> Agree with Keith that this is definitely not the way to go, it
> adds mmio operations in the hot path with very little gain (if
> at all).
> 

Understood, different architectures might have different latency accessing the HW
registers. It might be expansive on some platform like you indicated and this change
would make it worse.

I'm doing a self NACK as well.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
