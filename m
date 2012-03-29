From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 29 Mar 2012 17:33:49 -0500
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <20120324073207.GD5812@mwesterb-mobl.ger.corp.intel.com>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
 <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48EEB@AUSP01VMBX24.collaborationhost.net>
 <20120324073207.GD5812@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F002069702575E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 24, 2012 12:32 AM, Mika Westerberg wrote:
> On Fri, Mar 23, 2012 at 11:09:50AM -0500, H Hartley Sweeten wrote:
>> No, I have not applied your VIC hack.
>
> Please try it. The point there was that we have a problem in ep93xx VIC/DMA
> code but it is totally different thing and not related to Rafal's patch. We
> can sort the VIC thing out separately IMHO. ep93xx dma in 3.3 is broken
> regardless this patch.

Mika,

I tried you VIC hack. It does seem to work.

I tried doing a bit more debugging with the handle_one_vic function. It
appears that the timer tick is what's causing the spi dma interrupts grief.
I'm just not sure how it's happening or how to fix it...

I modified handle_one_vic to output a message when multiple interrupts
are detected in the stat. Then, if multiple interrupts were detected, to output
a message with the new calculated stat and the actual stat. These "should"
occur one right after the other when multiple interrupts are detected. But
that's not what I'm getting. Here's a sample trace with comments:

handle_one_vic: stat:0x00060000 - handling irq:17 now
	stat shows interrupts 17 and 18
handle_one_vic: stat:0x00040010 - handling irq:4 now
	stat shows interrupts 4 and 18, 17 was handled
handle_one_vic: next stat:0x00040000 - actual stat:0x00040000
	next stat shows interrupt 18, 4 was handled, 18 is pending
handle_one_vic: stat:0x00040000 - handling irq:18 now
	stat shows interrupt 18
handle_one_vic: next stat:0x00000000 - actual stat:0x00000010
	next stat shows no interrupts, 18 was handled, 4 is pending
handle_one_vic: next stat:0x00040000 - actual stat:0x00000000
	next stat shows interrupt 18, it was already handled, none are pending
handle_one_vic: stat:0x00040000 - handling irq:18 now
	stat shows interrupt 18 (which was already handled)
dma dma1chan1: spurious interrupt: status=00002180
	bang... spurious interrupt

It looks like the timer interrupt (4) is causing vic_handle_irq to start
iterating over the VIC's while an iteration is already in progress.  One
of the iterations is handling interrupt 18 correctly but, since the stat
is only read once, the second iteration also tries to handle it.

Any ideas?

Regards,
Hartley
