From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 11 Jun 2014 11:24:41 +0800
Subject: [PATCH] mtd: atmel_nand: make ecc parameters same as definition
In-Reply-To: <53958CCE.5080307@atmel.com>
References: <1402041728-12056-1-git-send-email-voice.shen@atmel.com>
 <53958CCE.5080307@atmel.com>
Message-ID: <5397CBF9.800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On 06/09/2014 06:30 PM, Josh Wu wrote:
> Hi, Bo
>
> Thanks for the patch.
>
> On 6/6/2014 4:02 PM, Bo Shen wrote:
>> If the ecc parameter is not the same as definition, when the
>> mtd core check these parameters, it will give the unexpected
>> result.
> Could you be more specific to tell what kind of result will happened?

For example:
When try to calculate how many bits can correct in one page according to 
the definition, it will give the wrong result.

one page correct bits = (mtd->writesize * ecc->strength) / ecc->size;

take the following use case as an example:
mtd->writesize = 2048 bytes,
ecc->strength = 4 bytes, (for 512 bytes)

before this patch, the ecc->size = 2048, so the result is 4 bytes.

after this patch, the ecc->size = 512, so the result is 16 bytes.

The maximum correct bytes is 16 bytes while not 4 bytes. So, if not align

Best Regards,
Bo Shen
