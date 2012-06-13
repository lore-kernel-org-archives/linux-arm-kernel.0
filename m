From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 17:16:09 -0700
Subject: [PATCH V2] clk: give clock chance to change parent at setrate
 stage
In-Reply-To: <CAAXpJNvdaZxSiCr3Usd0B4iGHLkxshwzfN4LQZ2xZCcwBe8fVQ@mail.gmail.com>
References: <CAG9bXvmAf-0fmVb8nzWkuAKaMoOJVzR=hThwXpN_izQzM26q-g@mail.gmail.com>
 <1336146319-6803-1-git-send-email-leiwen@marvell.com>
 <CALZhoSQcjrOk3s6NFRs34H5uiYWK+TYeqJpoiwC6XSF+xPXrzg@mail.gmail.com>
 <20120509183455.GB19219@gmail.com>
 <CAAXpJNvafi5oZJDQsE9oxLyKZVVLyLLBP9DUt1+jBw9_reY_8Q@mail.gmail.com>
 <CAJOA=zNnKM6ymn=FW2260cVr6hat-ucBkSG8iiRcPt38Sve89w@mail.gmail.com>
 <CAAXpJNvdaZxSiCr3Usd0B4iGHLkxshwzfN4LQZ2xZCcwBe8fVQ@mail.gmail.com>
Message-ID: <20120613001609.GN19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120516-19:55, zhoujie wu wrote:
> If I separate this clock to mux->divider model,
> mux node will NOT set CLK_SET_RATE_PARENT flag
> divider node will set CLK_SET_RATE_PARENT flag
> 
> When I want to change this clock's rate, it will at first find proper
> divider with current parent rate,
> if best_parent_rate != cur_parent_rate, this means we should re-parent
> the mux. The mux node rate
> will be change at first, and then divider. Per your suggestion, in mux
> .set_rate ops we disable new parent
> and set mux field, then disable old parent.
> But there is a limitation here,  write to the mux filed doesn't really
> change the source of the parent. It requires
> the trigger bits to be set.
> If we don't set trigger bits here, the source is still not change, we
> could not disable old parent. Where is the proper place to disable it?
> If we set mux and trigger here, we may use some tmp dangerous clock
> rate since divider has not update yet.
> For example, rate 400M = mux_400M/ div_1 at first. When we want to set
> to 533M, we have change mux to 1066M here, we may get tmp rate 1066M =
> 1066M/1, but this clock may not run up to 1066M.
> That is why we think it is more safe to set mux&div&trigger the same time.

Hi Zhoujie Wu,

I still think that the separate clock nodes could work for you.  I don't
know if you have actually tried to implement them or not.

Regardless I want you to know that I've changed my mind about your
original patch to give clk_set_rate the option to select a new parent.
I think that this behavior is necessary for a variety of reasons
(locking correctness amongst other things).  I'm going to implement it
differently than your patch does, but it should help you out.

I'll Cc you on the patch when it hits the list.

Regards,
Mike
