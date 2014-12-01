From: monstr@monstr.eu (Michal Simek)
Date: Mon, 01 Dec 2014 15:24:36 +0100
Subject: [PATCH v4 5/6] ARM: zynq: Add OCM controller driver
In-Reply-To: <CACRpkdbL=yOwjC7j=eacg9K2Mb3rwcKy3b0F8y2H9Nz8RsRRcg@mail.gmail.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>	<6741d995fbec801d795c5db481e39425bd912f8a.1415962281.git.michal.simek@xilinx.com>	<CACRpkdbZ8Pwy=04dhJq5ONZ1B-SQK1f=eLZjjCDmV7UQ0aHduA@mail.gmail.com>	<857cab03bd6445c59cc345349a00f67c@BL2FFO11FD010.protection.gbl>
 <CACRpkdbL=yOwjC7j=eacg9K2Mb3rwcKy3b0F8y2H9Nz8RsRRcg@mail.gmail.com>
Message-ID: <547C7A24.8090403@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2014 04:35 PM, Linus Walleij wrote:
> On Thu, Nov 27, 2014 at 2:57 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 11/27/2014 02:20 PM, Linus Walleij wrote:
>>> On Fri, Nov 14, 2014 at 11:52 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>>> (...)
>>>> +       zynq_ocmc->pool = devm_gen_pool_create(&pdev->dev,
>>>> +                                              ilog2(ZYNQ_OCMC_GRANULARITY),
>>>> +                                              -1);
>>>
>>> Do this:
>>>
>>> #include <linux/sizes.h>
>>>
>>> zynq_ocmc->pool = devm_gen_pool_create(&pdev->dev,
>>>                                        ilog2(SZ_64K),
>>>                                        -1);
>>>
>>> And get rid of the #define for ZYNQ_OCMC_GRANULARITY
>>
>> ilog2 from 32 is different to ilog2 from ilog2 from 0x10000.
> 
> Bah I misread the code, forget this comment.
> 
> Maybe it's more like I wanted
> 
> +#define ZYNQ_OCMC_BLOCK_SIZE   0x10000
> 
> To be replaced with SZ_64K
> 
> But it's a petty detail anyway.

I have fixed it.

>> Do you have any opinion regarding calling zynq_slcr_get_ocm_config()?
>>
>> Is it better to expose slcr this interface to drivers?
>> Or use regmap and read this value directly?
> 
> Depends on what provides that call. The pattern I usually follow
> is to expose the mixed-registers range as a syscon device
> using drivers/mfd/syscon.c and then use one of the methods from
> <linux/mfd/syscon.h> to look up a reference to the regmap and
> use it to access misc registers.

I have tried it and I can just use it without any problem.
I have sent v5 with origin version but in cover letter there
is a code for that.


>> Also I do read for CONFIG_SMP case jump trampoline size - maybe
>> you can have better idea how this can be done.
> 
> No I have no clue about that... :(

ok - fair enough. One option is to keep it as is. The second
option is to allocate any hardcoded size or size passed via DT.
But run-time detection is the best IMHO.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/b338bd77/attachment.sig>
