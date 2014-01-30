From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Jan 2014 18:51:10 +0000
Subject: [RFC] arm: vdso: Convert sigpage to vdso implementation
In-Reply-To: <20140129142235.GA12965@linaro.org>
References: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
 <20140128171015.GM15937@n2100.arm.linux.org.uk>
 <20140129142235.GA12965@linaro.org>
Message-ID: <20140130185110.GB4437@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 02:22:36PM +0000, Steve Capper wrote:
> On Tue, Jan 26, 2014 at 05:10:15PM +0000, Russell King - ARM Linux wrote:
> > I'm not happy with this removing much of the work I pushed into the
> > kernel to work around the security issues which were identified with
> > the fixed-address placement of stuff in the vectors page.  Particularly
> > the random placement of the signal return stubs within the new signal
> > page is gone with the VDSO approach, which means if someone can discover
> > the VDSO page, they can issue any system call they please by knowing
> > the appropriate offset into the page to call.

[...]

> > While the VDSO page will be placed randomly, I'd also like to have the
> > signal handlers placed randomly within that page as well - there's no
> > need for them to be at a fixed offset.  The only thing which needs to
> > know where they are after all is the kernel.
> 
> I was considering a larger segment containing the trampoline at random
> offset, but came to the conclusion that the VA randomisation of the
> vdso page location was in itself sufficient?

Whilst randomising within a page could potentially be beneficial, I question
just how much use it is doing it only for the signal page. For example, for
a system running a given version of libc, if you know where libc is mapped,
then you can easily find syscall sequences in there. Similarly for
gettimeofday() in the vDSO, there is a syscall fallback path too.

Dynamically randomising the layout of shared libraries is likely to confuse
the dynamic linker and completely break debugging with GDB. It's also not
something that I'm aware of being done by any other architectures in the
kernel.

I think there's a trade-off between the measurable performance advantage of
exporting functions such as gtod in the vDSO and the unclear security gains
of randomising the sigreturn code within a page when the page address is
already randomised.

> > I believe x86 eventually ended up going down the path of trapping and
> > emulating calls to the VDSO page because VDSO became too much of a
> > problem (though I think it does provide the option for having it back
> > but not by default.)

Hmm, do you have any pointers to more information about that? I know that
the vsyscall page went the way of the dodo because it was placed at a fixed
address, but I thought that the vDSO was still alive and kicking.

Will
