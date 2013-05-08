From: nerv@dawncrow.de (=?ISO-8859-1?Q?Andr=E9_Hentschel?=)
Date: Wed, 08 May 2013 19:41:28 +0200
Subject: [PATCHv3] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
In-Reply-To: <20130508085753.GA15568@mudshark.cambridge.arm.com>
References: <51896934.5080803@dawncrow.de>
 <20130508085753.GA15568@mudshark.cambridge.arm.com>
Message-ID: <518A8E48.2080801@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

thx for having a look.

Am 08.05.2013 10:57, schrieb Will Deacon:> Hi Andre,
> 
> On Tue, May 07, 2013 at 09:51:00PM +0100, Andr? Hentschel wrote:
>> From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
> 
> Might just be my mailer, but you should check that your name is intact here
> otherwise the git log will be mangled.

That's for my acute accent and already worked with my first linux patch, it's git generated.

>> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed to
>> prevent it from being used as a covert channel between two tasks.
>>
>> There are more and more applications coming to WinRT, Wine could support them,
>> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
>>
>> This patch preserves that register per thread instead of clearing it.
>> Unlike the TPIDRURO, which is already switched, the TPIDRURW
>> can be updated from userspace so needs careful treatment in the case that we
>> modify TPIDRURW and call fork(). To avoid this we must always read
>> TPIDRURW in copy_thread.
>>
>> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com> 
> 
> [...]
> 
>> diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
>> index 73409e6..22756ab 100644
>> --- a/arch/arm/include/asm/tls.h
>> +++ b/arch/arm/include/asm/tls.h
>> @@ -2,27 +2,30 @@
>>  #define __ASMARM_TLS_H
>>  
>>  #ifdef __ASSEMBLY__
>> -	.macro set_tls_none, tp, tmp1, tmp2
>> +#include <asm/asm-offsets.h>
>> +	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
>>  	.endm
>>  
>> -	.macro set_tls_v6k, tp, tmp1, tmp2
>> +	.macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
>> +	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
>>  	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
>> -	mov	\tmp1, #0
>> -	mcr	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
>> +	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
>> +	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
> 
> Why is this conditional?


Seems like a copy&paste one, i'll send a v4
