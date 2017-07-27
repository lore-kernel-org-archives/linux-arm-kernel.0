From: anup.patel@broadcom.com (Anup Patel)
Date: Thu, 27 Jul 2017 09:42:33 +0530
Subject: [PATCH 1/6] dma: bcm-sba-raid: Improve memory allocation in SBA
 RAID driver
In-Reply-To: <20170726170932.GI3053@localhost>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
 <1501047404-14456-2-git-send-email-anup.patel@broadcom.com>
 <20170726170932.GI3053@localhost>
Message-ID: <CAALAos_xYyvTBZB2C+tt7NvWz-4TX-mXDVJwGqhvN0FTy8QA-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 10:39 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Jul 26, 2017 at 11:06:39AM +0530, Anup Patel wrote:
>> This patch improves memory allocation in SBA RAID driver in
>> following ways:
>> 1. Simplify struct sba_request to reduce memory consumption
>
> what is the simplification?? You need to document that

OK, will make it a separate patch with detailed commit description.

>
>> 2. Allocate sba resources before registering dma device
>
> what is the motivation for that
>
> So, reading this log doesnt help me to know what to expect in this patch

OK, this also requires separate patch with detailed commit description.

>
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>> ---
>>  drivers/dma/bcm-sba-raid.c | 439 +++++++++++++++++++++++----------------------
>>  1 file changed, 226 insertions(+), 213 deletions(-)
>>
>> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
>> index e41bbc7..6d15fed 100644
>> --- a/drivers/dma/bcm-sba-raid.c
>> +++ b/drivers/dma/bcm-sba-raid.c
>> @@ -48,7 +48,8 @@
>>
>>  #include "dmaengine.h"
>>
>> -/* SBA command related defines */
>> +/* ====== Driver macros and defines ===== */
>
> why this noise, seems unrelated to the change!

This is just minor beautification. Again, I will put this
in separate patch.

