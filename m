From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Sep 2015 22:08:17 +0200
Subject: [PATCH] selftests/seccomp: build on aarch64, document ABI
In-Reply-To: <20150909193025.GA29244@www.outflux.net>
References: <20150909193025.GA29244@www.outflux.net>
Message-ID: <19228212.s6UOoYJca9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 September 2015 12:30:27 Kees Cook wrote:
> The syscall ABI is inconsistent on aarch64 compat, so at least we should
> document it in the seccomp_bpf tests.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Can you explain in what way the ABI is inconsistent here?

> ---
> Can someone with access to native aarch64 double-check this for me? I
> think we need to change these tests to pass if it's expected, but the
> compat behavior seems bad. It means compat code will break under an
> aarch64 kernel, when dealing with syscalls, like through seccomp.
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 770f47adf295..866ff42e000d 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -33,6 +33,10 @@
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  
> +#if defined(__aarch64__) && !defined(__NR_poll)
> +# define __NR_poll 0x49
> +#endif

I don't understand this: 0x49 is __NR_ppoll on arm64 and all architectures
that use asm-generic/unistd.h, not __NR_poll, which is no longer used there.

If this is intentional, it at least needs a comment to explain the
situation, and be extended to all other architectures that do not have
a poll() system call.

The arm32 version of sys_poll should be available as 168 in both native
and compat mode.

	Arnd
