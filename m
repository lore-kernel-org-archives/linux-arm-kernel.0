From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 17:23:26 +0000
Subject: [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate
 before hot-unplugging a CPU
In-Reply-To: <alpine.LFD.2.02.1301141207360.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-8-git-send-email-nicolas.pitre@linaro.org>
 <20130114163755.GB31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141151510.6300@xanadu.home>
 <20130114170028.GD31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141207360.6300@xanadu.home>
Message-ID: <20130114172326.GF31341@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:15:07PM +0000, Nicolas Pitre wrote:
> On Mon, 14 Jan 2013, Will Deacon wrote:
> > On Mon, Jan 14, 2013 at 04:53:41PM +0000, Nicolas Pitre wrote:
> > > The bL_set_entry_vector() includes a cache flush which itself has a DSB.  
> > > Hence my previous interrogation.
> > 
> > For L1, sure, we always have the dsb for v7. However, for the outer-cache we
> > only have a dsb by virtue of a spin_unlock in l2x0.c... it seems a bit risky
> > to rely on that for ordering your entry_vector write with the power_on.
> > 
> > I think the best bet is to put a barrier in power_on, before invoking the
> > platform_ops function and similarly for power_off.
> > 
> > What do you reckon?
> 
> I much prefer adding barriers inside the API when they are needed for 
> proper execution of the API intent.  So if I call bL_set_entry_vector(), 
> I trust that by the time it returns the vector is indeed set and ready 
> for use by other processors.
> 
> The same could be said about the outer cache ops.  If a DSB is needed 
> for their intent to be valid, then why isn't this DSB always implied by 
> the corresponding cache op calls?  And as you say, there is already one 
> implied by the spinlock used there, so that is not if things would 
> change much in practice.

Ok, so we can fix the outer_cache functions as suggested by Catalin. That
still leaves the GIC CPU interface problem in the later patch, which uses a
writel_relaxed to disable the CPU interface, so I suppose we can just put
a dsb at the end of gic_cpu_if_down().

Will
