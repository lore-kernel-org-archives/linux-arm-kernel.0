From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 13:33:17 +0100
Subject: [PATCH 06/14] dma: sirf: use __maybe_unused to hide pm functions
In-Reply-To: <20160303034731.GI11154@localhost>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-7-git-send-email-arnd@arndb.de>
 <20160303034731.GI11154@localhost>
Message-ID: <2913625.BbPcKOOv7K@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 09:17:31 Vinod Koul wrote:
> On Wed, Mar 02, 2016 at 04:58:58PM +0100, Arnd Bergmann wrote:
> > The sirf dma driver uses #ifdef to check for CONFIG_PM_SLEEP
> > for its suspend/resume code but then has no #ifdef for the
> > respective runtime PM code, so we get a warning if CONFIG_PM
> > is disabled altogether:
> > 
> > drivers/dma/sirf-dma.c:1000:12: error: 'sirfsoc_dma_runtime_resume' defined but not used [-Werror=unused-function]
> > 
> > This removes the existing #ifdef and instead uses __maybe_unused
> > annotations for all four functions to let the compiler know it
> > can silently drop the function definition.
> 
> Hi Arnd,
> 
> Rather than telling compiler that this maybe used why not add ifdef for it's
> suspend/resume as well, what are the demerits of that approach?
> 

As I tried to explain in the cover letter, everyone gets the #ifdef
wrong, and the __maybe_unused annotation is harder to get wrong here.

This particular driver illustrates that well: sirfsoc_dma_remove()
calls sirfsoc_dma_runtime_suspend(), so we must hide the
resume function, but not suspend, and that is counterintuitive.

Other drivers have other problems, e.g. functions that get called
only from within the sections under an #ifdef, and then those
need the same #ifdef added, which gets even more complicated when
you have both runtime-pm and suspend support.

	Arnd
