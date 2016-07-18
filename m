From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 18 Jul 2016 10:47:01 -0700
Subject: [PATCH 1/2] mtd: brcmnand: iProc big endian and ONFI support
In-Reply-To: <CAGt4E5tyANE-fiRNp=qZHLJLp+XCd0i74E0n2vgedQC5Rb46+g@mail.gmail.com>
References: <1468863377-31862-1-git-send-email-ray.jui@broadcom.com>
 <1468863377-31862-2-git-send-email-ray.jui@broadcom.com>
 <CAGt4E5tyANE-fiRNp=qZHLJLp+XCd0i74E0n2vgedQC5Rb46+g@mail.gmail.com>
Message-ID: <02461aa0-687b-f640-e06a-677bf7608673@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On 7/18/2016 10:41 AM, Markus Mayer wrote:
> On 18 July 2016 at 10:36, Ray Jui <ray.jui@broadcom.com> wrote:
>> This patch adds big endian and ONFI support for various iProc based
>> SoCs that use the core brcmstb NAND controller
>>
>> This patch was originally implemented by Prafulla Kota
>> <prafulla.kota@broadcom.com> and fully tested on iProc based NS2 SVK
>>
>> Signed-off-by: Prafulla Kota <prafulla.kota@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>  drivers/mtd/nand/brcmnand/brcmnand.c   | 12 ++++++------
>>  drivers/mtd/nand/brcmnand/brcmnand.h   | 13 ++++++++-----
>>  drivers/mtd/nand/brcmnand/iproc_nand.c | 17 +++++++++++++----
>>  3 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
>> index b76ad7c..12a1585 100644
>> --- a/drivers/mtd/nand/brcmnand/brcmnand.c
>> +++ b/drivers/mtd/nand/brcmnand/brcmnand.c

...
...

>> +       /*
>> +        * In the case of BE or when dealing with NAND data, alway configure
>> +        * the APB bus to LE mode before accessing the FIFO and back to BE mode
>> +        * after the access is done
>> +        */
>> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || !is_param) {
>> +               if (prepare)
>> +                       val |= IPROC_NAND_APB_LE_MODE;
>> +               else
>> +                       val &= ~IPROC_NAND_APB_LE_MODE;
>> +       } else /* when in LE accessing the parameter page, keep APB in BE */
>
> The coding guidelines state that if you need braces around one branch
> of an if/else combination, you must use them on the other branch,
> also, even if the other branch is just one line.
>

Yes, I will add braces around in the next revision of this patch.

>>                 val &= ~IPROC_NAND_APB_LE_MODE;
>>
>>         brcmnand_writel(val, mmio);
>> --
>> 2.1.4
>>

Thanks,

Ray
