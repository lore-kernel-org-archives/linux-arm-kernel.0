From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 14 Jul 2011 11:24:04 +0100 (BST)
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <mailman.2928.1310636156.20023.linux-arm-kernel@lists.infradead.org>
References: <mailman.2928.1310636156.20023.linux-arm-kernel@lists.infradead.org>
Message-ID: <alpine.DEB.2.00.1107141054400.2609@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Message: 6
> Date: Thu, 14 Jul 2011 11:33:10 +0200
> From: Wolfgang BETZ <wolfgang.betz@st.com>
> To: "linux-arm-kernel at lists.infradead.org"
> 	<linux-arm-kernel@lists.infradead.org>, 	"linux at arm.linux.org.uk"
> 	<linux@arm.linux.org.uk>
> Cc: "Rudolf.Dienstbeck at Lauterbach.com"
> 	<Rudolf.Dienstbeck@Lauterbach.com>,	Wolfgang BETZ
> 	<wolfgang.betz@st.com>,	Linus WALLEIJ <linus.walleij@stericsson.com>,
> 	Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>,
> 	"khaled.jmal at lauterbach.com" <khaled.jmal@lauterbach.com>,
> 	"marco.ferrario at lauterbach.it" <marco.ferrario@lauterbach.it>,
> 	"will.deacon at arm.com" <will.deacon@arm.com>,
> 	"maurizio.menegotto at lauterbach.it" <maurizio.menegotto@lauterbach.it>,
> 	David SIORPAES <david.siorpaes@st.com>,	Giuseppe DESOLI
> 	<giuseppe.desoli@st.com>
> Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
> 	of	ARM v6 & v7 Architectures
> Message-ID:
> 	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
>
> Content-Type: text/plain; charset="iso-8859-1"
>
> From: Wolfgang Betz <wolfgang.betz@st.com>

Hi Wolfgang,

sorry for replying through the digest, but I have comments on this one.

>
> The aim of this patch is to enable thread support in the context ID register
> (CONTEXTIDR) as it comes with ARM architectures v6 & v7.
[ ... ]
> +/*
> + * Set context ID for task and mm
> + */
> +static inline
> +void set_context_id(struct task_struct *tsk, struct mm_struct *mm)
> +{
> +	unsigned int ctxid = (unsigned int)calc_context_id(tsk, mm);
> +
> +	/* set the new ContextID */
> +	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (ctxid));
> +	isb();
> +}

While I'm not qualified to comment on the technical correctness of the 
patch, I've got a few questions about the way this change is done:

Specifically:

1. about the above, (unsigned int)calc_context_id(), the cast and/or
    the data type isn't required, the asm doesn't care about types.

Generally:

2. the patch changes the signature of cpu_switch_mm() but not all the
    callers (doesn't touch the kexec / reset / suspend paths), why ?

3. what does this patch do to non-v6/v7 architectures ? Are they all
    _guaranteed_ never to use the second arg ?

    what about future architectures ? Is it a good idea to force the
    2nd arg to an integer where right now it's a pointer to a data
    structure, possibly far more flexible at passing "any info" ?

4. with that patch in, calling cpu_switch_mm() requires availability
    of "current" because of the proxy-wrapping, call calc_context_id()
    before which uses "current".
    There are usecases (kexec, reset, hibernate) where code that wants
    to cpu_switch_mm doesn't have "current" because of a stack switch;
    how are these codepaths supposed to call it ? Is it ok to just
    pass NULL / garbage ?

FrankH.
