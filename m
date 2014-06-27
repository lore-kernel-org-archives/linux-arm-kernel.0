From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 14:47:38 -0700
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627213051.GS32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
Message-ID: <CALCETrV5C2JosC_rtucQVg+U0bm8hFQFBTv3dz0it0a8iMCyrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 2:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jun 27, 2014 at 11:09:31PM +0200, Szabolcs Nagy wrote:
>> i thought the helpers in the kernel can avoid certain memory
>> barriers that the userspace has to do on armv6 for atomics
>> (and those barriers are deprecated on armv7 so i thought the
>> kuser page was better for portable binaries)
>
> The helpers are provided so that libc can be independent of the CPU
> facilities in the machine.  The key word there is _libc_, not
> applications.
>
> So, a libc can be built to support the lowest architecture that
> someone deems to support, and it may make use of the kuser helpers.
> If it does, then you have a libc which requires that the kuser
> helpers are always provided by the kernel, and the KUSER_HELPERS
> option must never be disabled.  If it is disabled, then the libc
> will be useless against that kernel.
>
> However, a libc built against modern architectures should not be
> making use of the kuser helpers.  We found last year that the
> Ubuntu 12.04 glibc did still make use of one kuser helper, and
> as such Ubuntu 12.04 also needs KUSER_HELPERS to remain enabled.
>
> The last combination is that the libc is built for modern architectures
> without needing any kuser helpers at all.  In this case - and only this
> case - the kernel's KUSER_HELPERS option can be disabled should the
> system integrator want to increase security.
>
>> > Due to that, any ARMv5 or earlier CPU will always have the kuser helper
>> > page.  ARMv6 and later may or may not have the kuser helper page, but
>> > there you're really building for a different ABI anyway (VFP-based) and
>> > you also know that you have the thread registers.
>>
>> so is it expected that the libc makes no attempt to provide
>> portable binary interface for armv5 and armv6?
>
> The libc interface that applications make use should not have any
> dependence on whether KUSER_HELPERS is enabled or disabled, the
> presence of that page should be totally invisible to applications.

As of right now, an x86_64 libc can have good performance on any
recent kernel and will work correctly on any kernel.  From what you're
saying, it sounds impossible to implement such a thing on ARM without
fiddling with /proc.

--Andy
