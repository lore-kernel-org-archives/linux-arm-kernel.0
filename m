From: dgilbert@interlog.com (Douglas Gilbert)
Date: Tue, 26 Mar 2013 17:09:59 -0400
Subject: [PATCH] rtc: rtc-at91rm9200: use a variable for storing IMR
In-Reply-To: <20130326192713.GA31628@localhost>
References: <1363369032-12639-1-git-send-email-nicolas.ferre@atmel.com>
 <20130326192713.GA31628@localhost>
Message-ID: <51520EA7.8090808@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-03-26 03:27 PM, Johan Hovold wrote:
> On Fri, Mar 15, 2013 at 06:37:12PM +0100, Nicolas Ferre wrote:
>> On some revisions of AT91 SoCs, the RTC IMR register is not working.
>> Instead of elaborating a workaround for that specific SoC or IP version,
>> we simply use a software variable to store the Interrupt Mask Register and
>> modify it for each enabling/disabling of an interrupt. The overhead of this
>> is negligible anyway.
>
> The patch does not add any memory barriers or register read-backs when
> manipulating the interrupt-mask variable. This could possibly lead to
> spurious interrupts both when enabling and disabling the various
> RTC-interrupts due to write reordering and bus latencies.
>
> Has this been considered? And is this reason enough for a more targeted
> work-around so that the SOCs with functional RTC_IMR are not affected?

The SoCs in question use a single embedded ARM926EJ-S and
according to the Atmel documentation, that CPU's instruction
set contains no barrier (or related) instructions.

In the arch/arm/mach-at91 sub-tree of the kernel source
I can find no use of the wmb() call. Also checked all drivers
in the kernel containing "at91" and none called wmb().

Doug Gilbert
