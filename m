From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Jul 2017 17:14:57 +0200
Subject: [PATCH 04/12] ARM: sa1100/pxa: fix MTD_XIP build
In-Reply-To: <871sp7rvz4.fsf@belgarion.home>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155209.3250880-1-arnd@arndb.de>
 <871sp7rvz4.fsf@belgarion.home>
Message-ID: <CAK8P3a1aP0XnX+iM8L+OXCxonfE6pmN0+Kk6EVLNREkzme+YQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 5:53 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
> Hi Arnd,
>
>> -#define xip_irqpending()     (ICIP & ICMR)
>> +/* restored July 2017, this did not build since 2011! */
>> +
>> +#define ICIP                 io_p2v(0x40d00000)
>> +#define ICMR                 io_p2v(0x40d00004)
> Okay, I suppose the IO mapping is guaranteed to work, ie. io_p2v() is behaving
> correctly when xip_irqpending() is used, right ? I'm not challenging this, I'm
> just ensuring this _could_ work (if anybody had the silly idea to make it work
> again, and I admit I don't have that much courage).

Good thinking ;-)

I double-checked this and found that it is correct, and we still map that memory
in the same place in pxa_map_io().

>> +#define xip_irqpending()     readl(ICIP) & readl(ICMR)
> This is not strictly equivalent to (ICIP & ICMR), I would have put for priority
> reasons :
> +#define xip_irqpending()       (readl(ICIP) & readl(ICMR))

Ok, I've changed that and will resend.

      Arnd
