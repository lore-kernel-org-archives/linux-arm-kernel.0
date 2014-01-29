From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 29 Jan 2014 14:22:36 +0000
Subject: [RFC] arm: vdso: Convert sigpage to vdso implementation
In-Reply-To: <20140128171015.GM15937@n2100.arm.linux.org.uk>
References: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
 <20140128171015.GM15937@n2100.arm.linux.org.uk>
Message-ID: <20140129142235.GA12965@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2014 at 05:10:15PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 28, 2014 at 04:25:08PM +0000, Steve Capper wrote:
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
> I'm not happy with this removing much of the work I pushed into the
> kernel to work around the security issues which were identified with
> the fixed-address placement of stuff in the vectors page.  Particularly
> the random placement of the signal return stubs within the new signal
> page is gone with the VDSO approach, which means if someone can discover
> the VDSO page, they can issue any system call they please by knowing
> the appropriate offset into the page to call.

Hi Russell,
I didn't mean to undo you work.

Essentially I saw the sigpage was so close to being a vdso, it just
needed a little nudge to contain other code too.

> 
> While the VDSO page will be placed randomly, I'd also like to have the
> signal handlers placed randomly within that page as well - there's no
> need for them to be at a fixed offset.  The only thing which needs to
> know where they are after all is the kernel.

I was considering a larger segment containing the trampoline at random
offset, but came to the conclusion that the VA randomisation of the
vdso page location was in itself sufficient?

> 
> I'm not sure about putting gettimeofday() into this - gettimeofday()
> would need to have various kernel variables exported into userspace
> for the VDSO page to then compute the current time of day from the
> timer value(s), and that's certainly not going to be at a fixed
> address.

I believe a vdso data page could house the variables, the offsets
within the page could be fixed at compile time. 

> 
> I believe x86 eventually ended up going down the path of trapping and
> emulating calls to the VDSO page because VDSO became too much of a
> problem (though I think it does provide the option for having it back
> but not by default.)

Cheers,
-- 
Steve
