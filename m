From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Oct 2012 07:31:58 -0700
Subject: [PATCH] [ARM] Build failure CONFIG_ARCH_KIRKWOOD_DT relies on
 CACHE_FEROCEON_L2
In-Reply-To: <20121001044337.GA8446@obsidianresearch.com>
References: <20120930232253.GD30637@obsidianresearch.com>
 <CAOesGMgpDs60jGsV4Wu-A7M+ThXh7YVkgb_mPgMJfPwNa_QbSw@mail.gmail.com>
 <20121001044337.GA8446@obsidianresearch.com>
Message-ID: <CAOesGMhQpqdCRoV85vW+7THstbx+HWmCkR3Q6bpK6uLEmhKqfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 9:43 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Sun, Sep 30, 2012 at 07:44:10PM -0700, Olof Johansson wrote:
>
>> >  void __init kirkwood_l2_init(void)
>> >  {
>> > +#ifdef CONFIG_CACHE_FEROCEON_L2
>> >  #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
>>
>> Aren't these added ifdefs completely redundant? L2_WRITETHROUGH is
>> dependent on the outer options anyway.
>
> No, the complete new function is:
>
> void __init kirkwood_l2_init(void)
> {
> #ifdef CONFIG_CACHE_FEROCEON_L2
> #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
>         writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
>         feroceon_l2_init(1);
> #else
>         writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
>         feroceon_l2_init(0);
> #endif
> #endif
> }

Ah. diff took out the #else in the middle and I didn't look at the
file. Obviously correct as-is.

In some other places we choose to put the ifdef outside the function
and provide a static inline stub in the header file instead. Either
way works fine though.


-Olof
