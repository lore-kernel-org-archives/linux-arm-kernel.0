From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jul 2016 13:47:28 +0100
Subject: [RFC 3/3] kexec: extend kexec_file_load system call
In-Reply-To: <20160719122406.GA18124@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
 <20160715131950.GB19840@leverpostej>
 <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
 <20160718100704.GB10069@leverpostej>
 <20160719005556.GE3326@dhcp-128-65.nay.redhat.com>
 <20160719105049.GD27022@leverpostej>
 <20160719122406.GA18124@redhat.com>
Message-ID: <20160719124651.GA21007@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 08:24:06AM -0400, Vivek Goyal wrote:
> On Tue, Jul 19, 2016 at 11:52:00AM +0100, Mark Rutland wrote:
> > Regardless, this extended syscall changes some underlying assumptions
> > made with the development of kexec_file_load, and I think treating this
> > as an extension is not a great idea. From a user's perspective there is
> > little difference between passing an additional flag or using a
> > different syscall number, so I don't think that we gain much by altering
> > the existing prototype relative to allocating a new syscall number.
> 
> If we are providing/opening up additional flags, I can't think what will
> it break. Same flag was invalid in old kernel but new kernel supports 
> it and will accept it. So it sounds reasonable to me to add new flags.
> 
> If existing users are not broken, then I think it might be a good idea
> to extend existing syscall. Otherwise userspace will have to be modified
> to understand a 3rd syscall also and an additional option will show up
> which asks users to specify which syscall to use. So extending existing
> syscall might keep it little simple for users.

I don't follow.

To use the new feature, you have to modify userspace anyway, as you
require userspace to pass information which it did not previously pass
(in the new arguments added to the syscall).

The presence of a new syscall does not imply the absence of the old
syscall, so you can always use that be default unless the user asks for
asomething only the new syscall provides. Regardless of the
syscall/flags difference, you still have to detect whether the new
functionality is present somehow.

> BTW, does kexec_load() needs to be modified too to handle DT?

No, at least for arm64. In the kexec_load case userspace provides the
DTB as a raw segment, and the user-provided purgatory sets up registers
to pass that to the new kernel.

Thanks,
Mark.
