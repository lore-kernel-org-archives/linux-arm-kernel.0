From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 2 Mar 2017 13:11:19 -0500
Subject: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
Message-ID: <20170302131119.6f52203f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Can I get an Ack from a module maintainer?

Thanks!

-- Steve


On Wed,  1 Mar 2017 14:04:53 -0800
David Daney <david.daney@cavium.com> wrote:

> For powerpc the __jump_table section in modules is not aligned, this
> causes a WARN_ON() splat when loading a module containing a __jump_table.
> 
> Strict alignment became necessary with commit 3821fd35b58d
> ("jump_label: Reduce the size of struct static_key"), currently in
> linux-next, which uses the two least significant bits of pointers to
> __jump_table elements.
> 
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
