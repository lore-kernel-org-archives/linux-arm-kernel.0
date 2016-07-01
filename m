From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jul 2016 22:45:59 +0200
Subject: [PATCH v2 4/4] dynamic_debug: add jump label support
In-Reply-To: <575F184F.9010604@akamai.com>
References: <cover.1463778029.git.jbaron@akamai.com>
 <5640634.eWRyv1HFLD@wuerfel> <575F184F.9010604@akamai.com>
Message-ID: <10022037.rzjeY1zYxh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 13, 2016 4:32:15 PM CEST Jason Baron wrote:
> On 06/13/2016 04:23 PM, Arnd Bergmann wrote:
> > On Monday, June 13, 2016 6:05:22 PM CEST Arnd Bergmann wrote:
> >> On Friday, June 10, 2016 11:33:07 AM CEST Jason Baron wrote:
> >>> On 06/10/2016 05:54 AM, Arnd Bergmann wrote:
> >>>> On Friday, May 20, 2016 5:16:36 PM CEST Jason Baron wrote:
> >>>>> Although dynamic debug is often only used for debug builds, sometimes its
> >>>>> enabled for production builds as well. Minimize its impact by using jump
> >>>>> labels. This reduces the text section by 7000+ bytes in the kernel image
> >>>>> below. It does increase data, but this should only be referenced when
> >>>>> changing the direction of the branches, and hence usually not in cache.
> >>>>>
> >>>>>    text         data     bss     dec     hex filename
> >>>>> 8194852      4879776  925696 14000324         d5a0c4 vmlinux.pre
> >>>>> 8187337      4960224  925696 14073257         d6bda9 vmlinux.post
> >>>>>
> >>>>> Signed-off-by: Jason Baron <jbaron@akamai.com>
> >>>>> ---
> >>>>
> >>>> This causes problems for some of my randconfig builds, when a dynamic
> >>>> debug call is used inside of an __exit function:
> >>>>
> >>>> `.exit.text' referenced in section `__jump_table' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> >>>> `.exit.text' referenced in section `__jump_table' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> >>>>
> >>>
> >>> I stuck pr_debug() in a few functions marked with __exit, but did not
> >>> reproduce yet. Can you share your .config and gcc --version.
> >>>
> >>
> >> I found these on ARM randconfig builds e.g. this one
> >> http://pastebin.com/raw/KjWHxnwU
> >>
> >> I also have some other patches applied that could have interacted with your
> >> change, so if you can't reproduce it easily, let me try it on a plain linux-next
> >> kernel.
> >>
> >> The compiler I use is  arm-linux-gnueabi-gcc (GCC) 6.0.0 20160323 (experimental)
> > 
> > Update: on ARM, I have been able to reproduce this with gcc-4.6
> > and gcc-4.8, so I'm pretty confident that this is independent of the
> > toolchain. However, I have so far failed to reproduce this on x86.
> > 
> > Looking at the exit_ceph() function, I get these two assembly outputs,
> > ARM fails with the link error above:
> > 
> 
> ok, does this fix things up?
> 
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -44,7 +44,7 @@
>  #endif
> 
>  #if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> -       defined(CONFIG_GENERIC_BUG)
> +       defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
>  #define ARM_EXIT_KEEP(x)       x
>  #define ARM_EXIT_DISCARD(x)
>  #else
> 

Hi Jason,

sorry for missing your email earlier (and your reminder too), the thread
just popped up after Chris Metcalf's reply.

Your patch above probably avoids this, but now I can't reasily test it
since it's not in linux-next any more. If you have a git tree I can
pull into my test setup, I'll try it out again.

	Arnd
