From: tim@krieglstein.org (Tim Sander)
Date: Wed, 03 Dec 2014 14:41:28 +0100
Subject: [PATCH 3.18-rc3 v9 5/5] arm: smp: Handle ipi_cpu_backtrace()
 using FIQ (if available)
In-Reply-To: <547C77A0.8030208@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <5910085.Y47hdorDAO@dabox> <547C77A0.8030208@linaro.org>
Message-ID: <4591842.obBcGFvQjh@dabox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel

Am Montag, 1. Dezember 2014, 14:13:52 schrieb Daniel Thompson:
> On 01/12/14 13:54, Tim Sander wrote:
> >> Look, in my mind it is very simple.  If you are using CONFIG_FIQ on a
> >> SMP platform, your life will be very difficult.  The FIQ code enabled
> >> by that symbol is not designed to be used on SMP systems, *period*.
> > 
> > Well the only extra thing you had to do is set up the FIQ registers on
> > every cpu, but i would not call that very difficult. Other than that i am
> > not aware of any problems that are not also present on a uniprocessor
> > system. So i have a hard time following your reasoning why SMP is
> > different from UP in regard to the CONFIG_FIQ.
> > 
> >> If you decide to enable CONFIG_FIQ, and you use that code on a SMP
> >> platform, I'm going to say right now so it's totally clear: if you
> >> encounter a problem, I don't want to know about it.  The code is not
> >> designed for use on that situation.
> > 
> > Even with using the FIQ on a Linux SMP system you have not heard from me
> > before, as i knew that this is not your problem (and that is not to say
> > that there where none!). The only interface Linux has been making
> > available is set_fiq_handler. So it was clear that the FIQ is its own
> > domain otherwise untouched by the kernel. Now the line gets blurried with
> > the linux kernel moving to use the FIQ. And with the descicions
> > forthcoming its not only grabbing land it also claims a previous public
> > path for its own. So it doesn't help that its planting some flowers along
> > the way. So please be nice to the natural inhabitants...
> 
> Surely only upstream code could claim to be a natural inhabitant.
Well from a kernel developer perspective this might be true, but well there 
are things, e.g. the stuff the nice guys at free electrons did, which are quite
reasonable but would be laughed at if tried to include in the kernel:
http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/
Still this shows very much that you can build quite powerfull systems which 
combine both the power of linux with the lowes latency the bare hardware can 
give you.

> Whenever I've been working on code that, for whatever reason, cannot be
> upstreamed I'd probably best be regarded as a tourist.
I think that application specific code which needs all the power the hardware 
gives you in a given power envelope and is so optimized for a special usecase 
that integration in kernel makes no sense. So i would hope for a more 
constructive mindset.

> > And i really don't get it, that neither ARM nor the kernel community sees
> > fast interrupts as a worthwhile usecase. Unfortunatly the interrupt
> > latencies with Linux are at least a order of magnitude higher than the
> > pure hardware even with longer pipelines can deliver.
> > 
> >> Therefore, as far as I'm concerned, the two facilities are mututally
> >> exclusive.
> > 
> > Well can't have the cake and eat it too.
> > 
> >> I had thought about whether the IPI FIQ should be disabled when a
> >> replacement FIQ handler is installed, I deem it not to be a use case
> >> that the mainline kernel needs to be concerned about.
> > 
> > That would be nice.
> 
> Just to be clear, this is exactly the dynamic switching that I mentioned
> a couple of mails ago.
Ok, my takeaway is there is currently not enough interest from your side to 
implement it but you would support some changes if submitted?

> As I said such code should not especially hard to write but, with the
> current mainline kernel, the code would be unreachable and, as a result,
> likely also to be more or less untested.
Well, my misconception was, that this might be done by adding some ifdefs
but as Russell pointed out, that is not the way to go.

Best regards
 Tim
