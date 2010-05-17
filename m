From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 17 May 2010 12:55:33 +0900
Subject: [PATCH 2/6] S3C: DMA: Add api driver for PL330
In-Reply-To: <AANLkTikZBVbddY247lYWwfqmslvWiooxO2rCw0gEGB2-@mail.gmail.com>
References: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
	<1274060139-14290-1-git-send-email-jassi.brar@samsung.com>
	<AANLkTikZBVbddY247lYWwfqmslvWiooxO2rCw0gEGB2-@mail.gmail.com>
Message-ID: <AANLkTin56HFIrKyXqEt7eUTxE3JYbdfLJRG2Q-r8UMQT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 12:44 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Mon, May 17, 2010 at 10:35 AM, Jassi Brar <jassi.brar@samsung.com> wrote:
>> Latest Samsung SoCs have one or more PL330 as their DMACs. This patch
>> implements the S3C DMA API for PL330 core driver.
>>
>> The design has been kept as generic as possible while keeping effort to
>> add support for new SoCs to the minimum possible level.
>>
>> Some of the salient features of this driver are:-
>> ?o ?Automatic scheduling of client requests onto DMAC if more than
>> ? ?one DMAC can reach the peripheral. Factors, such as current load
>> ? ?and number of exclusive but inactive peripherals that are
>> ? ?supported by the DMAC, are used to decide suitability of a DMAC
>> ? ?for a particular client.
>> ?o ?CIRCULAR buffer option is supported.
>> ?o ?The driver scales transparently with the number of DMACs and total
>> ? ?peripherals in the platform, since all peripherals are added to
>> ? ?the peripheral pool and DMACs to the controller pool.
>>
>> For most conservative use of memory, smallest driver size and best
>> performance, we don't employ legacy data structures of the S3C DMA API.
>> That should not have any affect since those data structures are completely
>> invisible to the DMA clients.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> ---
>> ?arch/arm/plat-samsung/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? ?6 +
>> ?arch/arm/plat-samsung/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?2 +
>> ?arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h | ? 87 ++
>> ?.../plat-samsung/include/plat/s3c-pl330-pdata.h ? ?| ? 34 +
>> ?arch/arm/plat-samsung/s3c-pl330.c ? ? ? ? ? ? ? ? ?| 1229 ++++++++++++++++++++
>> ?5 files changed, 1358 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
>> ?create mode 100644 arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h
>> ?create mode 100644 arch/arm/plat-samsung/s3c-pl330.c
>>
>> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
>> index d552c65..78b8b89 100644
>> --- a/arch/arm/plat-samsung/Kconfig
>> +++ b/arch/arm/plat-samsung/Kconfig
>> @@ -198,6 +198,12 @@ config S3C_DMA
>> ? ? ? ?help
>> ? ? ? ? ?Internal configuration for S3C DMA core
>>
>> +config S3C_PL330_DMA
>> + ? ? ? bool
>> + ? ? ? select PL330
>> + ? ? ? help
>> + ? ? ? ? S3C DMA API Driver for PL330 DMAC.
>> +
>
> It's not functional comment. just suggestion. At least plat-samsung
> directory, How about to use 'SAMUSNG' prefix instead of 'S3C'. We
> don't know next chip name start S7, S9, and so on. which one can be
> possible.
> So future use and reduce the confusion, we start the use the 'SAMSUNG' prefix.
This DMA API driver has nothing to do with S3Cxxxx, S5Pxxxx, S7Pxxxx etc SoCs.
The "S3C" prefix specifies the DMA API version. And the DMA API remains same
as that used for S3C24xx SoCs.
