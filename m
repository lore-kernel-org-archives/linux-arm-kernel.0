From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Oct 2013 13:07:29 +0100
Subject: [PATCH] arm: vfp: always clear vfp_current_hw_state when
 forcing reload
In-Reply-To: <CAFUV4K1CkzGZVEwkXGX38jG0HxerqQq--d-qFiqF9J6wi88xYQ@mail.gmail.com>
References: <1380751187-11257-1-git-send-email-zyy@motorola.com>
 <20131002221123.GC12758@n2100.arm.linux.org.uk>
 <CAFUV4K3dsVDtHhQtuZ6yEQHxxHXaa9LODBZuGFipjAKumF4abQ@mail.gmail.com>
 <CAFUV4K1CkzGZVEwkXGX38jG0HxerqQq--d-qFiqF9J6wi88xYQ@mail.gmail.com>
Message-ID: <20131011120729.GW25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 11:00:18AM -0500, Yuanyuan ZHONG wrote:
> Hi Russell, et al
> 
> If there is no further comments, I'll submit it to patch system.
> Thanks.

No, I still don't agree with your patch as being the correct fix.  Look
at the code that you're creating:

        if (vfp_state_in_hw(cpu, thread)) {
                fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
                vfp_current_hw_state[cpu] = NULL;
        }
#ifdef CONFIG_SMP
        thread->vfpstate.hard.cpu = NR_CPUS;
        vfp_current_hw_state[cpu] = NULL;
#endif

So when SMP is enabled we unconditionally blat out the vfp_current_hw_state
pointer for this CPU?

What actually needs fixing is the call to this function in the hotplug
thread:

                vfp_force_reload((long)hcpu, current_thread_info());

I'd suggest this becomes:

		unsigned cpu = (long)hcpu;
		if (vfp_current_hw_state[cpu])
			vfp_force_reload(cpu, vfp_current_hw_state[cpu]);

That will force the right hw_state to be forced to reload, rather than
passing in the wrong thread state.
