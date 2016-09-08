From: zhichang.yuan02@gmail.com (zhichang)
Date: Thu, 8 Sep 2016 18:04:31 +0800
Subject: [PATCH V2 4/4] ARM64 LPC: support earlycon for UART connected to
 LPC
In-Reply-To: <4291379.IHAA72aKCk@wuerfel>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473255233-154297-5-git-send-email-yuanzhichang@hisilicon.com>
 <4291379.IHAA72aKCk@wuerfel>
Message-ID: <57D137AF.9070306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd,

On 2016?09?07? 22:52, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 9:33:53 PM CEST Zhichang Yuan wrote:
>> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
>>
>> This patch support the earlycon for UART connected to LPC on Hip06.
>> This patch is depended on the LPC driver.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>
> 
> I'm skeptical about this too. Is this just needed because the 8250
> earlycon support comes before the lpc bus initialization?
I think you wonder why early_serial8250_setup can not be used direclty for this earlycon of LPC uart.

1. the earlycon kernel parameter format of LPC uart is different from 8250. something like that
"earlycon=hisilpcuart,mmio,0xa01b0000,0,0x2f8". You see, there is one more parameter after the baudrate.
Hip06 LPC uart need two base addresses for earlycon.
2. the IO type is mmio to introduce a memory base address to access LPC register file. But the real uart
IO type is UPIO_PORT. This is spcial...

3. Just as your guess, earlycon should be earlier than lpc initialization.

Best,
Zhichang

> 
> Could we start the LPC driver earlier to work around that?
> 
> 	Arnd
> 
