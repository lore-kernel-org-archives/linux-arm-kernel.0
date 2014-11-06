From: vigneshr@ti.com (Vignesh R)
Date: Thu, 6 Nov 2014 13:12:09 +0530
Subject: [PATCH 0/4] Touchscreen performance related fixes
In-Reply-To: <20141103180920.GA20779@localhost.localdomain>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <20141103180920.GA20779@localhost.localdomain>
Message-ID: <545B2651.4090905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 03 November 2014 11:39 PM, Richard Cochran wrote:
> On Mon, Oct 27, 2014 at 04:38:27PM +0530, Vignesh R wrote:
>> This series of patches fix TSC defects related to lag in touchscreen
>> performance and cursor jump at touch release. The lag was result of
>> udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
>> The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
>> to avoid false pen-up events and remove udelay.
> 
> That advisory has two workarounds. You have chosen the second one?

Work around one. Hence 5 wire design is not broken.

> 
> The text of the second workaround says it only works on 4 wire setups,
> so I wonder how 5 wire designs will be affected.
> 
>> The advisory says to use
>> steps 1 to 4 for ADC and 5 to 16 for TSC (assuming 4 wire TSC and 4 channel
>> ADC).
> 
> No, it doesn't say that. (sprz360f.pdf)

The pen up event detection happens immediately after charge step. Hence,
interchanging ADC and TSC steps makes sure that sampling of touch
co-ordinates and pen events are done one after the other. This
workaround was suggested by internal hardware folks. Earlier ADC steps
intervened between sampling of co-ordinates and pen event detection
which is not desirable.

> 
>> Further the X co-ordinate must be the last one to be sampled just
>> before charge step. The first two patches implement the required changes. 
> 
> FWIW, I implemented the first workaround and removed the udelay not
> too long ago. Like Sebastian, I saw the TSC unit hang after about
> 50000 interrupts when running with the workaround.
> 
> Did you test you patch for very long?

Yes, I tested for about 200000 interrupts and I didn't see any hang.
This patch series does not just implement workaround but also does some
minor changes, such as interchanging ADC and TSC steps etc, which makes
TSC driver more robust. Let me know if you encounter any issues with my
patch series.

Regards
Vignesh

> 
> Thanks,
> Richard
> 
