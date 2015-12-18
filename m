From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 18 Dec 2015 10:44:52 +0100
Subject: [PATCH 0/3] Batched user access support
In-Reply-To: <alpine.LFD.2.20.1512171016510.27310@i7>
References: <alpine.LFD.2.20.1512171016510.27310@i7>
Message-ID: <20151218094452.GA32455@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> So I already sent the end result of these three patches to the x86 people, 
> but since I *think* it may bve an arm64 issue too, I'm including the arm64 
> people too for information.
> 
> Background for the the arm64 people: I upgraded my main desktop to 
> Skylake, and did my usual build performance tests, including a perf run to 
> check that everything looks fine. Yes, the machine is 20% faster than my 
> old one, but the profile also shows that now that I have a CPU that 
> supports SMAP, the overhead of that on the user string handling functions 
> was horrendous.
> 
> Normally, that probably isn't really noticeable, but on loads that do a 
> ton of pathname handling (like a "make -j" on the fully built kernel, or 
> doing "git diff" etc - both of which spend most of their time just doing 
> 'lstat()' on all the files they care about), the user space string 
> accesses really are pretty hot.
> 
> On the 'make -j' test on a fully built kernel, strncpy_from_user() was 
> about 1.5% of all CPU time. And almost two thirds of that was just the 
> SMAP overhead.

Just curious: by how much did the overhead shift after your patches?

> So this patch series introduces a model for batching that SMAP overhead on 
> x86, and the reason the ARM people are involved is that the same _may_ be 
> true of the PAN overhead. I don't know - for all I know, the pstate "set 
> pan" instruction may be so cheap on ARM64 that it doesn't really matter.
> 
> Thew new interface is very simple: new "unsafe_{get,put}_user()" functions 
> that have exactly the same semantics as the old unsafe ones (that weren't 
> called "unsafe", but have the two underscores). The only difference is 
> that you have to use "user_access_{begin,end}()" around them, which allows 
> the architecture to hoist the user access permission wrapper to outside 
> the loop, and then batch the raw accesses.
> 
> The series contains this addition to uaccess.h:
> 
>   #ifndef user_access_begin
>   #define user_access_begin() do { } while (0)
>   #define user_access_end() do { } while (0)
>   #define unsafe_get_user(x, ptr) __get_user(x, ptr)
>   #define unsafe_put_user(x, ptr) __put_user(x, ptr)
>   #endif
> 
> so architectures that don't care or haven't implemented it yet, don't need 
> to worry about it. Architectures that _do_ care just need to implement 
> their own versions, and make sure that user_access_begin is a macro (it 
> may obviously be an inline function and just then an additional 
> self-defining macro).
> 
> Any comments? 

I like this interface, especially the method of naming it 'unsafe'. This draws 
review focus on them - and we had a number of security holes with the 
__get/put_user() 'fast' variants before, which are named in a too benign fashion.

Btw., still today, when I use get_user()/put_user() APIs after a few weeks of not 
having coded such code, I have to look up their argument order in the headers ... 
while I don't have to look up memcpy() arguments.

In hindsight, if we could go back 20 years, I'd organize our user memory access 
APIs in such a fashion:

	memcpy_begin()

	memcpy_user_kernel(userptr, kernelvar)
	memcpy_kernel_user(kernelvar, userptr)

	memcpy_user_kernel(userptr, kernelptr, size)
	memcpy_kernel_user(kernelptr, userptr, size)

	memcpy(kernelptr1, kernelptr2, size)

	memcpy_end()

and I'd use the regular memcpy ordering. GCC macro magic would make a distinction 
between our 2-argument auto-sizing optimized APIs:

	memcpy_user_kernel(userptr, kernelvar)

and the regular 3-argument sized memcpy:

	memcpy_user_kernel(userptr, kernelptr, size)

i.e. generated could would still be the exact same as today, but the argument 
order is streamlined, and it matches the naming of the API: 'user_kernel' fits 
'userptr, kernelvar'.

It's also easy to read at a glance, every 'user_kernel' API conceptually maps to a 
regular C assignment:

	uservar = kernelvar;

In fact we might want to harmonize the APIs a bit more and make the 2-argument 
APIs all pointer based:

	memcpy_user_kernel(userptr, kernelptr)
	memcpy_kernel_user(kernelptr, userptr)

the pointers still have to be type compatible so I think it's still just as 
robust.

There would be various other advantages to such a family of APIs as well:

 - while get/put matches the read/write IO logic, in reality it's very often mixed 
   with memcpy and C variable assigment code, and the mixed and conflicting
   semantics are IMHO lethal to robustness.

 - with this it's all a single well-known pattern, throughout all major user
   memory access APIs.

 - subsequently it's also harder to mis-review what such code does and what
   security implications it has.

 - the naming space is easily extensible: does any code need memcpy_user_user()
   perhaps? Or memcpy_user_iomem()?

 - another dimension for intuitive extensions would be _nocache() variants for 
   non-local copies. Variants of such APIs do exist, but the naming is not very 
   well organized.

But there are of course the disadvantages:

 - I guess we don't want to change thousands of get_user()/put_user() API
   usages ... We could automate 99.9% of it, and we could make it all graceful
   (i.e. keep the old APIs as well), but it would still be a big change.

 - [ I might have missed some advantage of the get/put idiom that my suggestion
     regresses. ]

Changing this is something I'd love to volunteer for though, so I thought I'd 
throw in the offer ;-)

Thanks,

	Ingo
