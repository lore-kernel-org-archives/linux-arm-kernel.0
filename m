From: Tero.Kristo@nokia.com (Tero.Kristo at nokia.com)
Date: Fri, 27 Nov 2009 11:06:35 +0100
Subject: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
In-Reply-To: <20091124151918.GB14462@n2100.arm.linux.org.uk>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
	<1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
	<20091124114836.GA10510@n2100.arm.linux.org.uk>
	<1259068826.13956.22.camel@pc1117.cambridge.arm.com>
	<20091124151918.GB14462@n2100.arm.linux.org.uk>
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236DA8B827@NOK-EUMSG-02.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
>Sent: 24 November, 2009 17:19
>To: Catalin Marinas
>Cc: Kristo Tero (Nokia-D/Tampere); linux-omap at vger.kernel.org; 
>linux-arm-kernel at lists.infradead.org; Dave Estes
>Subject: Re: [PATCH 1/2] ARM: Implemented support for VFP PM 
>context saving
>
>On Tue, Nov 24, 2009 at 01:20:26PM +0000, Catalin Marinas wrote:
>> BTW, the two patches below were mentioned to me some time ago but I
>> haven't got the time to look at them:
>> 
>> [ARM] vfp: Fix bug in vfp_pm_suspend
>> 
>https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=c
>ommit;h=88984c9b2d69c222ee1e2afc948ca73f597d40ff
>
>This one is bad - it gets the current CPU by directly 
>referencing ti->cpu.
>Too bad if you have kernel preemption enabled; the value obtained that
>way is effectively meaningless.  The only way to get a meaningful value
>is via 'get_cpu()' and after you've done with using it, 'put_cpu()'.
>That ensures you can't be preempted onto a different CPU mid-operation.
>
>It's safe in vfp_notifier because we're called in an already 
>atomic context.

I investigated this issue a bit more, and indeed there is a potential bug in the vfp_pm_suspend(). Most of the time it works fine as apparently shell process has VFP enabled at least on my system, and it saves the state. The issue is different with dynamic idle, we are calling the code from init thread which does not need VFP for anything, and thus VFP is always disabled if we try to call vfp_pm_suspend(). For OMAP3, I found a way to fix the dynamic idle part to work properly by just simply calling vfp_sync_state() from idle. This functionality is supposed to be used by ptrace, but I guess it could be used for this also?

A proper fix for suspend is bit more difficult, as I don't know too well how SMP is supposed to work in this case. I guess there is a separate VFP co-processor available for each ARM core, but vfp_pm_suspend() is only called once for the whole system?

>
>> [ARM] vfp: Add additional vfp interfaces
>> 
>https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=c
>ommit;h=393e4bfaaf79377d29cd6bb2228f87601aeca668
>
>I don't like what's in this one.  Lack of explaination in the 
>commit log
>doesn't help.
>
