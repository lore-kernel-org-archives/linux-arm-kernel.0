From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 26 Mar 2010 02:47:59 +0000
Subject: [C/R ARM][PATCH 3/3] c/r: ARM implementation of checkpoint/restart
In-Reply-To: <7d08b87d1003241348g347f092k1142318490e0bdcc@mail.gmail.com>
References: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
	<1269219965-23923-4-git-send-email-christofferdall@christofferdall.dk>
	<20100323211843.GC19572@n2100.arm.linux.org.uk>
	<7d08b87d1003241348g347f092k1142318490e0bdcc@mail.gmail.com>
Message-ID: <20100326024759.GN19308@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoffer Dall wrote:
> > That doesn't indicate what ISA version the system is running on, or even
> > if the ABI is compatible (we have two ABIs - OABI and EABI).
> 
> That's why I checkpointed CONFIG_OABI_COMPAT, but I realize that it's
> not sufficient.
> 
> How about checkpointing CONFIG_AEABI and CONFIG_OABI_COMPAT and making
> sure that we either restore to the same setting of the two or restore
> to CONFIG_OABI_COMPAT=y?

With CONFIG_OABI_COMPAT enabled, each process can be in either
personality: OABI or EABI.  Checkpointing will need to remember which
one.

With CONFIG_OABI_COMPAT disabled, it'll be fixed at one or the other,
but there's no reason why a process should not be moved between
kernels with different values of CONFIG_OABI_COMPAT, so long as the
OABI or EABI personality is supported by the destination kernel.

In other words, CONFIG_OABI_COMPAT shouldn't be in the checkpoint
state at all - only the per-process personalities should be.

> >> We checkpoint whether the system is running with CONFIG_MMU or not and
> >> require the same configuration for the system on which we restore the
> >> process. It might be possible to allow something more fine-grained,
> >> if it's worth the energy. Input on this item is also very welcome,
> >> specifically from someone who knows the exact meaning of the end_brk
> >> field.
> >
> > Processes which run on MMU and non-MMU CPUs are unlikely to be
> > interchangable - the run time environments are quite different. ?I
> > think this is a sane check.
> >
> thanks.

It's possible in principle to run many non-MMU binaries on MMU
kernels, but I've never heard of anyone doing it.

-- Jamie
