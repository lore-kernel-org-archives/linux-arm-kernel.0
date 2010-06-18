From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Jun 2010 16:12:41 +0800
Subject: [PATCH 02/25] pxa3xx_nand: introduce common timing to reduce read
	id times
In-Reply-To: <AANLkTikbzXgwMvnNVRkcOO-9El9hmAXhKZK_dFgStbwY@mail.gmail.com>
References: <AANLkTim1qcVoqSS7T8bE0Vsu6phC2iY_Ok671WYHcD0z@mail.gmail.com>
	<AANLkTil6QDRdh3s63J9Mm-B1qjMcnYjEEm-W5lC1NXVb@mail.gmail.com>
	<AANLkTikbzXgwMvnNVRkcOO-9El9hmAXhKZK_dFgStbwY@mail.gmail.com>
Message-ID: <AANLkTikDDFYY65l5YYGW3a0O2bWDyKRO6VRb15aaFtF7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> - ? ? ? if (f->page_size != 2048 && f->page_size != 512)
>>> - ? ? ? ? ? ? ? return -EINVAL;
>>> -
>>> - ? ? ? if (f->flash_width != 16 && f->flash_width != 8)
>>> - ? ? ? ? ? ? ? return -EINVAL;
>>> -
>>
>> I do think these are sanity check, that's useful to prevent incorrectly defined
>> data (esp. coming from board code). Can we define the loose flash type as:
>>
>>> ?static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
>>> + ? ? ? { ?0x0000, ? 0, ? ?512, ?8, ?8, ? ?0, &timing[0], },
>>> + ? ? ? { 0x46ec, ?32, ?512, 16, 16, 4096, &timing[1], },
>>> + ? ? ? { 0xdaec, ?64, 2048, ?8, ?8, 2048, &timing[1], },
>>
>> with a comment of /* default flash type to detect ID */?
>>
>> My understanding is the minimum requirement to detect the NAND ID is a
>> loose timing and 512 small page, 8-bit wide bus, so with a chip_id being
>> 0x0000, that should be enough to tell it's a special flash type to detect ID.
>
> There is no need to add the flash page size and bus width for the
> common timing, or loose timing...
> For the chip identification only need reset and read id command, and
> reset and read id command only care
> for the first command in NDCB0 and the timing setting in NDTR0CS0 and
> NDTR1CS0, the page size is not useful
> here and could make confussion if give such definition...

I know, but I'd like to keep the checking of page_size, and flash_width,
if you take a look into the rest of the code how much it is assumed that
page_size being either 2048 or 512, flash_width being 8 or 16, you'll
know why such an error checking here is mandatory actually.

>>
>>> ? ? ? ?/* calculate flash information */
>>> ? ? ? ?info->oob_size = (f->page_size == 2048) ? 64 : 16;
>>> ? ? ? ?info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
>>> @@ -976,36 +973,27 @@ static int pxa3xx_nand_detect_flash(struct
>>> pxa3xx_nand_info *info,
>>> ? ? ? ? ? ? ? ?if (pxa3xx_nand_detect_config(info) == 0)
>>> ? ? ? ? ? ? ? ? ? ? ? ?return 0;
>>>
>>> - ? ? ? for (i = 0; i<pdata->num_flash; ++i) {
>>> - ? ? ? ? ? ? ? f = pdata->flash + i;
>>> -
>>> - ? ? ? ? ? ? ? if (pxa3xx_nand_config_flash(info, f))
>>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>>> -
>>> - ? ? ? ? ? ? ? if (__readid(info, &id))
>>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>>> -
>>> - ? ? ? ? ? ? ? if (id == f->chip_id)
>>> - ? ? ? ? ? ? ? ? ? ? ? return 0;
>>> - ? ? ? }
>>> -
>>> - ? ? ? for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {
>>> -
>>> - ? ? ? ? ? ? ? f = &builtin_flash_types[i];
>>> -
>>> - ? ? ? ? ? ? ? if (pxa3xx_nand_config_flash(info, f))
>>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>>> -
>>> - ? ? ? ? ? ? ? if (__readid(info, &id))
>>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>>> -
>>> - ? ? ? ? ? ? ? if (id == f->chip_id)
>>> + ? ? ? f = &builtin_flash_types[0];
>>> + ? ? ? pxa3xx_nand_config_flash(info, f);
>>> + ? ? ? if (__readid(info, &id))
>>> + ? ? ? ? ? ? ? goto fail_detect;
>>> +
>>> + ? ? ? for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
>>> + ? ? ? ? ? ? ? if (i < pdata->num_flash)
>>> + ? ? ? ? ? ? ? ? ? ? ? f = pdata->flash + i;
>>> + ? ? ? ? ? ? ? else
>>> + ? ? ? ? ? ? ? ? ? ? ? f = &builtin_flash_types[i - pdata->num_flash + 1];
>>
>> This looks a bit tricky and difficult to read, can you improve the
>> readability here?
>
> The chip id identification logic here is changed in latter patch in
> this patch set...
> If from the last patch of view, does this part looks better?
>

Not sure, I'd rather this being separated into two loops if that helps
readability.

>>
>>> + ? ? ? ? ? ? ? if (f->chip_id == id) {
>>> + ? ? ? ? ? ? ? ? ? ? ? dev_info(&info->pdev->dev, "detect chip id: 0x%x\n", id);
>>> + ? ? ? ? ? ? ? ? ? ? ? pxa3xx_nand_config_flash(info, f);
>>> ? ? ? ? ? ? ? ? ? ? ? ?return 0;
>>> + ? ? ? ? ? ? ? }
>>> ? ? ? ?}
>>>
>>> ? ? ? ?dev_warn(&info->pdev->dev,
>>> - ? ? ? ? ? ? ? ?"failed to detect configured nand flash; found %04x instead of\n",
>>> + ? ? ? ? ? ? ? ? ? ? ? "failed to detect configured nand flash; found %04x instead of\n",
>>> ? ? ? ? ? ? ? ? id);
>>> +fail_detect:
>>> ? ? ? ?return -ENODEV;
>>> ?}
>>>
>>
>> I'm generally OK with the idea.
>>
> Best regards,
> Lei
>
