From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Mon, 13 Nov 2017 10:30:40 +0000
Subject: [PATCH v5 2/2] crypto: stm32 - Support for STM32 CRYP crypto
 module
In-Reply-To: <d924a278-90d0-969e-f1ae-a12f92e8972d@st.com>
References: <1508425830-13565-1-git-send-email-fabien.dessenne@st.com>
 <1508425830-13565-3-git-send-email-fabien.dessenne@st.com>
 <20171022072659.GB8489@Red> <d924a278-90d0-969e-f1ae-a12f92e8972d@st.com>
Message-ID: <774a92f2-af70-0424-b066-0cc1db3f9ab0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

Can you check if this patchset (removed the AEAD part as you suggested + 
libkcapi test OK as suggested by Corentin) can be applied now?

BR

Fabien


On 07/11/17 15:40, Fabien DESSENNE wrote:
>
> On 22/10/17 09:26, Corentin Labbe wrote:
>> On Thu, Oct 19, 2017 at 05:10:30PM +0200, Fabien Dessenne wrote:
>>> This module registers block cipher algorithms that make use of the
>>> STMicroelectronics STM32 crypto "CRYP1" hardware.
>>> The following algorithms are supported:
>>> - aes: ecb, cbc, ctr
>>> - des: ecb, cbc
>>> - tdes: ecb, cbc
>>>
>>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
>>> ---
>>>    drivers/crypto/stm32/Kconfig      |    9 +
>>>    drivers/crypto/stm32/Makefile     |    3 +-
>>>    drivers/crypto/stm32/stm32-cryp.c | 1172 +++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 1183 insertions(+), 1 deletion(-)
>>>    create mode 100644 drivers/crypto/stm32/stm32-cryp.c
>>>
>>> diff --git a/drivers/crypto/stm32/Kconfig b/drivers/crypto/stm32/Kconfig
>>> +static void stm32_cryp_irq_write_block(struct stm32_cryp *cryp)
>>> +{
>>> +	unsigned int i, j;
>>> +	u32 *src;
>>> +	u8 d8[4];
>>> +
>>> +	src = sg_virt(cryp->in_sg) + _walked_in;
>>> +
>>> +	for (i = 0; i < cryp->hw_blocksize / sizeof(u32); i++) {
>>> +		if (likely(cryp->total_in >= sizeof(u32))) {
>>> +			/* Write a full u32 */
>>> +			stm32_cryp_write(cryp, CRYP_DIN, *src);
>> Hello
>>
>> Try also to test your driver with userspace via AF_ALG (libkcapi is a good start).
>> It should probably crash here.
>> I have do the same on my first sunxi-ss driver and you should use kmap().
>>
>> Regards
> Hi Corentin,
>
> Thank you for suggesting to test from userspace through the AF_ALG
> socket with libkcapi.
> This increases my test coverage.
>
> I ran the miscellaneous tests (kcapi-enc-test(large).sh + test.sh) and
> could not observe any crash.
> Note that I had already fixed some 'memory crashes' while testing with
> testmgr / tcrypt while testing from the kernel.
>
> So it looks like the proposed implementation is fine.
>
> BR
>
> Fabien
