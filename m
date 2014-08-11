From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 11 Aug 2014 10:58:50 +0300
Subject: [PATCH] ARM: edma: Fix configuration parsing for SoCs with
 multiple eDMA3 CC
In-Reply-To: <20140805163229.GZ8181@intel.com>
References: <1407155216-20267-1-git-send-email-peter.ujfalusi@ti.com>
 <20140805163229.GZ8181@intel.com>
Message-ID: <53E877BA.6040705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 07:32 PM, Vinod Koul wrote:
> On Mon, Aug 04, 2014 at 03:26:56PM +0300, Peter Ujfalusi wrote:
>> The edma_setup_from_hw() should know about the CC number when parsing the
>> CCCFG register - when it reads the register to be precise. The base
>> addresses for CCs stored in an array and we need to provide the correct id
>> to edma_read() in order to read the correct register.
> 
> Just an othognal question:
> 
> I still see lot of code for edma in arm/. What is the plan to re/move that
> to dma/

Yes, there's still a big split. The code under arch/arm/common/ provides still
the 'legacy' edma API. This is still used by audio
sound/soc/davinci/davinci-pcm for older daVinci devices (AM335x. AM43xx uses
the edma-pcm).

And it is not that simple to deprecate davinci-pcm: it can use so called
ping-pong mode for audio data transfer. This mode is not possible via
dmaengine AFAIK.
I'm going to check if edma-pcm would work fine instead of the ping-pong mode.
If it does I can remove davinci-pcm and we can start cleaning up the edma code.

-- 
P?ter
