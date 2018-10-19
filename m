From: liang.yang@amlogic.com (Liang Yang)
Date: Fri, 19 Oct 2018 16:30:48 +0800
Subject: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <20181019101033.0a160506@bbrezillon>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018213308.3f8a5279@bbrezillon>
 <09f76f17-05c4-d9e0-0167-f68e224f00c4@amlogic.com>
 <20181019101033.0a160506@bbrezillon>
Message-ID: <3e462d23-a100-6eb2-3740-abe2373a8e15@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/10/19 16:10, Boris Brezillon wrote:
> On Fri, 19 Oct 2018 15:29:05 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>>> How about defining that the HW returns an array of __le64 instead and then
>>> define the following macros which you can use after converting in the
>>> CPU endianness
>>>
>>> #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * (1 + y)) & GENMASK(7, 0))
>>> #define ECC_COMPLETE			BIT(31)
>>> #define ECC_ERR_CNT(x)			(((x) >> 24) & GENMASK(5, 0))
>>>
>>> (I'm not entirely sure the field positions are correct, but I'll let you
>>> check that).
>>>    
>> ok. i think it should be:
>>
>> #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * y) &
>> GENMASK(7, 0))
>>
>> if x represents the u64 and y represents the index of the u64.
> 
> Absolutely.
> 
>>
>>
>>
>>>> +
>>>> +#define PER_INFO_BYTE	(sizeof(struct meson_nfc_info_format))
>>>> +
>>>> +struct meson_nfc_nand_chip {
>>>> +	struct list_head node;
>>>> +	struct nand_chip nand;
>>>> +	bool is_scramble;
>>>
>>> I think I already mentioned the NAND_NEED_SCRAMBLING flag []. Please
>>> drop this field and test (chip->flags & NAND_NEED_SCRAMBLING) instead.
>>>    
>> em, i use NAND_NEED_SCRAMBLING and is_scramble is set:
>> static int meson_nand_attach_chip(struct nand_chip *nand)
>> {
>> 	......
>> 	meson_chip->is_scramble =
>> 		(nand->options & NAND_NEED_SCRAMBLING) ? 1 : 0;
>> 	......
>> }
> 
> Why do you need to add a new field then? Just test
> nand->options & NAND_NEED_SCRAMBLING directly or provide a helper
> function that does that.
> 
ok, i will fix it.
> .
> 
