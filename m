From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 09 Jun 2014 13:47:42 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406081138070.25775@knanqh.ubzr> (Nicolas
 Pitre's message of "Sun, 8 Jun 2014 13:53:43 -0400 (EDT)")
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406081138070.25775@knanqh.ubzr>
Message-ID: <7hsindq07l.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

> On Sun, 8 Jun 2014, Lorenzo Pieralisi wrote:
>
>> On Sun, Jun 08, 2014 at 12:53:34AM +0100, Olof Johansson wrote:
>> > Lorenzo,
>> > 
>> > Since you're emailing from @arm.com, some of this is to the wider
>> > recipient and maybe not directly to you:
>> 
>> I am glad to reply and take blame since this is a debate definitely worth
>> having.
>
> Great.  Because I would like to steer this debate a little towards the 
> genuine cause rather than sticking to some particular consequences.
>
>> Guys, do not get me wrong here. There are fixes that can be deemed
>> acceptable in an OS, there are fixes that can't. I just can't help thinking
>> that Nicolas' patch is a nasty hack (and I am far, really really far from
>> blaming him for that, because that's the only patch that can fix that
>> issue in the kernel), and he perfectly knows that.
>
> You know what?  The more I think about my patch, the more I consider 
> this should be the standard way of setting up things unconditionally on 
> _all_ platforms using MCPM.  Why? Because that's the most coherent thing 
> to do!

I agree.

> I really think the kernel should either be responsible for the CCI or it 
> should not at all.  And conversely for the bootloader.  Right now we 
> have an implicit requirement that the bootloader should turn on the CCI, 
> but only for cold boot, and only for the boot cluster, and not for CPU 
> resuming from idle, and what other case we haven't thought about yet.  
> And as noticed this requirement is not documented.

In addition to being a firmware minimalist like Nico, what I find most
objectional to the bootloader approach is that even with CCI enabled by
the firmware, since it's a runtime requirement (for low-power idle or
suspend), the kernel has to handle it anyways.  So you end up with a
partial solution in the firwmare (for boot cluster only) *and* a full
solution in the kernel.  This doesn't make any sense, expecially because
the kernel might then have to do things differently on cold boot
vs. low-power idle/suspend or differently on the boot cluster vs. other
clusters.  From a maintenance PoV, this is a mess and could easily lead
to just as many SoC specific hacks that are different across platforms.

Stated more simply: If the kernel has to manage the resource at runtime
due to low-power idle/suspend.  I don't see any reason why it shouldn't
manage it at cold boot time also.

Kevin
