From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 14 Apr 2010 10:14:47 +0200
Subject: [PATCH] AT91: at91sam9g10 chip identification changed
In-Reply-To: <l2ocd73a99e1004130042qfe9aba83l512a0fad50112d19@mail.gmail.com>
References: <1270115336-19488-1-git-send-email-nicolas.ferre@atmel.com>
	<l2ocd73a99e1004130042qfe9aba83l512a0fad50112d19@mail.gmail.com>
Message-ID: <4BC57977.7000705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/04/2010 09:42, Andrew Victor :
> hi Nicolas,
> 
>> A bit in the at91sam9g10 identification number changed between Engineering
>> Sample and final product. This patch will identify both as being at91sam9g10.
> 
>> -#define ARCH_ID_AT91SAM9G10    0x819903a0
>> +#define ARCH_ID_AT91SAM9G10    0x019903a0
> 
>> -#define cpu_is_at91sam9g10()   (at91_cpu_identify() == ARCH_ID_AT91SAM9G10)
>> +#define cpu_is_at91sam9g10()   ((at91_cpu_identify() & ~AT91_CIDR_EXT) == ARCH_ID_AT91SAM9G10)
> 
> 
> Wouldn't it be better to just mask out the AT91_CIDR_EXT bit in
> at91_cpu_identify()?
> That bit isn't really useful for "version" information.
> 
> We'd then just need to modify:
>   #define ARCH_ID_AT91SAM9G10          0x019903a0
>   #define ARCH_ID_AT91SAM9G45          0x019b05a0
>   #define ARCH_ID_AT91SAM9G45MRL  0x019b05a2      /* aka 9G45-ES2 &
> non ES lots */
>   #define ARCH_ID_AT91SAM9G45ES     0x019b05a1      /* 9G45-ES
> (Engineering Sample) */
> (ie, drop bit AT91_CIDR_EXT)

I do not think it is a good idea:
1/ a little issue appears with AT91SAM9G45ES that is using the
at91_cpu_fully_identify() functions.
2/ we do not exclude raising the extended bit after a chip has been
created to introduce a variant of this chip. If we mask out the
AT91_CIDR_EXT bit in at91_cpu_identify() we will not be able to identify
this new variant as being different from the original chip.

Best regards,
-- 
Nicolas Ferre
