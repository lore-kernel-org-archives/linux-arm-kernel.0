From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Sep 2011 14:58:44 +0800
Subject: [PATCH] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <CAGsJ_4z4WJkDPhD1WYan3GecnAb0VfPx3_dgFHCmTWs7gVyFdA@mail.gmail.com>
References: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
	<20110921055223.GA28907@S2100-06.ap.freescale.net>
	<CAGsJ_4z4WJkDPhD1WYan3GecnAb0VfPx3_dgFHCmTWs7gVyFdA@mail.gmail.com>
Message-ID: <20110921065842.GB28907@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 01:53:37PM +0800, Barry Song wrote:
> 2011/9/21 Shawn Guo <shawn.guo@freescale.com>:
> > Hi Barry,
> >
> > On Tue, Sep 20, 2011 at 06:57:45PM -0700, Barry Song wrote:
> >> we save the l2x0 registers at the first initialization, and restore
> >> them after resuming every time.
> >>
> > I'm unsure that it will work for cases like imx6q, where L2 cache is
> > retained and the controller needs to be restored at the very beginning
> > of the resume entry (running on physical space).
> 
> yes. imx6q actually needs to enable l2 earlier than cpu_resume(and mmu
> resume). so how about letting outer_resume support both phy and virt
> address restore?
> for example, add early resume: outer_early_resume()
> 
> Then for your case, you use asm to "bl out_resume", then "b cpu_resume".
> For those chips which lose l2 in suspend cycle, people can call it in
> C function after cpu_resume.
> 
It's worth a try.  Except that, I have another two comments on the
patch.

* To be safe, all the variables used to save L2 registers need to
  be ensured being written external memory.

* What registers to save seems to be a platform decision.  For example,
  you patch save 5 registers for pl310 while I only need one aux_ctrl
  on imx6q.

It seems that Lorenzo also has a plan working on this, so I Cc-ed him
for comments.

-- 
Regards,
Shawn
