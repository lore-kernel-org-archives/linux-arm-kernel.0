From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 22 Mar 2012 18:56:30 -0500
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <20120322200339.GA5812@mwesterb-mobl.ger.corp.intel.com>
References: <4F683B36.8090101@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020696D488E3@AUSP01VMBX24.collaborationhost.net>
 <20120321193231.GA3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48AB1@AUSP01VMBX24.collaborationhost.net>
 <20120322073750.GA637@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48CAF@AUSP01VMBX24.collaborationhost.net>
 <20120322200339.GA5812@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020696D48E1A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 22, 2012 1:04 PM, Mika Westerberg wrote:
> On Thu, Mar 22, 2012 at 01:52:52PM -0500, H Hartley Sweeten wrote:
>
>> I hacked this back to the handle_one_vic function. It looks like every time
>> I get the message above the stat read in that function shows an active
>> interrupt for DMAM2M0 (the dma rx channel) and DMAM2M1 (the dma
>> tx channel). Because of the way handle_one_vic processes the irq's, the
>> DMAM2M0 interrupt gets handled first. When it's done it must be clearing
>> the DMAM2M1 interrupt automatically for some reason. So, when it's
>> handled there is no interrupt pending so we get the message.
>> 
>> The "cleanest" fix I can think of is the following patch.  This is against
>> linux-next.
>
> I can't figure out any better fix unless we move ep93xx back to use
> !MULTI_IRQ_HANDLER which obviously is not good thing to do.

Mika,

I wonder if the spurious interrupts were the real problem behind what
was causing the Oops that prompted your patch:

dma/ep93xx_dma: prevent ep93xx_dma_tasklet() to reference an empty list

???

Hartley
