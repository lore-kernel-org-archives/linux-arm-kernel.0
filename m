From: stefan@agner.ch (Stefan Agner)
Date: Wed, 04 Jul 2018 13:30:28 +0200
Subject: [PATCH] ARM: ftrace: Only set kernel memory back to read-only
 after boot
In-Reply-To: <20180621124710.453ee0ae@gandalf.local.home>
References: <20180621124710.453ee0ae@gandalf.local.home>
Message-ID: <7aa5a479aa484775f492dc5251bcf5c9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.06.2018 18:47, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Dynamic ftrace requires modifying the code segments that are usually
> set to read-only. To do this, a per arch function is called both before
> and after the ftrace modifications are performed. The "before" function
> will set kernel code text to read-write to allow for ftrace to make the
> modifications, and the "after" function will set the kernel code text
> back to "read-only" to keep the kernel code text protected.
> 
> The issue happens when dynamic ftrace is tested at boot up. The test is
> done before the kernel code text has been set to read-only. But the
> "before" and "after" calls are still performed. The "after" call will
> change the kernel code text to read-only prematurely, and other boot
> code that expects this code to be read-write will fail.
> 
> The solution is to add a variable that is set when the kernel code text
> is expected to be converted to read-only, and make the ftrace "before"
> and "after" calls do nothing if that variable is not yet set. This is
> similar to the x86 solution from commit 162396309745 ("ftrace, x86:
> make kernel text writable only for conversions").
> 
> Reported-by: Stefan Agner <stefan@agner.ch>
> Tested-by: Stefan Agner <stefan@agner.ch>
> Link: http://lkml.kernel.org/r/20180620212906.24b7b66e at vmware.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index c186474422f3..0cc8e04295a4 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c

I guess this can be seen as reviewed?

Patches touching core ARM port usually go through Russels patch tracker.

You have to submit the patch here:
http://www.armlinux.org.uk/developer/patches/

--
Stefan


> @@ -736,20 +736,29 @@ static int __mark_rodata_ro(void *unused)
>  	return 0;
>  }
>  
> +static int kernel_set_to_readonly __read_mostly;
> +
>  void mark_rodata_ro(void)
>  {
> +	kernel_set_to_readonly = 1;
>  	stop_machine(__mark_rodata_ro, NULL, NULL);
>  	debug_checkwx();
>  }
>  
>  void set_kernel_text_rw(void)
>  {
> +	if (!kernel_set_to_readonly)
> +		return;
> +
>  	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), false,
>  				current->active_mm);
>  }
>  
>  void set_kernel_text_ro(void)
>  {
> +	if (!kernel_set_to_readonly)
> +		return;
> +
>  	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), true,
>  				current->active_mm);
>  }
