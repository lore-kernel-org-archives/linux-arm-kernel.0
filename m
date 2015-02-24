From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 24 Feb 2015 07:35:14 +0100
Subject: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack, soft
 lockups and hard lockups
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Message-ID: <20150224063513.GA15387@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Anton Blanchard <anton@samba.org> wrote:

> Every now and then I end up with an undebuggable issue 
> because multiple CPUs hit something at the same time and 
> everything is interleaved:
> 
>         CR: 48000082  XER: 00000000
>         ,RI
>         c0000003dc72fd10
>         ,LE
>         d0000000065b84e8
>         Instruction dump:
>         MSR: 8000000100029033
> 
> Very annoying.
> 
> Some architectures already have their own recursive 
> locking for oopses and we have another version for 
> serialising dump_stack.
> 
> Create a common version and use it everywhere (oopses, 
> BUGs, WARNs, dump_stack, soft lockups and hard lockups). 

Dunno. I've had cases where the simultaneity of the oopses 
(i.e. their garbled nature) gave me the clue about the type 
of race to expect.

To still get that information: instead of taking a 
serializing spinlock (or in addition to it), it would be 
nice to at least preserve the true time order of the 
incidents, at minimum by generating a global count for 
oopses/warnings (a bit like the oops count # currently), 
and to gather it first - before taking any spinlocks.

Thanks,

	Ingo
