From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 13:53:37 +0800
Subject: [PATCH] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20110921055223.GA28907@S2100-06.ap.freescale.net>
References: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
	<20110921055223.GA28907@S2100-06.ap.freescale.net>
Message-ID: <CAGsJ_4z4WJkDPhD1WYan3GecnAb0VfPx3_dgFHCmTWs7gVyFdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/21 Shawn Guo <shawn.guo@freescale.com>:
> Hi Barry,
>
> On Tue, Sep 20, 2011 at 06:57:45PM -0700, Barry Song wrote:
>> we save the l2x0 registers at the first initialization, and restore
>> them after resuming every time.
>>
> I'm unsure that it will work for cases like imx6q, where L2 cache is
> retained and the controller needs to be restored at the very beginning
> of the resume entry (running on physical space).

yes. imx6q actually needs to enable l2 earlier than cpu_resume(and mmu
resume). so how about letting outer_resume support both phy and virt
address restore?
for example, add early resume: outer_early_resume()

Then for your case, you use asm to "bl out_resume", then "b cpu_resume".
For those chips which lose l2 in suspend cycle, people can call it in
C function after cpu_resume.

>
> Regards,
> Shawn

-barry
