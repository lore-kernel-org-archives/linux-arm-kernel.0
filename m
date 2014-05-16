From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 17:08:26 +0900
Subject: [PATCH/RFC] ARM: shmobile: Enable PM_RUNTIME in defconfig
In-Reply-To: <CAMuHMdVEowWbMY+L1TuC4xxYvtGZiH5qYOjmd7-rt1e_=xEz1A@mail.gmail.com>
References: <1400198682-7666-1-git-send-email-horms+renesas@verge.net.au>
 <20140516020549.GB18137@verge.net.au>
 <CAMuHMdVEowWbMY+L1TuC4xxYvtGZiH5qYOjmd7-rt1e_=xEz1A@mail.gmail.com>
Message-ID: <20140516080825.GA23295@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 09:17:03AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, May 16, 2014 at 4:05 AM, Simon Horman <horms@verge.net.au> wrote:
> > I realise this change was your idea but I'd like to confirm some details.
> >
> > My assumption is that it requires
> >
> > [PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
> >
> > Is that indeed required?
> > Are there other dependencies that are not in the next branch
> > of my renesas tree?
> 
> Your assumption is wrong. The aforementioned patch is always needed in
> the multi-platform case.
> 
> Please let me clarify:
> drivers/sh/pm_runtime.c registers a bus notifier for platform devices, which
> registers the default clock for automatic clock management by the PM core.
> If CONFIG_PM_RUNTIME=y, the clock will be managed dynamically, based
> on runtime requirements.
> If CONFIG_PM_RUNTIME=n, the clock will be enabled at registration time.
> 
> So even if CONFIG_PM_RUNTIME=n, you need this patch, else the affected
> clocks won't be enabled (if not already enabled by reset state or the boot
> loader).
> 
> Note that some drivers (e.g. sh-sci) will still work fine without
> drivers/sh/pm_runtime.c, as they manage their clocks themselves.

Thanks, I now understand that the above mentioned patch is required
regardless of the value of CONFIG_PM_RUNTIME.

With that in mind I'll rephrase my question: are you are ware
of any patches this one (the defconfig update) should depend on?
