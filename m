From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 15 Mar 2017 12:07:19 +0530
Subject: [PATCH v5 1/2] mailbox: Add driver for Broadcom FlexRM ring
 manager
In-Reply-To: <CABb+yY0uDhgq-8hiAAXdq35igHH1GJVuuGTmerK=9UN6_VTHnA@mail.gmail.com>
References: <1488793240-25484-1-git-send-email-anup.patel@broadcom.com>
 <1488793240-25484-2-git-send-email-anup.patel@broadcom.com>
 <CABb+yY0uDhgq-8hiAAXdq35igHH1GJVuuGTmerK=9UN6_VTHnA@mail.gmail.com>
Message-ID: <CAALAos9pWCS5XE4vBPM7uSCO=bve6bBGEpFx7EpL=9KnRnPWKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 10:24 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Mon, Mar 6, 2017 at 10:40 AM, Anup Patel <anup.patel@broadcom.com> wrote:
>> Some of the Broadcom iProc SoCs have FlexRM ring manager
>> which provides a ring-based programming interface to various
>> offload engines (e.g. RAID, Crypto, etc).
>>
>> This patch adds a common mailbox driver for Broadcom FlexRM
>> ring manager which can be shared by various offload engine
>> drivers (implemented as mailbox clients).
>>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Pramod KUMAR <pramod.kumar@broadcom.com>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> ---
>>  drivers/mailbox/Kconfig                      |  11 +
>>  drivers/mailbox/Makefile                     |   2 +
>>  drivers/mailbox/mailbox-flexrm/Makefile      |   6 +
>>  drivers/mailbox/mailbox-flexrm/flexrm-desc.c | 764 ++++++++++++++++++++++++
>>  drivers/mailbox/mailbox-flexrm/flexrm-desc.h |  47 ++
>>  drivers/mailbox/mailbox-flexrm/flexrm-main.c | 829 +++++++++++++++++++++++++++
>>  include/linux/mailbox/brcm-message.h         |  14 +-
>>  7 files changed, 1669 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/mailbox/mailbox-flexrm/Makefile
>>  create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.c
>>  create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.h
>>  create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-main.c
>>
> I would avoid platform specific sub-directory if possible, because
> people tend to take it as  their fenced island where they can do
> whatever they like.

Sure, I will remove driver directory and merge everything into one
driver source file.

>
> Can you break this into an upper BRCM specific code (desc management)
> and a lower purely mailbox driver (only sets up pointers/addresses to
> create rings and track the flexrm's PC)?   Is there a reason why you

Sure, I will organize merged driver source file as-per your suggestion

> must dma_map, the buffers to send, in the spinlock protected
> .send_data()?

The dma_map() happens only for brcm_message with
SPU2 message type. The SPU2 crypto mailbox client driver
will just prepare src and dst scatterlist using the scatterlist
passed by Linux crypto framework and pass it to mailbox
controller driver (i.e. FlexRM driver or PDC driver). The
pages in src and dst scatterlist will not be DMA mapped
hence we first dma_map() scatterlist and then create
descriptors using DMA addresses.

I am fine in doing dma_map() outside spinlock protected
.send_data() for SPU2 message type but this will impact
three drivers:
1. BCM SPU2 Crypto driver (already merged)
2. BCM PDC mailbox driver (already merged)
3. BCM FlexRM mailbox driver (this patch)

If required we should have separate patch to move
dma_map() out of .send_data() because it impacts
three different drivers.

Regards,
Anup
