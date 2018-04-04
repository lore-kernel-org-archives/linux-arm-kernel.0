From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2018 17:55:37 +0200
Subject: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
In-Reply-To: <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
 <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
Message-ID: <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2018 at 5:52 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/3/2018 6:29 PM, Palmer Dabbelt wrote:
>>
>
> Are we looking for something like this?

Yes, exactly, plus the same for write and in/out of course.

> diff --git a/inc
>  #ifndef readb
>  #define readb readb
> -static inline u8 readb(const volatile void __iomem *addr)
> -{
> -       return __raw_readb(addr);
> -}
> +#define readb(c)                               \
> +       ({ u8  __v;                             \
> +        __io_br();                             \
> +        __v = __raw_readb(c);                  \
> +        __io_ar();                             \
> +        __v; })
>  #endif

I would prefer leaving these as inline functions, but that's only
a cosmetic difference.

       Arnd
