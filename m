From: mporter@ti.com (Matt Porter)
Date: Thu, 10 Jan 2013 18:51:57 -0500
Subject: [RFC PATCH v3 02/16] ARM: davinci: move private EDMA API to
 arm/common
In-Reply-To: <508CEA05.8060200@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-3-git-send-email-mporter@ti.com>
 <508CEA05.8060200@ti.com>
Message-ID: <20130110235157.GU14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 01:47:09PM +0530, Sekhar Nori wrote:
> On 10/18/2012 6:56 PM, Matt Porter wrote:
> > Move mach-davinci/dma.c to common/edma.c so it can be used
> > by OMAP (specifically AM33xx) as well. This just moves the
> > private EDMA API but does not support OMAP.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> 
> > diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
> > index 4c48a36..f45d591 100644
> > --- a/arch/arm/mach-davinci/devices.c
> > +++ b/arch/arm/mach-davinci/devices.c
> > @@ -19,9 +19,10 @@
> >  #include <mach/irqs.h>
> >  #include <mach/cputype.h>
> >  #include <mach/mux.h>
> > -#include <mach/edma.h>
> >  #include <linux/platform_data/mmc-davinci.h>
> >  #include <mach/time.h>
> > +#include <linux/platform_data/edma.h>
> 
> Can you please introduce a patch to clean this mixture of linux/ and
> mach/ includes?

Yeah, are you ok with a follow on series to clean all these files? I
don't want to make this series longer with something not dma related
that's purely cleanup from the great header reorg of 2012.

> > +
> >  
> >  #include "davinci.h"
> >  #include "clock.h"
> > @@ -141,10 +142,10 @@ static struct resource mmcsd0_resources[] = {
> >  	},
> >  	/* DMA channels: RX, then TX */
> >  	{
> > -		.start = EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCRXEVT),
> > +		.start = EDMA_CTLR_CHAN(0, 26),
> 
> Instead of just replacing the event #defines with plain numbers, can you
> introduce a mach-davinci local edma.h which can then be included in the
> davinci platform files which refer to edma channel numbers?

Ok, so when I removed the old edma.h it was full of unused defines and
we are left with just this one. If I introduced something like that it
would be used in just one place here. and only for these two values.
How about we just add a comment?

> 
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index 7cd56ed..153fab8 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -28,6 +28,7 @@ config ARCH_OMAP2PLUS
> >  	select OMAP_DM_TIMER
> >  	select PROC_DEVICETREE if PROC_FS
> >  	select SPARSE_IRQ
> > +	select TI_PRIV_EDMA
> 
> This hunk does not seem to belong to subject of this patch.

Let me reword the subject/description. The idea of this logical
chunk was to put everything in place to make it build on OMAP,
with the expectation that the build fails without the next patch
in the series.

> >  	select USE_OF
> >  	help
> >  	  "Systems based on OMAP2, OMAP3, OMAP4 or OMAP5"
> 
> > diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
> > new file mode 100644
> > index 0000000..7396f0b3
> > --- /dev/null
> > +++ b/include/linux/platform_data/edma.h
> > @@ -0,0 +1,198 @@
> > +/*
> > + *  TI DAVINCI dma definitions
> > + *
> > + *  Copyright (C) 2006-2009 Texas Instruments.
> > + *
> > + *  This program is free software; you can redistribute  it and/or modify it
> > + *  under  the terms of  the GNU General  Public License as published by the
> > + *  Free Software Foundation;  either version 2 of the  License, or (at your
> > + *  option) any later version.
> > + *
> > + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> > + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> > + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> > + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> > + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> > + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> > + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> > + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> > + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> > + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> 
> > + *  You should have received a copy of the  GNU General Public License along
> > + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> > + *  675 Mass Ave, Cambridge, MA 02139, USA.
> 
> This part can be dropped, I suppose ;-)

Indeed :)

-Matt
