From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 17:10:15 +0000
Subject: [RFC] arm: vdso: Convert sigpage to vdso implementation
In-Reply-To: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
References: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140128171015.GM15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 04:25:08PM +0000, Steve Capper wrote:
> ARM has a special sigpage that is used for signal return trampolines.
> Its implementation is very similar to a VDSO conceptually in that it
> occupies a special mapping in user address space.
> 
> One could actually host the trampoline code in a VDSO instead with the
> added advantage that one could also host specialised routines there.
> One such routine could be gettimeofday where on ARM we have architected
> (and some vendor supplied) timers that can be queried entirely in
> userspace, obviating the need for an expensive syscall.
> 
> This patch converts the sigpage implementation to a VDSO. It is mostly
> a direct port from Will Deacon's arm64 implementation with the ARM
> signal trampoline plumbed in.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> As can be inferred from this RFC, I am interested ultimately in
> implementing a syscall-less gettimeofday for ARM. Whilst researching
> possible vectors page or VDSO implementations, I came across the
> sigpage mechanism which is very similar to a VDSO.
> 
> The very simple function, __kernel_vdso_doubler, resolved in a test
> program automatically on my Arndale board (running Fedora 20) without
> any additional prodding.
> 
> IPC stress tests from LTP were executed to test the signal trampoline.
> 
> I would appreciate any comments on this approach of converting the
> sigpage to a VDSO. If this looks sane to people, I will work on the
> gettimeofday logic in a later patch.

I'm not happy with this removing much of the work I pushed into the
kernel to work around the security issues which were identified with
the fixed-address placement of stuff in the vectors page.  Particularly
the random placement of the signal return stubs within the new signal
page is gone with the VDSO approach, which means if someone can discover
the VDSO page, they can issue any system call they please by knowing
the appropriate offset into the page to call.

While the VDSO page will be placed randomly, I'd also like to have the
signal handlers placed randomly within that page as well - there's no
need for them to be at a fixed offset.  The only thing which needs to
know where they are after all is the kernel.

I'm not sure about putting gettimeofday() into this - gettimeofday()
would need to have various kernel variables exported into userspace
for the VDSO page to then compute the current time of day from the
timer value(s), and that's certainly not going to be at a fixed
address.

I believe x86 eventually ended up going down the path of trapping and
emulating calls to the VDSO page because VDSO became too much of a
problem (though I think it does provide the option for having it back
but not by default.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
