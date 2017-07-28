From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 28 Jul 2017 09:16:35 +0530
Subject: [PATCH 1/6] dma: bcm-sba-raid: Improve memory allocation in SBA
 RAID driver
In-Reply-To: <20170728031342.GR3053@localhost>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
 <1501047404-14456-2-git-send-email-anup.patel@broadcom.com>
 <20170726170932.GI3053@localhost>
 <CAALAos_xYyvTBZB2C+tt7NvWz-4TX-mXDVJwGqhvN0FTy8QA-Q@mail.gmail.com>
 <20170728031342.GR3053@localhost>
Message-ID: <CAALAos9LvXH_hxeTP7VFGKD+=G5ynkCkOJ=+i4gs+qRJko5dRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 8:43 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Jul 27, 2017 at 09:42:33AM +0530, Anup Patel wrote:
>> On Wed, Jul 26, 2017 at 10:39 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Wed, Jul 26, 2017 at 11:06:39AM +0530, Anup Patel wrote:
>
>> >>  drivers/dma/bcm-sba-raid.c | 439 +++++++++++++++++++++++----------------------
>> >>  1 file changed, 226 insertions(+), 213 deletions(-)
>> >>
>> >> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
>> >> index e41bbc7..6d15fed 100644
>> >> --- a/drivers/dma/bcm-sba-raid.c
>> >> +++ b/drivers/dma/bcm-sba-raid.c
>> >> @@ -48,7 +48,8 @@
>> >>
>> >>  #include "dmaengine.h"
>> >>
>> >> -/* SBA command related defines */
>> >> +/* ====== Driver macros and defines ===== */
>> >
>> > why this noise, seems unrelated to the change!
>>
>> This is just minor beautification. Again, I will put this
>> in separate patch.
>
> Well you can't shove garlands under an unrelated change. By all means throw
> the whole garden out there, but please as a separate patch

Sure, I will have separate patch for this beautification.

>
>>
>> >
>> >> +
>> >>  #define SBA_TYPE_SHIFT                                       48
>> >>  #define SBA_TYPE_MASK                                        GENMASK(1, 0)
>> >>  #define SBA_TYPE_A                                   0x0
>> >> @@ -82,39 +83,41 @@
>> >>  #define SBA_CMD_WRITE_BUFFER                         0xc
>> >>  #define SBA_CMD_GALOIS                                       0xe
>> >>
>> >> -/* Driver helper macros */
>> >> +#define SBA_MAX_REQ_PER_MBOX_CHANNEL                 8192
>> >> +
>> >>  #define to_sba_request(tx)           \
>> >>       container_of(tx, struct sba_request, tx)
>> >>  #define to_sba_device(dchan)         \
>> >>       container_of(dchan, struct sba_device, dma_chan)
>> >>
>> >> -enum sba_request_state {
>> >> -     SBA_REQUEST_STATE_FREE = 1,
>> >> -     SBA_REQUEST_STATE_ALLOCED = 2,
>> >> -     SBA_REQUEST_STATE_PENDING = 3,
>> >> -     SBA_REQUEST_STATE_ACTIVE = 4,
>> >> -     SBA_REQUEST_STATE_RECEIVED = 5,
>> >> -     SBA_REQUEST_STATE_COMPLETED = 6,
>> >> -     SBA_REQUEST_STATE_ABORTED = 7,
>> >> +/* ===== Driver data structures ===== */
>> >> +
>> >> +enum sba_request_flags {
>> >> +     SBA_REQUEST_STATE_FREE          = 0x001,
>> >> +     SBA_REQUEST_STATE_ALLOCED       = 0x002,
>> >> +     SBA_REQUEST_STATE_PENDING       = 0x004,
>> >> +     SBA_REQUEST_STATE_ACTIVE        = 0x008,
>> >> +     SBA_REQUEST_STATE_RECEIVED      = 0x010,
>> >> +     SBA_REQUEST_STATE_COMPLETED     = 0x020,
>> >> +     SBA_REQUEST_STATE_ABORTED       = 0x040,
>> >> +     SBA_REQUEST_STATE_MASK          = 0x0ff,
>> >> +     SBA_REQUEST_FENCE               = 0x100,
>> >
>> > how does this help in mem alloctn?
>
> ??

Ahh, I missed to address this comment.

Currently, we have separate "bool" flag for fenced
sba_request and separate "state" variable in
sba_request. We are have merged this two things
in common "u32 flags" in sba_request. In future,
we can use more bits in "u32 flags" as required
without disturbing the sba_request.

I will make this separate patch.

I agree, I have covered many changes in PATCH1
which makes it hard for you to review.

Thanks,
Anup
