From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 22 Nov 2011 07:59:25 +0200
Subject: [PATCH v2 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <1321864326.1516.211.camel@vkoul-udesk3>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
 <3ea8d56034f25cbe3fd8a4c31d7d0d1540b6ac7e.1306662317.git.mika.westerberg@iki.fi>
 <4EC27EED.4030108@metasoft.pl>
 <20111116065512.GB2703@mwesterb-mobl.ger.corp.intel.com>
 <4EC374F0.8000400@metasoft.pl>
 <20111119123837.GA2711@mwesterb-mobl.ger.corp.intel.com>
 <4ECA0147.4020806@metasoft.pl>
 <20111121080158.GA2713@mwesterb-mobl.ger.corp.intel.com>
 <1321864326.1516.211.camel@vkoul-udesk3>
Message-ID: <20111122055925.GA15889@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:02:06PM +0530, Vinod Koul wrote:
> On Mon, 2011-11-21 at 10:01 +0200, Mika Westerberg wrote:
> > On Mon, Nov 21, 2011 at 08:44:07AM +0100, Rafal Prylowski wrote:
> > > 
> > > I'm calling dma_terminate_all from interrupt. It seems that tasklet_kill is not
> > > allowed to be called from this context.
> > 
> > Ah, right.
> > 
> > One more try - this time we set a flag which prevents the tasktlet from
> > referencing an empty list.

> Rather than this why not actually check for list_empty and process only
> when it is not empty?

I was thinking that it should be an error if the active list is empty when the
tasklet is run.

> Also you should check the return of the ep93xx_dma_get_active() which
> should return NULL if it didn't find anything in active list

Right - if the list is allowed to be empty.

I'll re-check the patch from Rafal. Maybe it's better to adapt with the fact
that dma_terminate_all() can be called in any context any time and modify the
driver accordingly (e.g like you say, return NULL if the list is empty handle
it correctly).
