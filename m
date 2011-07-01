From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 1 Jul 2011 14:58:02 +0200
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of arbitrary
	physical addresses
In-Reply-To: <201106291106.00070.ptesarik@suse.cz>
References: <201106171038.25988.ptesarik@suse.cz>
	<20110617093032.GA19235@elte.hu>
	<201106291106.00070.ptesarik@suse.cz>
Message-ID: <20110701125802.GE12605@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Petr Tesarik <ptesarik@suse.cz> wrote:

> Dne P? 17. ?ervna 2011 11:30:32 Ingo Molnar napsal(a):
> > * Petr Tesarik <ptesarik@suse.cz> wrote:
> > > This patch series enhances /dev/mem, so that read and write is
> > > possible at any address. The patchset includes actual
> > > implementation for x86.
> > 
> > This series lacks a description of why this is desired.
> >[...]
> > 
> > Are you aware of any legitimate usecases?
> 
> Looking back at the mail tread, I'd say there are people who have 
> legitimate usecases. However, this may not be the most important 
> question. At the moment, the /dev/mem interface is broken (it 
> doesn't implement the specification correctly), and my patchset 
> fixes it.
> 
> If there are no technical objections, [...]

Well, my objections were entirely technical:

 - the device never implemented above-4G support upstream

 - there's colorful variants of abuse (drivers with binary-only
   userspace) even if we ignore the obvious fact that the
   main use of /dev/mem today is /dev/rootkit ...

Now my objections might be outweighed by the advantages of improving 
this driver, but you misrepresenting my position really does not help 
that process.

So what was not mentioned in your series, what is *your* motivation 
and your usecase? Enabling closed-source userspace drivers? Enabling 
the crash utility?

If the former then shame on you, if the latter then how do you 
explain that distros appear to disable the RAM aspect of /dev/mem:

 $ grep DEVMEM $(rpm -ql kernel-2.6.38-0.rc7.git2.3.fc16.x86_64 | grep config-2.6 )
 CONFIG_STRICT_DEVMEM=y

So the crash utility use-case does not work on unpatched, default 
kernels, right?

As i said i have no problem with extending this, as long as it 
couples to a non-default flag (for example !STRICT_DEVMEM or a boot 
flag) and thus does not extend by default and does not extend the 
abuse.

> @Ingo: you can also send a patchset that rips off the /dev/mem 
> driver completely if you believe that would get through. [...]

Why would we want to do that? Existing users can become more and more 
obsolete just fine.

What i'm asking for is to not enable new abuse by default ...

Thanks,

	Ingo