>
>> +
>>  #define SBA_TYPE_SHIFT                                       48
>>  #define SBA_TYPE_MASK                                        GENMASK(1, 0)
>>  #define SBA_TYPE_A                                   0x0
>> @@ -82,39 +83,41 @@
>>  #define SBA_CMD_WRITE_BUFFER                         0xc
>>  #define SBA_CMD_GALOIS                                       0xe
>>
>> -/* Driver helper macros */
>> +#define SBA_MAX_REQ_PER_MBOX_CHANNEL                 8192
>> +
>>  #define to_sba_request(tx)           \
>>       container_of(tx, struct sba_request, tx)
>>  #define to_sba_device(dchan)         \
>>       container_of(dchan, struct sba_device, dma_chan)
>>
>> -enum sba_request_state {
>> -     SBA_REQUEST_STATE_FREE = 1,
>> -     SBA_REQUEST_STATE_ALLOCED = 2,
>> -     SBA_REQUEST_STATE_PENDING = 3,
>> -     SBA_REQUEST_STATE_ACTIVE = 4,
>> -     SBA_REQUEST_STATE_RECEIVED = 5,
>> -     SBA_REQUEST_STATE_COMPLETED = 6,
>> -     SBA_REQUEST_STATE_ABORTED = 7,
>> +/* ===== Driver data structures ===== */
>> +
>> +enum sba_request_flags {
>> +     SBA_REQUEST_STATE_FREE          = 0x001,
>> +     SBA_REQUEST_STATE_ALLOCED       = 0x002,
>> +     SBA_REQUEST_STATE_PENDING       = 0x004,
>> +     SBA_REQUEST_STATE_ACTIVE        = 0x008,
>> +     SBA_REQUEST_STATE_RECEIVED      = 0x010,
>> +     SBA_REQUEST_STATE_COMPLETED     = 0x020,
>> +     SBA_REQUEST_STATE_ABORTED       = 0x040,
>> +     SBA_REQUEST_STATE_MASK          = 0x0ff,
>> +     SBA_REQUEST_FENCE               = 0x100,
>
> how does this help in mem alloctn?
>
>>  };
>>
>>  struct sba_request {
>>       /* Global state */
>>       struct list_head node;
>>       struct sba_device *sba;
>> -     enum sba_request_state state;
>> -     bool fence;
>> +     u32 flags;
>>       /* Chained requests management */
>>       struct sba_request *first;
>>       struct list_head next;
>> -     unsigned int next_count;
>>       atomic_t next_pending_count;
>>       /* BRCM message data */
>> -     void *resp;
>> -     dma_addr_t resp_dma;
>> -     struct brcm_sba_command *cmds;
>>       struct brcm_message msg;
>>       struct dma_async_tx_descriptor tx;
>> +     /* SBA commands */
>> +     struct brcm_sba_command cmds[0];
>>  };
>>
>>  enum sba_version {
>> @@ -128,11 +131,11 @@ struct sba_device {
>>       /* DT configuration parameters */
>>       enum sba_version ver;
>>       /* Derived configuration parameters */
>> -     u32 max_req;
>>       u32 hw_buf_size;
>>       u32 hw_resp_size;
>>       u32 max_pq_coefs;
>>       u32 max_pq_srcs;
>> +     u32 max_req;
>>       u32 max_cmd_per_req;
>>       u32 max_xor_srcs;
>>       u32 max_resp_pool_size;
>> @@ -152,7 +155,6 @@ struct sba_device {
>>       void *cmds_base;
>>       dma_addr_t cmds_dma_base;
>>       spinlock_t reqs_lock;
>> -     struct sba_request *reqs;
>>       bool reqs_fence;
>>       struct list_head reqs_alloc_list;
>>       struct list_head reqs_pending_list;
>> @@ -161,10 +163,9 @@ struct sba_device {
>>       struct list_head reqs_completed_list;
>>       struct list_head reqs_aborted_list;
>>       struct list_head reqs_free_list;
>> -     int reqs_free_count;
>>  };
>>
>> -/* ====== SBA command helper routines ===== */
>> +/* ====== Command helper routines ===== */
>
> more noise..
>
>>
>>  static inline u64 __pure sba_cmd_enc(u64 cmd, u32 val, u32 shift, u32 mask)
>>  {
>> @@ -196,7 +197,7 @@ static inline u32 __pure sba_cmd_pq_c_mdata(u32 d, u32 b1, u32 b0)
>>              ((d & SBA_C_MDATA_DNUM_MASK) << SBA_C_MDATA_DNUM_SHIFT);
>>  }
>>
>> -/* ====== Channel resource management routines ===== */
>> +/* ====== General helper routines ===== */
>
> and it keeps getting more interesting, sigh!!!
>
>>
>>  static struct sba_request *sba_alloc_request(struct sba_device *sba)
>>  {
>> @@ -204,24 +205,20 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
>>       struct sba_request *req = NULL;
>>
>>       spin_lock_irqsave(&sba->reqs_lock, flags);
>> -
>>       req = list_first_entry_or_null(&sba->reqs_free_list,
>>                                      struct sba_request, node);
>> -     if (req) {
>> +     if (req)
>>               list_move_tail(&req->node, &sba->reqs_alloc_list);
>> -             req->state = SBA_REQUEST_STATE_ALLOCED;
>> -             req->fence = false;
>> -             req->first = req;
>> -             INIT_LIST_HEAD(&req->next);
>> -             req->next_count = 1;
>> -             atomic_set(&req->next_pending_count, 1);
>> -
>> -             sba->reqs_free_count--;
>> +     spin_unlock_irqrestore(&sba->reqs_lock, flags);
>> +     if (!req)
>> +             return NULL;
>>
>> -             dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
>> -     }
>> +     req->flags = SBA_REQUEST_STATE_ALLOCED;
>> +     req->first = req;
>> +     INIT_LIST_HEAD(&req->next);
>> +     atomic_set(&req->next_pending_count, 1);
>
> Cant fathom how this helps w/ mem allocation

This is to reduce to duration for which "sba->reqs_lock" is held.
I will make this also a separate patch.

>
>>
>> -     spin_unlock_irqrestore(&sba->reqs_lock, flags);
>> +     dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
>>
>>       return req;
>>  }
>> @@ -231,7 +228,8 @@ static void _sba_pending_request(struct sba_device *sba,
>>                                struct sba_request *req)
>>  {
>>       lockdep_assert_held(&sba->reqs_lock);
>> -     req->state = SBA_REQUEST_STATE_PENDING;
>> +     req->flags &= ~SBA_REQUEST_STATE_MASK;
>> +     req->flags |= SBA_REQUEST_STATE_PENDING;
>>       list_move_tail(&req->node, &sba->reqs_pending_list);
>>       if (list_empty(&sba->reqs_active_list))
>>               sba->reqs_fence = false;
>> @@ -246,9 +244,10 @@ static bool _sba_active_request(struct sba_device *sba,
>>               sba->reqs_fence = false;
>>       if (sba->reqs_fence)
>>               return false;
>> -     req->state = SBA_REQUEST_STATE_ACTIVE;
>> +     req->flags &= ~SBA_REQUEST_STATE_MASK;
>> +     req->flags |= SBA_REQUEST_STATE_ACTIVE;
>>       list_move_tail(&req->node, &sba->reqs_active_list);
>> -     if (req->fence)
>> +     if (req->flags & SBA_REQUEST_FENCE)
>>               sba->reqs_fence = true;
>>       return true;
>>  }
>> @@ -258,7 +257,8 @@ static void _sba_abort_request(struct sba_device *sba,
>>                              struct sba_request *req)
>>  {
>>       lockdep_assert_held(&sba->reqs_lock);
>> -     req->state = SBA_REQUEST_STATE_ABORTED;
>> +     req->flags &= ~SBA_REQUEST_STATE_MASK;
>> +     req->flags |= SBA_REQUEST_STATE_ABORTED;
>>       list_move_tail(&req->node, &sba->reqs_aborted_list);
>>       if (list_empty(&sba->reqs_active_list))
>>               sba->reqs_fence = false;
>> @@ -269,42 +269,34 @@ static void _sba_free_request(struct sba_device *sba,
>>                             struct sba_request *req)
>>  {
>>       lockdep_assert_held(&sba->reqs_lock);
>> -     req->state = SBA_REQUEST_STATE_FREE;
>> +     req->flags &= ~SBA_REQUEST_STATE_MASK;
>> +     req->flags |= SBA_REQUEST_STATE_FREE;
>>       list_move_tail(&req->node, &sba->reqs_free_list);
>>       if (list_empty(&sba->reqs_active_list))
>>               sba->reqs_fence = false;
>> -     sba->reqs_free_count++;
>>  }
>>
>> -static void sba_received_request(struct sba_request *req)
>> +/* Note: Must be called with sba->reqs_lock held */
>> +static void _sba_complete_request(struct sba_device *sba,
>> +                               struct sba_request *req)
>>  {
>> -     unsigned long flags;
>> -     struct sba_device *sba = req->sba;
>> -
>> -     spin_lock_irqsave(&sba->reqs_lock, flags);
>> -     req->state = SBA_REQUEST_STATE_RECEIVED;
>> -     list_move_tail(&req->node, &sba->reqs_received_list);
>> -     spin_unlock_irqrestore(&sba->reqs_lock, flags);
>> +     lockdep_assert_held(&sba->reqs_lock);
>> +     req->flags &= ~SBA_REQUEST_STATE_MASK;
>> +     req->flags |= SBA_REQUEST_STATE_COMPLETED;
>> +     list_move_tail(&req->node, &sba->reqs_completed_list);
>> +     if (list_empty(&sba->reqs_active_list))
>> +             sba->reqs_fence = false;
>
> Ok am going to stop here, sorry can't review it further.
>
> Please split stuff up, make logical incremental patchsets and resubmit...

OK, I will split this into incremental patchsets and try to
make it easier for review.

Thanks,
Anup
