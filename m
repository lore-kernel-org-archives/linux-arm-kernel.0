From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 May 2014 17:12:19 +0100
Subject: [PATCH v4 2/2] arm64: enable context tracking
In-Reply-To: <20140523155544.GA24994@leverpostej>
References: <1400786855-32656-1-git-send-email-larry.bassel@linaro.org>
 <1400786855-32656-3-git-send-email-larry.bassel@linaro.org>
 <537E5E1F.3050605@codeaurora.org> <7hd2f5icat.fsf@paris.lan>
 <20140523145107.GO9252@arm.com>
 <20140523155544.GA24994@leverpostej>
Message-ID: <20140523161219.GK21319@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 04:55:44PM +0100, Mark Rutland wrote:
> On Fri, May 23, 2014 at 03:51:07PM +0100, Catalin Marinas wrote:
> > On Fri, May 23, 2014 at 01:11:38AM +0100, Kevin Hilman wrote:
> > I haven't checked all the code paths but at least for pushing onto the
> > stack we must keep it 16-bytes aligned (architecture requirement).
> 
> Sure -- if modifying the stack we need to push/pop pairs of registers to
> keep it aligned. It might be better to use xzr as the dummy value in
> that case to make it clear that the value doesn't really matter.
> 
> That said, ct_user_enter is only called in kernel_exit before we restore
> the values off the stack, and the only register I can spot that we need
> to preserve is x0 for the syscall return value. I can't see x1 or x2
> being used any more specially than the rest of the remaining registers.
> Am I missing something, or would it be sufficient to do the following?
> 
> push	x0, xzr
> bl	context_tacking_user_enter
> pop	x0, xzr

... and if that works, then why are we using the stack instead of a
callee-saved register?

Will
