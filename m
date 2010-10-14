From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 14 Oct 2010 16:48:00 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203D760F19C@dlee02.ent.ti.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<20101008231926.GA28235@kroah.com>
	<alpine.LFD.2.00.1010082242390.3107@xanadu.home>
	<AANLkTi=BvXROFEnzYykoUQNbU05Q=mWoV3t7qKDk7+vL@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203D760F19C@dlee02.ent.ti.com>
Message-ID: <AANLkTinu3wL536szc2mxe3HTAz9yduDHnOU+oP_wOHT-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 7:17 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Felipe Contreras
>> Sent: Saturday, October 09, 2010 5:01 AM
>
>> That's not true, drivers on ARMv6 and above do work. I still wonder
>> how exactly to trigger the issue, and how often does this happen,
>> because I've never seen it.
>
> On a Cortex-A8 if you enable auxcr.asa speculative accesses will be allowed to happen more broadly (cross outside of L2). ?There are few failures which have been seen in testing which go away with its disable. Most Linux kernels have this feature off. ?They still prefetch but with reduced scope.

I see, do you have some pointers as how to enable this to try it out?

> On Cortex-A9 to get performance there are prefetches at both A9 level and PL310 (L2 controller) level. Enabling them for some things gives a very good boost. It will increase your chances of hitting issues as it activates D-Side prefetch along with increasing the amount I side prefetch. ?An A9 doesn't have auxcr to limit its prefetch to L2 like A8. ?If there is a MMU table with a valid TLB its free game to speculate against and bring data in (for non device memory maps).
>
> I'm told A15 gets much more aggressive here. It has dedicated hardware resources (fill buffers ++) for speculation and not just competing against the current instruction stream for these resources.
>
> Having incoherent views and/or copies of data is not what you want. SMP should amplify the badness by doubling speculation sources and adding extra l1 caches. Killing the alias from ioremap is a good thing and something people should want for production.

Thanks for clarifying the situation.

However, nobody is proposing to not kill the ioremap() double alias,
only to make it a warning for now. One argument against this is that
would cause corruption on other parts of the system which doesn't seem
to be the case.

I take it you don't have a problem with making this a warning on .36,
and disable completely on .37 (or later). Right?

The real issue is the drivers relying on this behavior, which need to
be fixed regardless of this decision to warn, or disable.

-- 
Felipe Contreras
