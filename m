From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Jun 2010 17:19:59 +0800
Subject: [PATCH 02/25] pxa3xx_nand: introduce common timing to reduce read
	id times
In-Reply-To: <AANLkTil6D3Cijy1JZ3aQLBGBfi99zOGDy5Xl8OmY_T_8@mail.gmail.com>
References: <AANLkTim1qcVoqSS7T8bE0Vsu6phC2iY_Ok671WYHcD0z@mail.gmail.com>
	<AANLkTil6QDRdh3s63J9Mm-B1qjMcnYjEEm-W5lC1NXVb@mail.gmail.com>
	<AANLkTikbzXgwMvnNVRkcOO-9El9hmAXhKZK_dFgStbwY@mail.gmail.com>
	<AANLkTikDDFYY65l5YYGW3a0O2bWDyKRO6VRb15aaFtF7@mail.gmail.com>
	<AANLkTil6D3Cijy1JZ3aQLBGBfi99zOGDy5Xl8OmY_T_8@mail.gmail.com>
Message-ID: <AANLkTimeJYwret1ZlEHaX_-T14qB3WteQwpn9y7_1Zo9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 5:15 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 4:12 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>>> - ? ? ? if (f->page_size != 2048 && f->page_size != 512)
>>>>> - ? ? ? ? ? ? ? return -EINVAL;
>>>>> -
>>>>> - ? ? ? if (f->flash_width != 16 && f->flash_width != 8)
>>>>> - ? ? ? ? ? ? ? return -EINVAL;
>>>>> -
>>>>
>>>> I do think these are sanity check, that's useful to prevent incorrectly defined
>>>> data (esp. coming from board code). Can we define the loose flash type as:
>>>>
>>>>> ?static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
>>>>> + ? ? ? { ?0x0000, ? 0, ? ?512, ?8, ?8, ? ?0, &timing[0], },
>>>>> + ? ? ? { 0x46ec, ?32, ?512, 16, 16, 4096, &timing[1], },
>>>>> + ? ? ? { 0xdaec, ?64, 2048, ?8, ?8, 2048, &timing[1], },
>>>>
>>>> with a comment of /* default flash type to detect ID */?
>>>>
>>>> My understanding is the minimum requirement to detect the NAND ID is a
>>>> loose timing and 512 small page, 8-bit wide bus, so with a chip_id being
>>>> 0x0000, that should be enough to tell it's a special flash type to detect ID.
>>>
>>> There is no need to add the flash page size and bus width for the
>>> common timing, or loose timing...
>>> For the chip identification only need reset and read id command, and
>>> reset and read id command only care
>>> for the first command in NDCB0 and the timing setting in NDTR0CS0 and
>>> NDTR1CS0, the page size is not useful
>>> here and could make confussion if give such definition...
>>
>> I know, but I'd like to keep the checking of page_size, and flash_width,
>> if you take a look into the rest of the code how much it is assumed that
>> page_size being either 2048 or 512, flash_width being 8 or 16, you'll
>> know why such an error checking here is mandatory actually.
>
> I know that the configure_flash function need to check page_size &
> flash_width to set the
> ndcr. But what the setting would not affect the reset/read id result anyway...
> For there is some chip has the same bytes in the first two bytes, I
> choose to always read out
> 4 bytes data when send read id command in latter patch of this patch set...
>

My understanding is that NAND READID will at least work with the assumption
of 512bytes/page and 8-bit wide bus, no matter how the NAND chips are
connected. (unless some one comes up with a insane design of using multiple
interlaced NAND chips of different types).

Again, assume the NAND controller is not initialized (register values being
garbage or all zero-ed), do you still think you can read out the ID without
letting it know the page size, bus width and etc?
