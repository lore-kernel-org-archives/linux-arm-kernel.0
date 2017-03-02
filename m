From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 02 Mar 2017 21:47:07 +1100
Subject: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
Message-ID: <87varsj6qc.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Daney <david.daney@cavium.com> writes:

> For powerpc the __jump_table section in modules is not aligned, this
> causes a WARN_ON() splat when loading a module containing a __jump_table.

Thanks for doing the patch.

If it helps:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

> Strict alignment became necessary with commit 3821fd35b58d
> ("jump_label: Reduce the size of struct static_key"), currently in
> linux-next, which uses the two least significant bits of pointers to
> __jump_table elements.

It would obviously be nice if this could go in before the commit that
exposes the breakage, but I guess that's problematic because Steve
doesn't want to rebase the tracing tree.

Steve I think you've already sent your pull request for this cycle? So I
guess if this can go in your first batch of fixes?

Or we could just send it directly to Linus?

cheers

> Fix by forcing __jump_table to 8, which is the same alignment used for
> this section in the kernel proper.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> ---
>  scripts/module-common.lds | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
> index 73a2c7d..53234e8 100644
> --- a/scripts/module-common.lds
> +++ b/scripts/module-common.lds
> @@ -19,4 +19,6 @@ SECTIONS {
>  
>  	. = ALIGN(8);
>  	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
> +
> +	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  }
> -- 
> 2.9.3
