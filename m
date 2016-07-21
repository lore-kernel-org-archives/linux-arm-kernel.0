From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 21 Jul 2016 11:50:42 +0100
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <20160721103120.GB20559@leverpostej>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej> <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej>
Message-ID: <5790A902.6070601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/16 11:31, Mark Rutland wrote:
[...]
>>>> +
>>>> +> > 	> > if (*p == 0)
>>>> +> > 	> > 	> > return 0;
>>>> +
>>>> +> > 	> > errno = 0;
>>>> +
>>>> +> > 	> > v = strtoull(p, NULL, 0);
>>>> +
>>>> +> > 	> > if (errno)
>>>> +> > 	> > 	> > return 0;
>>>> +
>>>> +> > 	> > return v;
>>>> +}
>>>
>>> It looks like the purgatory code expects angel SWI as the earlycon,
>>
>> Maybe you saw the debug_brk macro in entry.S?  I should remove
>> that and just loop.
> 
> Ah, sorry. For some reason I got that confused with the sink code. My
> bad.
> 
> Now I see that's assuming an 8-bit MMIO register.
> 
>>> whereas many other earlycons exist (with pl011 being extremely popular).
>>> Regardless, if we assume a particular UART type, we should explicitly
>>> verify that here. Otherwise the purgatory code will likely bring down
>>> the system, and it will be very painful to debug.
>>>
>>> Please explicitly check for the supported earlycon name.
>>
>> Purgatory just writes bytes to the address given.  Are there
>> UARTs that don't have TX as the first port?
> 
> I'm not sure, but it's certainly possible. The generic earlycon binding
> doesn't guarantee that the first address is a TX register. Even if they
> don't exist today, they could in a month's time, so I don't think we
> should assume anything.

The Exynos UART (drivers/tty/serial/samsung.c) is one which comes to
mind as definitely existing, and on arm64 systems to boot. The TX
register is at offset 0x20 there.

Robin.
