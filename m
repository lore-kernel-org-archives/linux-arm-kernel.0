From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 8 Oct 2011 20:43:23 +0800
Subject: [PATCH 13/26] ARM: pxa: use correct __iomem annotations
In-Reply-To: <201110071216.50783.arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-14-git-send-email-arnd@arndb.de>
	<CAMPhdO_CGvoc8GZQS3TWpv0gqOXhmHyEbamcQr28K5iLgOBnuw@mail.gmail.com>
	<201110071216.50783.arnd@arndb.de>
Message-ID: <CAMPhdO-KZPh68ZcDwpx6nMif+CgNyNFB+rQDu9horQw+-3CnAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 7, 2011 at 6:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 07 October 2011, Eric Miao wrote:
>> > @@ -18,11 +24,11 @@
>> > ?* peripherals on APB, let's count it into the ABP mapping area.
>> > ?*/
>> > ?#define APB_PHYS_BASE ? ? ? ? ?0xd4000000
>> > -#define APB_VIRT_BASE ? ? ? ? ?0xfe000000
>> > +#define APB_VIRT_BASE ? ? ? ? ?IOMEM(0xfe000000)
>>
>> To be honest, I'd really like to keep the *_VIRT_BASE definitions to be
>> type independent.
>>
>> And have the actual register definitions to be casted to void __iomem *
>> when being defined, e.g.
>>
>> #define APBC_REG(x) ? ? IOMEM(APBC_VIRT_BASE + (x))
>>
>> #define APBC_UART1 ? ? ?APBC_REG(0x000)
>>
>> Arnd, do we have some standard guidelines on this for all SoCs
>> to follow? As I know, it's currently still being a mess.
>
> We don't have any formal guidelines yet, but I'd really love to get
> rid of all the arbitrary type casts to make use of the built-in
> type checking of the compiler and sparse. A virtual base address
> for registers is conventionally an __iomem pointer, so defining it
> as something else is completely bogus. I have started making patches
> for a number of platforms for this.
>
> Ideally we should have very little code directly using, but the fact
> is that they are there and we won't remove them all anytime soon, so
> we should at least use the correct types here.
>
> Another issue that goes together with this is that right now our
> readl/writel macros accept any input type (pointer, __iomem pointer,
> unsigned long, unsigned int), and I have a patch to make that stricter
> but that requires fixing up all the places where we do a
> readl(APBC_VIRT_BASE + x) that Russell mentioned.
>
> The only place where this requires adding extra type casts right now is
> the iotable setup, which I hope we can also fix eventually by splitting
> the static I/O mapping setup from other static mappings (MT_MEMORY,
> MT_MEMORY_NONCACHED, ...).

Sounds fair enough. Applied.
