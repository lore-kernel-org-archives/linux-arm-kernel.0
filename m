From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 09:49:29 +0200
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
Message-ID: <5022096.8QRzW0l3EJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 11:05:43 Manjeet Pawar wrote:
> MINSIGSTKSZ and SIGSTKSZ for ARM64 are not correctly set in latest kernel.
> This patch fixes this issue.
> 
> This issue is reported in LTP (testcase: sigaltstack02.c).
> Testcase failed when sigaltstack() called with stack size "MINSIGSTKSZ - 1"
> Since in Glibc-2.22, MINSIGSTKSZ is set to 5120 but in kernel
> it is set to 2048 so testcase gets failed.
> 
> Testcase Output:
> sigaltstack02 1  TPASS  :  stgaltstack() fails, Invalid Flag value,errno:22
> sigaltstack02 2  TFAIL  :  sigaltstack() returned 0, expected -1,errno:12
> 
> Reported Issue in Glibc Bugzilla:
> https://sourceware.org/bugzilla/show_bug.cgi?id=16850
> 
> Bugfix in Glibc-2.22:
> https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=blob;f=sysdeps/unix/
> sysv/linux/aarch64/bits/sigstack.h;h=8f2fb76e3e81734ef8a9cf9ae40daf4705
> f31c35;hb=b763f6ae859ecea70a5dacb8ad45c71d5f667e2e
> 
> Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>

This looks correct now. A few more points though:

* My first thought would have been to do this by first defining the
  two symbols before the #include, and then adding an #ifdef in
  the generic file. Both approaches work though, any other opinions
  on this?

* It seems that PowerPC has the same bug. Care to fix that as well?

* Do we need to backport this to stable?

* Can you explain in the changelog how the numbers were decided?
  I don't see any other architecture using 5kb and cannot see why
  it has to be this value rather than something else.

	Arnd

> ---
> v1 -> Changes in uapi overall header
> v2 -> Changes done in arm64 headers
> 
>  arch/arm64/include/uapi/asm/signal.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/signal.h b/arch/arm64/include/uapi/asm/signal.h
> index 8d1e723..5ac56cf 100644
> --- a/arch/arm64/include/uapi/asm/signal.h
> +++ b/arch/arm64/include/uapi/asm/signal.h
> @@ -21,4 +21,9 @@
>  
>  #include <asm-generic/signal.h>
>  
> +#undef MINSIGSTKSZ
> +#undef SIGSTKSZ
> +#define MINSIGSTKSZ 5120
> +#define SIGSTKSZ    16384
> +
>  #endif
> 
