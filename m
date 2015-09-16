From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Sep 2015 17:50:53 -0700
Subject: [PATCH 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
Message-ID: <20150916005053.GL23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15, Andrew Morton wrote:
> On Tue, 15 Sep 2015 12:41:26 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > The SMD driver is reading and writing chunks of data to iomem,
> > and there's an __iowrite32_copy() function for the writing part, but
> > no __ioread32_copy() function for the reading part. This series
> > adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
> > case this should go through the -mm tree. Otherwise the target
> > of this patch series is SMD, so I've sent it to Andy.
> 
> "soc: qcom: smd: Use __ioread32_copy() instead of open-coding it" no
> longer applies, because smd_copy_from_fifo() has switched to
> readl_relaxed().

Yes. There are some other patches in flight on the mailing list
to this file from me[1]. Those would need to be applied first to
avoid conflicts.

> 
> Let's use the __weak macro rather than open-coding it (and convert
> __iowrite32_copy() while we're in there).

Yep, I converted the __iowrite32_copy() open-code in there too in
the patch series I mentioned above. See [2].

> 
> It's unclear why __iowrite32_copy() is a weak function - nothing
> overrides it.  Perhaps we should just take that away rather than
> copying it into __ioread32_copy().

Huh? I see that x86 has an implementation in arch/x86/lib/iomap_copy_64.S

> 
> __iowrite32_copy() is marked __visible.  I don't actually know what
> that does and Andi's d47d5c8194579bc changelog (which sucks the big
> one) didn't explain it.  Apparently it has something to do with being
> implemented in assembly, but zillions of functions are implemented in
> assembly, so why are only two functions marked this way?  Anyway,
> __ioread32_copy() is implemented in C so I guess __visible isn't needed
> there.

Yeah, I didn't add visible because there isn't an assembly
version of __ioread32_copy() so far. I can remove __weak if
desired. I left it there to match __iowrite32_copy() in case
x86 wanted to override it but we can do that later or never.

[1] http://lkml.kernel.org/g/1441234011-4259-7-git-send-email-sboyd at codeaurora.org
[2] http://lkml.kernel.org/g/1441234011-4259-5-git-send-email-sboyd at codeaurora.org

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
