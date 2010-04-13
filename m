From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 13 Apr 2010 09:42:55 +0200
Subject: [PATCH] AT91: at91sam9g10 chip identification changed
In-Reply-To: <1270115336-19488-1-git-send-email-nicolas.ferre@atmel.com>
References: <1270115336-19488-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <l2ocd73a99e1004130042qfe9aba83l512a0fad50112d19@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Nicolas,

> A bit in the at91sam9g10 identification number changed between Engineering
> Sample and final product. This patch will identify both as being at91sam9g10.

> -#define ARCH_ID_AT91SAM9G10 ? ?0x819903a0
> +#define ARCH_ID_AT91SAM9G10 ? ?0x019903a0

> -#define cpu_is_at91sam9g10() ? (at91_cpu_identify() == ARCH_ID_AT91SAM9G10)
> +#define cpu_is_at91sam9g10() ? ((at91_cpu_identify() & ~AT91_CIDR_EXT) == ARCH_ID_AT91SAM9G10)


Wouldn't it be better to just mask out the AT91_CIDR_EXT bit in
at91_cpu_identify()?
That bit isn't really useful for "version" information.

We'd then just need to modify:
  #define ARCH_ID_AT91SAM9G10          0x019903a0
  #define ARCH_ID_AT91SAM9G45          0x019b05a0
  #define ARCH_ID_AT91SAM9G45MRL  0x019b05a2      /* aka 9G45-ES2 &
non ES lots */
  #define ARCH_ID_AT91SAM9G45ES     0x019b05a1      /* 9G45-ES
(Engineering Sample) */
(ie, drop bit AT91_CIDR_EXT)


Regards,
  Andrew Victor
