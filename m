From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 20:04:28 -0600
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <52427C15.6010204@yahoo.com.au>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org> <52427C15.6010204@yahoo.com.au>
Message-ID: <524B7F2C.9080105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2013 12:00 AM, Craig McGeachie wrote:
> On 09/24/2013 03:38 PM, Stephen Warren wrote:
>>> +#define BAD_IRQ_NUM    -1
>>
>> That should be 0; Using -1 for invalid IRQ is deprecated.
> 
> Could you please point me to something that describes this? I can't find
> anything that limits the internal representations used by the driver for
> an interrupt controller.  That, and the design of
> include/linux/irqdomain.h and kernel/irq/irqdomain.c implies that a
> 0-based hwirq numbering scheme is the natural order of things.

I suppose there isn't any limitation on the driver-internal
representation, so this is OK from that perspective. I'd still prefer if
this constant simply weren't needed, just like it isn't in the current
code, simply because the entire range of hwirq numbers is valid, so
there's no need for a sparse lookup table, and hence no concept of an
invalid ID. The only exception would be if you're trying to align the
hwirq numbers with that FIQ register, and there truly are some invalid
values in the FIQ numbering scheme?
