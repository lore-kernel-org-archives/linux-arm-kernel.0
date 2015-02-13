From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Feb 2015 10:54:47 +0000
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
In-Reply-To: <loom.20150213T053547-381@post.gmane.org>
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org>
Message-ID: <20150213105447.GB3508@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 04:36:25AM +0000, Venkappa Mala wrote:
> Nathan Lynch <nathan_lynch <at> mentor.com> writes:
> 
> > +#ifdef CONFIG_ARM_ARCH_TIMER
> > +
> > +static notrace u64 get_ns(struct vdso_data *vdata)
> > +{
> > +	u64 cycle_delta;
> > +	u64 cycle_now;
> > +	u64 nsec;
> > +
> > +	cycle_now = arch_counter_get_cntvct();
> 
> Regarding ARM:vDSO, I have enabled your patch set on Cortex-A7/ARMv7, 
> the vDSO is up and running using generic arch timer using physical 
> counter but not with VCT.
> I anticipate, the issue could be due to VCT cycles.
[...]
> Perhaps, either we need to revise the vDSO frame work to choose VCT or 
> PCT dynamically Otherwise CNTVOFF reset to be zero but CNTVOFF could not 
> be accessed in SVC mode (PL1).

I assume on your platform, the DT also contains
"arm,cpu-registers-not-fw-configured". In such case, the VDSO
optimisation for gettimeofday should just be disabled (as it would be if
the generic timers are not present). Really, just fix the firmware.

-- 
Catalin
