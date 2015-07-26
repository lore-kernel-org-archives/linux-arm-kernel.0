From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Jul 2015 22:45:54 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150715154056.GA10418@red-moon>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
 <1436430685-2202-4-git-send-email-jszhang@marvell.com>
 <20150714103421.GU7557@n2100.arm.linux.org.uk>
 <20150714110302.GA334@red-moon>
 <20150714122904.GV7557@n2100.arm.linux.org.uk>
 <20150714145546.GA14556@red-moon>
 <20150714204138.GW7557@n2100.arm.linux.org.uk>
 <20150715134603.GA14862@red-moon>
 <20150715144507.GZ7557@n2100.arm.linux.org.uk>
 <20150715154056.GA10418@red-moon>
Message-ID: <20150726214554.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 04:40:56PM +0100, Lorenzo Pieralisi wrote:
> static struct cpuidle_ops psci_cpuidle_ops __initdata = {
> 	.suspend = cpu_psci_cpu_suspend,
> 	.init = cpu_psci_cpu_init_idle,
> };
> CPUIDLE_METHOD_OF_DECLARE(psci_cpuidle, "psci", &psci_cpuidle_ops);
> 
> to drivers/firmware unless it is guarded by CONFIG_ARM, that's what
> I am saying, is that clear ?

I'd appreciate it if you didn't go bitching to Philippe, who then phones
me to discuss this problem.  That's not the way "business" is done.

You definitely _can_ move this into drivers/.  There's absolutely nothing
stopping that.  Yes, CPUIDLE_METHOD_OF_DECLARE() may be an ARM-only thing,
that doesn't stop drivers using it - and the hint there is in the name.
Drivers.  They belong in the drivers/ subdirectory, not the arch/
subdirectory.

What's so difficult to get about that?

All two _existing_ users of CPUIDLE_METHOD_OF_DECLARE() are in drivers/
already:

$ git grep CPUIDLE_METHOD_OF_DECLARE
arch/arm/include/asm/cpuidle.h:#define CPUIDLE_METHOD_OF_DECLARE(name, _method,_ops)                   \
drivers/soc/qcom/spm.c:CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
drivers/soc/qcom/spm.c:CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);

So there's absolutely no argument you can possibly make about "it's in
asm/ so code using it must be in arch/arm."

> How do you want us to do it ?

I want this under drivers/, like I've said already several times in
this thread.

> M.Rutland's patch series represents the code reorganisation and as far
> as I am concerned that's a complete and well defined plan, I still do
> not understand why you are NAKing that piece of code, it is completely
> orthogonal to what we are debating above, please have a look at it
> otherwise we are going around in circles here.

It's not a well-defined plan if it involves dispersing related code or
data structures across the kernel tree, especially when there is very
little reason for it to be dispersed.

> > Right now, I'm getting the impression that there is _no_ plan, or if
> > there is, it's an absurd plan which results in data structures which
> > should not be in arch/arm being left behind there.
> 
> Mark's series does not leave any data structure behind, it is moving
> code to a common place in the kernel so that the _current_ PSCI
> implementation can be shared between ARM and ARM64, again please
> have a look at it, we can tackle how to define cpuidle_ops in a way
> that you deem reasonable later, it is a separate issue, please
> understand.

You misunderstand me.  Yes, Mark's series _on its own_ doesn't leave it
behind, but it _has the effect_ that when combined with subsequent
patches, it _causes_ that to happen.

Look, there's a simple solution to this: if the plan is to move CPU idle
PSCI support into drivers/ then lets move the whole thing into drivers.
That's a sane plan.  What isn't a sane plan is to mvoe all the CPU idle
PSCI code into drivers/ and then have a PSCI data structure left in
arch/arm/.

It can live in a separate file which is only built for ARM, rather than
having ifdefs surround it, but the important thing is that it is localised
with the rest of the code, so as changes happen, it gets noticed.  No one
in years to come will remember to look in arch/arm/ when making changes to
the PSCI CPU idle code.

This is no different to what drivers/soc/qcom/spm.c is doing.

So.  Sane plan: "let's move all the PSCI stuff into drivers/whatever/psci/".
That's something I'm happy with.

Insane plan: "let's move the PSCI code into drivers/whatever/psci/, let's
keep PSCI data structures using that code in arch/arm".  That plan (in its
entirety) I'm NAKing, because it is _no_ plan.

Lastly, I didn't realise that is an ARM only thing - that was merged
without my involvement or ACK, the change wasn't even CC'd to me (so
it's no wonder I know little about it.)  I'd have NAKed that change too
had I seen it, suggesting that the contents of it (which are used by
drivers/soc/qcom/spm.c) should be located elsewhere - something which
I've done in the past when people have tried to shove stuff into
arch/arm/include/asm which gets used by stuff outside of arch/arm.

Are we clear?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
