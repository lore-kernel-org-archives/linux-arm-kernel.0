From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Jun 2011 11:14:37 +0100
Subject: A page fault causes exiting from WFI mode for all idling cores?
In-Reply-To: <BANLkTimzoNRS+MynARc3uBz8h6N06FGRQQ@mail.gmail.com>
References: <BANLkTimzoNRS+MynARc3uBz8h6N06FGRQQ@mail.gmail.com>
Message-ID: <BANLkTimKW-jT77nL5W_s-pJ-Vqr2Ct8C7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 May 2011 12:59, heechul Yun <heechul@illinois.edu> wrote:
> While I was investigating page fault handling performance on a quad
> core Cortex-A9 ARM processor,?I noticed that whenever there is a
> page fault, all idling cores?also?awakened---exiting from WFI instruction
> on the idle loop?(and go back to WFI again).
>
> Since the page fault generating program is running on a?single core,
> it seems unnecessary to wake up?other idling cores (hence saving
> power) as well.
>
> Can anyone tell me if this, exiting from WFI on every page fault, is
> correct behavior??If so, why?

I don't think this is explicitly done by Linux, at least not with
Cortex-A9. For ARM11MPCore, we do some TLB operations which are
broadcast in software via IPI. Which kernel version are you using?

Also note that WFI is just a hint to the processor, so it could get
out of it at any time. Maybe the A9 just does this when it gets some
TLB ops from another CPU.

-- 
Catalin
