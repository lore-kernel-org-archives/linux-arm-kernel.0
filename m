From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Sep 2017 12:15:38 -0700
Subject: [PATCH] arm64: Unconditionally support ARCH_HAVE_NMI_SAFE_CMPXCHG
In-Reply-To: <59BC1D7F.4090107@arm.com>
References: <20170915011915.7993-1-sboyd@codeaurora.org>
 <59BC1D7F.4090107@arm.com>
Message-ID: <20170915191538.GD3349@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15, James Morse wrote:
> On 15/09/17 02:19, Stephen Boyd wrote:
> > From what I can see there isn't anything about ACPI_APEI_SEA that
> > means the arm64 architecture can or cannot support NMI safe
> > cmpxchg, so the if condition here is not important. 
> 
> Yup, it was to match 'HAVE_NMI', which was new with ACPI_APEI_SEA and pulls in
> some printk() stuff.
> 
> ... how come you don't need to change HAVE_NMI too?

I didn't change HAVE_NMI because it wasn't needed to get hist
triggers working. Sorry, I didn't even notice that HAVE_NMI
was also there, probably both of these configs should drop the
condition. I'll update the patch to do so.

> 
> 
> > Let's remove
> > it. Doing that allows us to support ftrace histograms via
> > CONFIG_HIST_TRIGGERS that depends on the arch having this config
> > selected.
> 
> What does CONFIG_HIST_TRIGGERS need this for? I can't see any
> cmpxchg use in kernel/trace/trace_events_hist.c

True. I think this isn't necessary for CONFIG_HIST_TRIGGERS, but
more for CONFIG_TRACING_MAP that is selected and used by
CONFIG_HIST_TRIGGERS. We put the dependency in both places so we
don't get the trigger config selecting a config that has unmet
dependencies. Note there's a cmpxchg in the tracing map code too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
