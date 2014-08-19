From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Aug 2014 18:37:42 +0100
Subject: [PATCH v10 03/19] arm: fiq: Replace default FIQ handler
In-Reply-To: <1408466769-20004-4-git-send-email-daniel.thompson@linaro.org>
References: <1408369264-14242-1-git-send-email-daniel.thompson@linaro.org>
 <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1408466769-20004-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140819173742.GG30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 05:45:53PM +0100, Daniel Thompson wrote:
> +int register_fiq_nmi_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_register(&fiq_nmi_chain, nb);
> +}
> +
> +asmlinkage void __exception_irq_entry fiq_nmi_handler(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	nmi_enter();
> +	atomic_notifier_call_chain(&fiq_nmi_chain, (unsigned long)regs, NULL);
> +	nmi_exit();
> +	set_irq_regs(old_regs);
> +}

Really not happy with this.  What happens if a FIQ occurs while we're
inside register_fiq_nmi_notifier() - more specifically inside
atomic_notifier_chain_register() ?

This is how easy it is to end up with a deadlock-able situation with
FIQs, and it is why I said:

| > 2. Have default trap handler call an RCU notifier chain to allow it to
| >    hook up with "normal" code without any hard coding (kgdb, IPI
| >    handling, etc)
| 
| Maybe... that sounds like it opens up FIQ for general purpose use which
| is something I want to avoid - I've little motivation to ensure that
| everyone plays by the rules.  Given the choice, I'd rather maintain our
| present stance that using FIQs is hard and requires a lot of thought.

You've just proven my point.

So, what I want is to make FIQs hard to use.  No notifier chain at all
please, people can't be trusted to know all the details (even if they
do know the details, it's just been proven that it's incredibly difficult
to do it right.)

What I instead want to see is that users get added to the above code
fragment with #ifdef's around the calls - that way ensuring that people
have to modify this file, and therefore /should/ be copying me with
their patches.  That means less chance for someone to sneak a change
in by merely calling some register function without first having to
copy this mailing list.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
