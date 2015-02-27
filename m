From: rsahu@apm.com (Rameshwar Sahu)
Date: Fri, 27 Feb 2015 11:59:41 +0530
Subject: [PATCH v6 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <CAFd313zA1GQxvw3s2mcEPtpvf9KxKvQWkaHojjAoUYFFQ90J8Q@mail.gmail.com>
References: <1424782439-31485-1-git-send-email-rsahu@apm.com>
 <1424782439-31485-2-git-send-email-rsahu@apm.com>
 <CAFd313xnFLn8=i+9Dmpg5SH=DcxaUcQi_Pvb-MXPZCN9=7hhtw@mail.gmail.com>
 <54EF2CD9.8010104@codethink.co.uk>
 <CAFd313zA1GQxvw3s2mcEPtpvf9KxKvQWkaHojjAoUYFFQ90J8Q@mail.gmail.com>
Message-ID: <CAFd313zFLFg7bMnQM_Pa+c+TZJkA7_aYnx+L+BQ1jZ-qQs2-hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi


On Fri, Feb 27, 2015 at 9:39 AM, Rameshwar Sahu <rsahu@apm.com> wrote:
> Hi,
>
>
> On Thu, Feb 26, 2015 at 7:55 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> On 26/02/15 12:31, Rameshwar Sahu wrote:
>>> Hi Vinod,
>>>
>>>
>>> On Tue, Feb 24, 2015 at 6:23 PM, Rameshwar Prasad Sahu <rsahu@apm.com> wrote:
>>>> This patch implements the APM X-Gene SoC DMA engine driver. The APM X-Gene
>>>> SoC DMA engine consists of 4 DMA channels for performing DMA operations.
>>>> These DMA operations include memory copy and scatter-gather memory copy
>>>> offloading.
>>>>
>>>> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
>>>> Signed-off-by: Loc Ho <lho@apm.com>
>>>> ---
>>>>  drivers/dma/Kconfig     |    8 +
>>>>  drivers/dma/Makefile    |    1 +
>>>>  drivers/dma/xgene-dma.c | 1738 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 1747 insertions(+)
>>>>  create mode 100755 drivers/dma/xgene-dma.c
>>>>
>>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>>> index a874b6e..0e05831 100644
>>>> --- a/drivers/dma/Kconfig
>>>> +++ b/drivers/dma/Kconfig
>>>> @@ -425,6 +425,14 @@ config IMG_MDC_DMA
>>>>         help
>>>>           Enable support for the IMG multi-threaded DMA controller (MDC).
>>>>
>>>> +config XGENE_DMA
>>>> +       tristate "APM X-Gene DMA support"
>>>> +       depends on ARCH_XGENE
>>>> +       select DMA_ENGINE
>>>> +       select ASYNC_TX_ENABLE_CHANNEL_SWITCH
>>>> +       help
>>>> +         Enable support for the APM X-Gene SoC DMA engine.
>>>> +
>>>>  config DMA_ENGINE
>>>>         bool
>>>>
>>>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>>>> index f915f61..06c1576 100644
>>>> --- a/drivers/dma/Makefile
>>>> +++ b/drivers/dma/Makefile
>>>> @@ -51,3 +51,4 @@ obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
>>>>  obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>>>>  obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
>>>>  obj-$(CONFIG_IMG_MDC_DMA) += img-mdc-dma.o
>>>> +obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>>>> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
>>>> new file mode 100755
>>>> index 0000000..e736c2e
>>>> --- /dev/null
>>>> +++ b/drivers/dma/xgene-dma.c
>>>> @@ -0,0 +1,1738 @@
>>>> +/*
>>>> + * Applied Micro X-Gene SoC DMA engine Driver
>>>> + *
>>>> + * Copyright (c) 2015, Applied Micro Circuits Corporation
>>>> + * Authors: Rameshwar Prasad Sahu <rsahu@apm.com>
>>>> + *         Loc Ho <lho@apm.com>
>>>> + *
>>>> + * This program is free software; you can redistribute  it and/or modify it
>>>> + * under  the terms of  the GNU General  Public License as published by the
>>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>>> + * option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>> + *
>>>> + * NOTE: PM support is currently not available.
>>>> + */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/dma-mapping.h>
>>>> +#include <linux/dmaengine.h>
>>>> +#include <linux/dmapool.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_device.h>
>>>> +
>>>> +#include "dmaengine.h"
>>>> +
>>>> +/* DMA ring csr registers and bit definations */
>>>> +#define DMA_RING_CONFIG                        0x04
>>>> +#define DMA_RING_ENABLE                        BIT(31)
>>>> +#define DMA_RING_ID                    0x08
>>>> +#define DMA_RING_ID_SETUP(v)           ((v) | BIT(31))
>>>> +#define DMA_RING_ID_BUF                        0x0C
>>>> +#define DMA_RING_ID_BUF_SETUP(v)       (((v) << 9) | BIT(21))
>>>> +#define DMA_RING_THRESLD0_SET1         0x30
>>>> +#define DMA_RING_THRESLD0_SET1_VAL     0X64
>>>> +#define DMA_RING_THRESLD1_SET1         0x34
>>>> +#define DMA_RING_THRESLD1_SET1_VAL     0xC8
>>>> +#define DMA_RING_HYSTERESIS            0x68
>>>> +#define DMA_RING_HYSTERESIS_VAL                0xFFFFFFFF
>>>> +#define DMA_RING_STATE                 0x6C
>>>> +#define DMA_RING_STATE_WR_BASE         0x70
>>>> +#define DMA_RING_NE_INT_MODE           0x017C
>>>> +#define DMA_RING_NE_INT_MODE_SET(m, v) \
>>>> +       ((m) = ((m) & ~BIT(31 - (v))) | BIT(31 - (v)))
>>>> +#define DMA_RING_NE_INT_MODE_RESET(m, v)       \
>>>> +       ((m) &= (~BIT(31 - (v))))
>>>> +#define DMA_RING_CLKEN                 0xC208
>>>> +#define DMA_RING_SRST                  0xC200
>>>> +#define DMA_RING_MEM_RAM_SHUTDOWN      0xD070
>>>> +#define DMA_RING_BLK_MEM_RDY           0xD074
>>>> +#define DMA_RING_BLK_MEM_RDY_VAL       0xFFFFFFFF
>>>> +#define DMA_RING_DESC_CNT(v)           (((v) & 0x0001FFFE) >> 1)
>>>> +#define DMA_RING_ID_GET(owner, num)    (((owner) << 6) | (num))
>>>> +#define DMA_RING_DST_ID(v)             ((1 << 10) | (v))
>>>> +#define DMA_RING_CMD_OFFSET            0x2C
>>>> +#define DMA_RING_CMD_BASE_OFFSET(v)    ((v) << 6)
>>>> +#define DMA_RING_COHERENT_SET(m)       (((u32 *)(m))[2] |= BIT(4))
>>>> +#define DMA_RING_ADDRL_SET(m, v)       (((u32 *)(m))[2] |= (((v) >> 8) << 5))
>>>> +#define DMA_RING_ADDRH_SET(m, v)       (((u32 *)(m))[3] |= ((v) >> 35))
>>>> +#define DMA_RING_ACCEPTLERR_SET(m)     (((u32 *)(m))[3] |= BIT(19))
>>>> +#define DMA_RING_SIZE_SET(m, v)                (((u32 *)(m))[3] |= ((v) << 23))
>>>> +#define DMA_RING_RECOMBBUF_SET(m)      (((u32 *)(m))[3] |= BIT(27))
>>>> +#define DMA_RING_RECOMTIMEOUTL_SET(m)  (((u32 *)(m))[3] |= (0x7 << 28))
>>>> +#define DMA_RING_RECOMTIMEOUTH_SET(m)  (((u32 *)(m))[4] |= 0x3)
>>>> +#define DMA_RING_SELTHRSH_SET(m)       (((u32 *)(m))[4] |= BIT(3))
>>>> +#define DMA_RING_TYPE_SET(m, v)                (((u32 *)(m))[4] |= ((v) << 19))
>>>> +
>>>> +/* DMA device csr registers and bit definitions */
>>>> +#define DMA_IPBRR              0x0
>>>> +#define DMA_DEV_ID_RD(v)       ((v) & 0x00000FFF)
>>>> +#define DMA_BUS_ID_RD(v)       (((v) >> 12) & 3)
>>>> +#define DMA_REV_NO_RD(v)       (((v) >> 14) & 3)
>>>> +#define DMA_GCR                        0x10
>>>> +#define DMA_CH_SETUP(v)                ((v) = ((v) & ~0x000FFFFF) | 0x000AAFFF)
>>>> +#define DMA_ENABLE(v)          ((v) |= BIT(31))
>>>> +#define DMA_DISABLE(v)         ((v) &= ~BIT(31))
>>>> +#define DMA_INT                        0x70
>>>> +#define DMA_INT_MASK           0x74
>>>> +#define DMA_INT_ALL_MASK       0xFFFFFFFF
>>>> +#define DMA_INT_ALL_UNMASK     0x0
>>>> +#define DMA_INT_MASK_SHIFT     0x14
>>>> +#define DMA_RING_INT0_MASK     0x90A0
>>>> +#define DMA_RING_INT1_MASK     0x90A8
>>>> +#define DMA_RING_INT2_MASK     0x90B0
>>>> +#define DMA_RING_INT3_MASK     0x90B8
>>>> +#define DMA_RING_INT4_MASK     0x90C0
>>>> +#define DMA_CFG_RING_WQ_ASSOC  0x90E0
>>>> +#define DMA_ASSOC_RING_MNGR1   0xFFFFFFFF
>>>> +#define DMA_MEM_RAM_SHUTDOWN   0xD070
>>>> +#define DMA_BLK_MEM_RDY                0xD074
>>>> +#define DMA_BLK_MEM_RDY_VAL    0xFFFFFFFF
>>>> +
>>>> +/* DMA Descriptor format */
>>>> +#define DMA_DESC_ELERR_RD(m)           (((m) >> 46) & 0x3)
>>>> +#define DMA_DESC_NV_SET(m)             (((u64 *)(m))[0] |= BIT_ULL(50))
>>>> +#define DMA_DESC_IN_SET(m)             (((u64 *)(m))[0] |= BIT_ULL(55))
>>>> +#define DMA_DESC_RTYPE_SET(m, v)       (((u64 *)(m))[0] |= ((u64)(v) << 56))
>>>> +#define DMA_DESC_LERR_RD(m)            (((m) >> 60) & 0x7)
>>>> +#define DMA_DESC_BUFADDR_SET(m, v)     (((u64 *)(m))[0] |= (v))
>>>> +#define DMA_DESC_BUFLEN_SET(m, v)      (((u64 *)(m))[0] |= ((u64)(v) << 48))
>>>> +#define DMA_DESC_C_SET(m)              (((u64 *)(m))[1] |= BIT_ULL(63))
>>>> +#define DMA_DESC_DR_SET(m)             (((u64 *)(m))[2] |= BIT_ULL(61))
>>>> +#define DMA_DESC_DST_ADDR_SET(m, v)    (((u64 *)(m))[3] |= (v))
>>>> +#define DMA_DESC_H0ENQ_NUM_SET(m, v)   (((u64 *)(m))[3] |= ((u64)(v) << 48))
>>>> +#define DMA_DESC_STATUS(x, y)          (((x) << 4) | (y))
>>
>> This is very difficult to read.
>>
> In the original source file it is well aligned, when I generate patch
> and send, it scattered like this.
>>

Sorry I mis interpreted your comments. I will make these above define simpler.
>> --
>> Ben Dooks                               http://www.codethink.co.uk/
>> Senior Engineer                         Codethink - Providing Genius
