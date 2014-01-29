From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 29 Jan 2014 14:39:14 +0000
Subject: [RFC] arm: vdso: Convert sigpage to vdso implementation
In-Reply-To: <52E81BB7.7070201@mentor.com>
References: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
 <52E81BB7.7070201@mentor.com>
Message-ID: <20140129143913.GB12965@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 03:05:59PM -0600, Nathan Lynch wrote:
> Hi Steve,
> 
> On 01/28/2014 10:25 AM, Steve Capper wrote:
> > ARM has a special sigpage that is used for signal return trampolines.
> > Its implementation is very similar to a VDSO conceptually in that it
> > occupies a special mapping in user address space.
> > 
> > One could actually host the trampoline code in a VDSO instead with the
> > added advantage that one could also host specialised routines there.
> > One such routine could be gettimeofday where on ARM we have architected
> > (and some vendor supplied) timers that can be queried entirely in
> > userspace, obviating the need for an expensive syscall.
> > 
> > This patch converts the sigpage implementation to a VDSO. It is mostly
> > a direct port from Will Deacon's arm64 implementation with the ARM
> > signal trampoline plumbed in.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > ---
> > As can be inferred from this RFC, I am interested ultimately in
> > implementing a syscall-less gettimeofday for ARM. Whilst researching
> > possible vectors page or VDSO implementations, I came across the
> > sigpage mechanism which is very similar to a VDSO.
> > 
> > The very simple function, __kernel_vdso_doubler, resolved in a test
> > program automatically on my Arndale board (running Fedora 20) without
> > any additional prodding.
> > 
> > IPC stress tests from LTP were executed to test the signal trampoline.
> > 
> > I would appreciate any comments on this approach of converting the
> > sigpage to a VDSO. If this looks sane to people, I will work on the
> > gettimeofday logic in a later patch.
> 
> As it happens, I've been working on a vDSO implementation of
> gettimeofday/clock_gettime which does not mess with the signal page.
> I'll reply with the patch separately in a moment.

Cheers Nathan,
-- 
Steve
> 
> 
