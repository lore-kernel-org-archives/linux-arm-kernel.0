From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Oct 2015 11:31:34 +0100
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <5022096.8QRzW0l3EJ@wuerfel>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <5022096.8QRzW0l3EJ@wuerfel>
Message-ID: <20151006103128.GN6281@e103592.cambridge.arm.com>
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
> 
> * It seems that PowerPC has the same bug. Care to fix that as well?
> 
> * Do we need to backport this to stable?
> 
> * Can you explain in the changelog how the numbers were decided?
>   I don't see any other architecture using 5kb and cannot see why
>   it has to be this value rather than something else.

glibc quietly "fixed" this earlier this year, by inventing these numbers
and putting them in the glibc headers. [1]

Except for a moribund architecture that will never be extended I
think that the idea of MINSIGSTKSZ is badly flawed -- a #define
for not-necessarily-quite-enough-stack-to-realistically-take-a-signal
is a pretty useless concept even if the signal frame never grows, and
it looks like it is little used in practice.

Most arches are fairly generous with SIGSTKSZ, though there is no
correct answer for exactly how generous they should be in order to
be future proof.  (ia64 is a case in point, where an generous but
misspelled number got baked in as ABI -- after misspelling the
number was still generous; the precise value is irrelevant).

Since this bug hasn't been reported until now, I suspect that
MINSIGSTKSZ is used very rarely or not at all by real userspace
software.  I wonder whether we can get away with simply raising
MINSIGSTKSZ to match SIGSTKSZ, since it's clear that any software
using MINSIGSTKSZ was already broken.

[1] https://sourceware.org/ml/libc-alpha/2015-04/msg00033.html

Cheers
---Dave

[...]
