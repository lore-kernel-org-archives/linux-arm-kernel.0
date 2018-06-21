From: stefan@agner.ch (Stefan Agner)
Date: Thu, 21 Jun 2018 09:25:48 +0200
Subject: Dynamic ftrace self test broken on ARM
In-Reply-To: <20180620212906.24b7b66e@vmware.local.home>
References: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
 <20180618175437.3e6c85a1@gandalf.local.home>
 <b9f269ed2143688c38cdcbba7367b101@agner.ch>
 <20180619091735.7aec75d0@gandalf.local.home>
 <5e26cebbb2ebeb87fdc808509881736b@agner.ch>
 <20180620101311.0bcd73d3@gandalf.local.home>
 <7904ed3fe9f59a54526d64f366915b43@agner.ch>
 <e4181ae694d44913a8eba4618477bd3b@agner.ch>
 <ac0178fb75658a8d7d7b1931691c7755@agner.ch>
 <20180620230734.GO17671@n2100.armlinux.org.uk>
 <20180620212906.24b7b66e@vmware.local.home>
Message-ID: <daf9cea94b0baf23563c575fbab1a4da@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.06.2018 03:29, Steven Rostedt wrote:
> On Thu, 21 Jun 2018 00:07:34 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> 
>> > Any input from ARM folks?
>>
>> The same issues must exist on other architectures as ARM is not the only
>> architecture to implement read-only kernel text and dynamic ftrace, so
>> surely this problem isn't unique to ARM.
> 
> Probably because of the way set_kernel_text_ro() is implemented in
> other archs. For example, in x86, we have:
> 
> void set_kernel_text_ro(void)
> {
> 	unsigned long start = PFN_ALIGN(_text);
> 	unsigned long end = PFN_ALIGN(__stop___ex_table);
> 
> 	if (!kernel_set_to_readonly)
> 		return;
> 
> 	/*
> 	 * Set the kernel identity mapping for text RO.
> 	 */
> 	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
> }
> 
> and arm has:
> 
> void set_kernel_text_ro(void)
> {
> 	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), true,
> 				current->active_mm);
> }
> 
> Where x86's set_kernel_text_ro() is a nop until the
> kernel_set_to_readonly is set.
> 
> Perhaps this may fix things?
> 
> [ Not even compiled tested ]
> 
> -- Steve
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index c186474422f3..0cc8e04295a4 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
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

This aligns nicely with how this has been solved with commit
162396309745 ("ftrace, x86: make kernel text writable only for
conversions") a while ago.
Reviewed-by: Stefan Agner <stefan@agner.ch>

Compiled and tested here, selftest as well as ftrace at runtime seems to
work fine.
Tested-by: Stefan Agner <stefan@agner.ch>

Thanks Steven! Can you send a patch or should I do it?

--
Stefan
