From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Oct 2015 10:37:19 +0100
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <5022096.8QRzW0l3EJ@wuerfel>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <5022096.8QRzW0l3EJ@wuerfel>
Message-ID: <20151006093718.GA30154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 09:49:29AM +0200, Arnd Bergmann wrote:
> On Tuesday 06 October 2015 11:05:43 Manjeet Pawar wrote:
> > MINSIGSTKSZ and SIGSTKSZ for ARM64 are not correctly set in latest kernel.
> > This patch fixes this issue.
> > 
> > This issue is reported in LTP (testcase: sigaltstack02.c).
> > Testcase failed when sigaltstack() called with stack size "MINSIGSTKSZ - 1"
> > Since in Glibc-2.22, MINSIGSTKSZ is set to 5120 but in kernel
> > it is set to 2048 so testcase gets failed.
> > 
> > Testcase Output:
> > sigaltstack02 1  TPASS  :  stgaltstack() fails, Invalid Flag value,errno:22
> > sigaltstack02 2  TFAIL  :  sigaltstack() returned 0, expected -1,errno:12
> > 
> > Reported Issue in Glibc Bugzilla:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=16850
> > 
> > Bugfix in Glibc-2.22:
> > https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=blob;f=sysdeps/unix/
> > sysv/linux/aarch64/bits/sigstack.h;h=8f2fb76e3e81734ef8a9cf9ae40daf4705
> > f31c35;hb=b763f6ae859ecea70a5dacb8ad45c71d5f667e2e
> > 
> > Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> > Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> > Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
> 
> This looks correct now. A few more points though:
> 
> * My first thought would have been to do this by first defining the
>   two symbols before the #include, and then adding an #ifdef in
>   the generic file. Both approaches work though, any other opinions
>   on this?

That's what I was thinking as well. Maybe with a single #ifndef
MINSIGSTKSZ to cover both macros.

> * Do we need to backport this to stable?

I think it does.

-- 
Catalin
