From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 9 Apr 2014 13:33:26 -0300
Subject: [PATCH v2] ARM: pxa: Move iotable mapping inside vmalloc region
In-Reply-To: <2638213.3rVdlp7YXW@avalon>
References: <1385683243-6688-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <2638213.3rVdlp7YXW@avalon>
Message-ID: <20140409163326.GA17544@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 09, Laurent Pinchart wrote:
> Hi Ezequiel,
> 
> On Thursday 28 November 2013 21:00:43 Ezequiel Garcia wrote:
> > In order to remove the following ugly message:
> > 
> >   BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc space
> > 
> > the iotable mappings should be re-located inside the vmalloc
> > region. Such move was introduced at commit:
> > 
> > commit 0536bdf33faff4d940ac094c77998cfac368cfff
> > Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Date:   Thu Aug 25 00:35:59 2011 -0400
> > 
> >     ARM: move iotable mappings within the vmalloc region
> > 
> > While at it, condition the mapping to PXA25x and PXA27x, which
> > are the only platforms where it's used.
> > 
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Cc: David Heidelberger <david.heidelberger@ixit.cz>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> > David,
> > 
> > Is it possible for you to give this a try on your board?
> 
> I'm running into the same issue on a PXA270 system.
> 
> UNCACHED_PHYS_0 is used as an immediate operand to a mov instruction, and thus 
> needs to be encoded as a shifted 8-bit value. One simple solution would be to 
> hardcode it to 0xfd000000 (0xfe000000 is already used for the IMEMC mapping).
> 
> Another solution would be to keep the UNCACHED_PHYS_0 mapping at the end of 
> the vmalloc area (with a fix for the UL problem due to VMALLOC_END) and modify 
> pxa2[57]x_finish_suspend and pm_enter_standby_start to use an ldr instruction 
> instead of a move instruction to load the address.
> 
> As a side note, the IMEMC mapping seems unused, maybe we could thus reclaim it 
> and use 0xfe000000 for UNCACHED_PHYS_0.
> 
> Do you plan to submit a v3 of this patch ?
> 

Not really. I've been a bit busy and couldn't work any longer on this issue,
so feel free to pick the task :-)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
