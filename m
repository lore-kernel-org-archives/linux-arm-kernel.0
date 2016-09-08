From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Thu, 8 Sep 2016 10:22:43 +0530
Subject: [RFC PATCH 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <20160906154809.GA7012@localhost.localdomain>
References: <1472820817-21874-1-git-send-email-andrei.pistirica@microchip.com>
 <20160906154809.GA7012@localhost.localdomain>
Message-ID: <CAFcVECJxJgJUeO4=yudwTj5NkxDob5tCZaom9YTqWWmtt7ajFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 6, 2016 at 9:18 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
>
<snip>
>> +#define GEM_TISUBN           0x01bc /* 1588 Timer Increment Sub-ns */
>
> This regsiter does not exist.  Looking at
>
>    Zynq-7000 AP SoC Technical Reference Manual
>    UG585 (v1.10) February 23, 2015
>
> starting on page 1273 we see:
>
> udp_csum_errors 0x000001B0 32 ro    0x00000000 UDP checksum error
> timer_strobe_s  0x000001C8 32 rw    0x00000000 1588 timer sync strobe seconds
> timer_strobe_ns 0x000001CC 32 mixed 0x00000000 1588 timer sync strobe nanoseconds
> timer_s         0x000001D0 32 rw    0x00000000 1588 timer seconds
> timer_ns        0x000001D4 32 mixed 0x00000000 1588 timer nanoseconds
> timer_adjust    0x000001D8 32 mixed 0x00000000 1588 timer adjust
> timer_incr      0x000001DC 32 mixed 0x00000000 1588 timer increment
>
> There is no register at 0x1BC.
>
>> +#define GEM_TSH                      0x01c0 /* 1588 Timer Seconds High */
>
> This one doesn't exist either.  What is going on here?

I cant be sure of the version of Cadence GEM used in SAMA5D2
but these registers (sub ns increments alteast) only exist in
the IP version used in Zynq Ultrascale+ MPSoC.

<snip>
>> +     /* get GEM internal time */
>> +     sech = gem_readl(bp, TSH);
>> +     secl = gem_readl(bp, TSL);
>
> Does reading TSH latch the time?  The TRM is silent about that, and
> most other designs latch on reading the LSB.

No, it does not latch the time.
When doing a read + adjust + write, this will
mean there's room for some error.

Although when writing, the write to MSB and LSB registers
was made atomic. This bug fix came only in the
most recent version of the IP, am afraid.

Regards,
Harini
