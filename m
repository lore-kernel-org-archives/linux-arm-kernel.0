From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Apr 2012 13:46:40 -0600 (MDT)
Subject: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
In-Reply-To: <4F90641D.3090208@ti.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053654.16278.73632.stgit@dusk>
 <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
 <4F90001E.8060201@ti.com>
 <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
 <4F90641D.3090208@ti.com>
Message-ID: <alpine.DEB.2.00.1204191338370.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

On Thu, 19 Apr 2012, Cousson, Benoit wrote:

> On 4/19/2012 7:17 PM, Paul Walmsley wrote:
> > On Thu, 19 Apr 2012, Cousson, Benoit wrote:
> > 
> > > The concern of the people doing SW in these embedded processors was mainly
> > > because we were releasing the reset of processor without loading any SW
> > > first
> > > and thus the processor was executing some random instructions.
> > > 
> > > So if we consider a better hwmods definition, we can potentially fix the
> > > MMU
> > > case:
> > > 
> > >      'mmu_ipu':
> > >          'rst_ipu_mmu_cache'
> > > 
> > >      'mmu_dsp':
> > >          'rst_dsp_mmu_cache'
> > > 
> > >      'iva_config':
> > >          'rst_logic'
> > 
> > Wouldn't these still be "pseudo-hwmods?"  Or do each of these actually
> > have address space, interconnect ports, etc.?
> 
> Yes, these ones are the only real IPs for MPU stand point, with interconnect
> port and configuration registers.

These are the MMUs documented in Chapter 20 of the OMAP4430 TRM 
vX, right?  

I don't really understand the interaction of the hardreset lines with 
these IPs.  Chapter 20 doesn't seem to mention the PRCM-controllable 
hardreset lines at all.  It only mentions the OCP_SYSCONFIG registers 
associated with them.

Meanwhile Table 3-375 "RM_DSP_RSTCTRL" mentions a DSP MMU, cache, and 
slave interface reset line.  Is that referring to the same MMU that is 
mentioned in Chapter 20?  The end of Section 20.2 "MMU Integration" 
mentions two different DSP MMUs, a "shared cache MMU" and an "L2 MMU" - 
maybe the hardreset line only pertains to the first MMU?

> > > But then we do have the processor resets that have to be exposed
> > > somewhere.
> > > 
> > >      'ipu':
> > >          'rst_cpu0'
> > >          'rst_cpu1'
> > > 
> > >      'dsp':
> > >          'rst_dsp'
> > > 
> > >      'iva':
> > >          'rst_seq1'
> > >          'rst_seq2'
> > > 
> > > None of these one should be controlled automatically.
> > 
> > Don't we still want to put these IP blocks into reset until a driver for
> > these IP blocks is loaded?
> 
> Yes, indeed, my point is where are we going to declare these reset lines if we
> do not have any fake hwmods to store them.

Wouldn't we associate them with the processor hwmods?  e.g., 
omap44xx_iva_hwmod, omap44xx_dsp_hwmod ?

> Well, for the MMU we can, these are regular IPs (almost). The real issues was
> for the processors.

Omar, do you know  how these hardreset lines interact with the MMUs 
described in the TRM Chapter 20?

> First they will have to release their driver :-)

Hehe, indeed.


- Paul
