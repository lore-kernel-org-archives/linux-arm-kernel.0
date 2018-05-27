From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 27 May 2018 13:29:55 -0500
Subject: linux-next: manual merge of the userns tree with the arm tree
In-Reply-To: <20180525101455.GI4828@sirena.org.uk> (Mark Brown's message of
 "Fri, 25 May 2018 11:14:55 +0100")
References: <20180525101455.GI4828@sirena.org.uk>
Message-ID: <876039uf30.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> Hi Eric,
>
> Yesterday's linux-next merge of the userns tree got a conflict in:
>
>   arch/arm/mm/fault.c
>
> between commit:
>
>   8d9267cedb9e1d8edb8 ("ARM: spectre-v2: harden user aborts in kernel space")
>
> from the arm tree and commit:
>
>   3eb0f5193b497083391 ("signal: Ensure every siginfo we send has all bits initialized")
>
> from the userns tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Mark.  Did you get a bounce from this email?

I saw this when perusing lkml but I did not receive a copy of this
directly to myself.

Eric

> diff --cc arch/arm/mm/fault.c
> index 3b1ba003c4f9,32034543f49c..000000000000
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@@ -163,9 -163,8 +163,11 @@@ __do_user_fault(struct task_struct *tsk
>   {
>   	struct siginfo si;
>   
> + 	clear_siginfo(&si);
> + 
>  +	if (addr > TASK_SIZE)
>  +		harden_branch_predictor();
>  +
>   #ifdef CONFIG_DEBUG_USER
>   	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
>   	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
