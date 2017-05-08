From: mingo@kernel.org (Ingo Molnar)
Date: Mon, 8 May 2017 09:33:52 +0200
Subject: [PATCH v9 1/4] syscalls: Verify address limit before returning
 to user-mode
In-Reply-To: <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
Message-ID: <20170508073352.caqe3fqf7nuxypgi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


(added more Cc:s)

* Thomas Garnier <thgarnie@google.com> wrote:

> On Fri, Apr 28, 2017 at 8:32 AM, Thomas Garnier <thgarnie@google.com> wrote:
> > Ensure that a syscall does not return to user-mode with a kernel address
> > limit. If that happens, a process can corrupt kernel-mode memory and
> > elevate privileges [1].
> >
> > The CONFIG_ADDR_LIMIT_CHECK option disables the generic check so each
> > architecture can create optimized versions. This option is enabled by
> > default on s390 because a similar feature already exists.
> >
> > [1] https://bugs.chromium.org/p/project-zero/issues/detail?id=990
> >
> > Signed-off-by: Thomas Garnier <thgarnie@google.com>
> > Tested-by: Kees Cook <keescook@chromium.org>
> 
> Ingo: Do you want to take the set?

Yeah, so now I'm questioning the whole premise of the feature, sorry :-/

A big disavantage is that the "security check" will add 2-5 instructions to the 
system call fast path. Every one of them, and essentially forever. Just to handle 
a CVE that was caused by a buggy touch-screen driver helper function leaking 
KERNEL_DS and which was fixed long ago ...

And yes, I realize that there were other such bugs and that such bugs might occur 
in the future - but why not push the overhead of the security check to the kernel 
build phase? I.e. I'm wondering how well we could do static analysis during kernel 
build - would a limited mode of Sparse be good enough for that? Or we could add a 
new static checker to tools/, built from first principles and used primarily for 
extended syntactical checking.

For example I'd consider it a good practice to mandate that if a kernel function 
sets KERNEL_DS then it must restore it as well. Any function that does not do 
that, or is too complex for the static analysis to prove correctness for sure 
should be considered buggy!

Are there any common kernel APIs outside set_fs() that set KERNEL_DS 
intentionally? The overwhelming pattern ought to be:

        orig_fs = get_fs();
        set_fs(KERNEL_DS);
	...
        set_fs(orig_fs);

... and even a relatively simple static analysis tool ought to be able to see 
through that.

I'd even suggest we do it not like Sparse builds are done today, but in a more 
integrated fashion: do static analysis as part of a typical kernel defconfig build 
and not tolerate warnings but go for a 'zero warnings' policy like Linus uses for 
modconfig builds.

_That_ solution I'd feel very, very good about - it would be so much better than 
any runtime checks...

Not to mention that such an integrated static analysis facility would allow many 
other things to be checked during build time, which we couldn't possibly check 
runtime.

Thanks,

	Ingo
