From: monstr@monstr.eu (Michal Simek)
Date: Tue, 14 May 2013 09:49:41 +0200
Subject: [PATCH] net/macb: fix ISR clear-on-write behavior only for some
 SoC
In-Reply-To: <5191E855.5090908@yahoo.es>
References: <1368461105-23128-1-git-send-email-nicolas.ferre@atmel.com>
 <FE065E51-1EAA-47ED-8C7B-0F2E6418F349@jcrosoft.com>
 <51918C23.7040106@yahoo.es> <20130514055256.GD22508@game.jcrosoft.org>
 <5191E53B.9000106@yahoo.es>
 <C35C1E42-FCD6-4EE7-902B-FE01F362CD40@jcrosoft.com>
 <5191E855.5090908@yahoo.es>
Message-ID: <5191EC95.2020704@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 09:31 AM, Hein Tibosch wrote:
> On 5/14/2013 3:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On May 14, 2013, at 3:18 PM, Hein Tibosch <hein_tibosch@yahoo.es> wrote:
>>
>>> On 5/14/2013 1:52 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> On 08:58 Tue 14 May     , Hein Tibosch wrote:
>>>>> On 5/14/2013 12:05 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>> On May 14, 2013, at 12:05 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>>>>>>
>>>>>>> Commit 749a2b6 (net/macb: clear tx/rx completion flags in ISR)
>>>>>>> introduces clear-on-write on ISR register. This behavior is not always
>>>>>>> implemented when using Cadence MACB/GEM and is breaking other platforms.
>>>>>>> We are using a new Device Tree compatibility string and a capability
>>>>>>> property to actually activate this clear-on-write behavior on ISR.
>>>>>>>
>>>>>>> Reported-by: Hein Tibosch <hein_tibosch@yahoo.es>
>>>>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>>>> can we detect it via the IP?
>>>>> This was my first proposal, have it based on the value of MACB's
>>>>> register 'MID' (offset 0x00fc, lower 16 bits).
>>>>> On avr32 it reads: 0x0000010D, on Zynq it reports 0x00000119
>>>>>
>>>>> So for the moment, CAPS_ISR_CLEAR_ON_WRITE could be set if the revision
>>>>> equals to 0x00000119?
>>>> so no it will not work
>>>>
>>>> as the gem on sama5 is 00020119
>>>>
>>>> so version 0x119 too
>>>>
>>>> nico
>>> All right, that's a pity.
>>>
>>> The only issue that remains then is the obligation to use CONFIG_OF,
>>> or:
>>>
>>> +#if defined(CONFIG_OF)
>>> +	dev_id = of_match_device(macb_dt_ids, &pdev->dev);
>>> +	if (dev_id)
>>> +		bp->caps = (u32)dev_id->data;
>>> +
>>> +#endif
>>>
>>> ?
>> no need as of_match_device is a inline of !OF
> Sorry, here's the complete compiler error:
> drivers/net/ethernet/cadence/macb.c: In function 'macb_probe':
> drivers/net/ethernet/cadence/macb.c:1601: error: 'macb_dt_ids' undeclared (first use in this function)
> 
> Earlier, 'macb_dt_ids' is only defined when using OF

The trick is in using of_match_ptr. It means remove that CONFIG_OF around macb_dt_ids too.

[linux-2.6.x]$ grep -rn "of_match_ptr" include/linux/
include/linux/of.h:314:#define of_match_ptr(_ptr)	(_ptr)
include/linux/of.h:508:#define of_match_ptr(_ptr)	NULL

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130514/d32093e6/attachment-0001.sig>
