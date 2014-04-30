From: pekon@ti.com (Gupta, Pekon)
Date: Wed, 30 Apr 2014 10:59:33 +0000
Subject: [RFC 07/47] mtd: nand: stm_nand_bch: initialise the BCH Controller
In-Reply-To: <20140430102244.GK29462@lee--X1>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <1395735604-26706-8-git-send-email-lee.jones@linaro.org>
 <20980858CB6D3A4BAE95CA194937D5E73EAB5CB7@DBDE04.ent.ti.com>
 <20140430102244.GK29462@lee--X1>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAC6A35@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Lee Jones [mailto:lee.jones at linaro.org]
>>On Wed, 26 Mar 2014, Gupta, Pekon wrote:
[...]

>> >+	/* Reset and disable boot-mode controller */
>> >+	writel(BOOT_CFG_RESET, nandi->base + NANDBCH_BOOTBANK_CFG);
>> >+	udelay(1);
>> >+	writel(0x00000000, nandi->base + NANDBCH_BOOTBANK_CFG);
>>
>> Why using 'udelay' ?
>> Isn't there any status register which tells you that controller is reset / initialized ?
>> Or may be polling on NANDBCH_BOOTBANK_CFG may itself give you status.
>
>Documenation says:
>
>  "The soft reset bit has to be reset to ?0? to de-assert the soft
>   reset. The soft reset bit is expected to be asserted for at least
>   one clock cycle for proper reset"
>
That?s the hardware way of saying that 'enable the clock before applying reset'.
Clock is required to propagate reset-logic to flip-flops in pipeline, which do not get direct reset.

However that apart. You may safely drop udelay(1) because this 'udelay' is at
CPU side and won't guarantee anything about clocks at your controller side.
But I leave it to you as this delay is pretty small.


with regards, pekon
