From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 30 Jan 2013 17:27:28 +0000
Subject: [PATCH v3 14/15] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <alpine.LFD.2.02.1301291327340.6300@xanadu.home>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-15-git-send-email-nicolas.pitre@linaro.org>
 <20130129104642.GK30563@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301291327340.6300@xanadu.home>
Message-ID: <20130130172727.GF20593@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 06:42:33PM +0000, Nicolas Pitre wrote:
> On Tue, 29 Jan 2013, Lorenzo Pieralisi wrote:
> 
> > On Tue, Jan 29, 2013 at 07:51:09AM +0000, Nicolas Pitre wrote:
> > 
> > [...]
> > 
> > > +		/*
> > > +		 * Flush the local CPU cache.
> > > +		 *
> > > +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > > +		 * a preliminary flush here for those CPUs.  At least, that's
> > > +		 * the theory -- without the extra flush, Linux explodes on
> > > +		 * RTSM (maybe not needed anymore, to be investigated).
> > > +		 */
> > > +		flush_cache_louis();
> > 
> > This is not needed. If it is, that is a model bug and should be flagged
> > up as such.
> 
> Could someone at ARM do that?

I will do that.

> 
> I just confirmed that this is still the case by commenting out the 
> preliminary flush calls and hot-plugging CPUs out and back.  Result is a 
> non-sensical kernel oops which has the looks of serious memory 
> corruption.  This is with RTSM version 7.1.42.
> 
> > > +		cpu_proc_fin(); /* disable allocation into internal caches*/
> > 
> > This code disables the I-cache causing following instruction fetches from
> > DRAM; that is extremely slow and should be avoided, there is no point in
> > disabling the I-cache here, that is not required.
> > On fast-models that's a non-issue, but I really want to prevent copy'n'paste
> > of this sequence as it stands.
> 
> Agreed, I'll change that.  The (not included in this series) TC2 backend 
> does leave the I-cache active already.

Great, thanks !!

Lorenzo
