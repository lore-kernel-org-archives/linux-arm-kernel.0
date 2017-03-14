From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 14 Mar 2017 17:54:59 +0100
Subject: [PATCH v5 1/2] mailbox: Add driver for Broadcom FlexRM ring
 manager
In-Reply-To: <1488793240-25484-2-git-send-email-anup.patel@broadcom.com>
References: <1488793240-25484-1-git-send-email-anup.patel@broadcom.com>
 <1488793240-25484-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <CABb+yY0uDhgq-8hiAAXdq35igHH1GJVuuGTmerK=9UN6_VTHnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 10:40 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> Some of the Broadcom iProc SoCs have FlexRM ring manager
> which provides a ring-based programming interface to various
> offload engines (e.g. RAID, Crypto, etc).
>
> This patch adds a common mailbox driver for Broadcom FlexRM
> ring manager which can be shared by various offload engine
> drivers (implemented as mailbox clients).
>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Pramod KUMAR <pramod.kumar@broadcom.com>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/mailbox/Kconfig                      |  11 +
>  drivers/mailbox/Makefile                     |   2 +
>  drivers/mailbox/mailbox-flexrm/Makefile      |   6 +
>  drivers/mailbox/mailbox-flexrm/flexrm-desc.c | 764 ++++++++++++++++++++++++
>  drivers/mailbox/mailbox-flexrm/flexrm-desc.h |  47 ++
>  drivers/mailbox/mailbox-flexrm/flexrm-main.c | 829 +++++++++++++++++++++++++++
>  include/linux/mailbox/brcm-message.h         |  14 +-
>  7 files changed, 1669 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/mailbox/mailbox-flexrm/Makefile
>  create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.c
>  create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.h
>  create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-main.c
>
I would avoid platform specific sub-directory if possible, because
people tend to take it as  their fenced island where they can do
whatever they like.

Can you break this into an upper BRCM specific code (desc management)
and a lower purely mailbox driver (only sets up pointers/addresses to
create rings and track the flexrm's PC)?   Is there a reason why you
must dma_map, the buffers to send, in the spinlock protected
.send_data()?

thanks
