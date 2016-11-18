From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Nov 2016 14:42:15 +0100 (CET)
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20161118132912.GM13470@arm.com>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <20161118120453.GI13470@arm.com> <alpine.DEB.2.20.1611181401180.3615@nanos>
 <20161118132912.GM13470@arm.com>
Message-ID: <alpine.DEB.2.20.1611181430070.3615@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Nov 2016, Will Deacon wrote:
> On Fri, Nov 18, 2016 at 02:11:58PM +0100, Thomas Gleixner wrote:
> > But it's guaranteed that cpuhp_setup_state() will not return before the
> > callback has been invoked on each online cpu.
> 
> Ok, that's good.
> 
> > If cpus are not yet online when that code is invoked, then it's the same
> > behaviour as before. It will be invoked when the cpu comes online.
> 
> Just to check, but what stops a CPU from coming online between the call
> to cpuhp_setup_state and the call to cpuhp_remove_state_nocalls in the
> case of failure (debug_err_mask isn't empty)?

Indeed! I missed that part. So we still need a get/put_online_cpus()
protection around all of this.

Just for curiosity sake. Wouldn't it be simpler and less error prone to
make the ARM_DBG_READ/WRITE macros use the exception table and handle that
in the undefined instruction handler to avoid this hook dance?

Thanks,

	tglx
