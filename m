From: greg@kroah.com (Greg KH)
Date: Fri, 1 Sep 2017 18:27:37 +0200
Subject: [PATCH] arm64: fpsimd: Prevent registers leaking across exec
In-Reply-To: <20170901161611.GE6321@e103592.cambridge.arm.com>
References: <1504025374-17068-1-git-send-email-Dave.Martin@arm.com>
 <20170831060201.GA7325@kroah.com>
 <20170901161611.GE6321@e103592.cambridge.arm.com>
Message-ID: <20170901162737.GB4650@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 05:16:15PM +0100, Dave Martin wrote:
> On Thu, Aug 31, 2017 at 08:02:01AM +0200, Greg KH wrote:
> > On Tue, Aug 29, 2017 at 05:49:34PM +0100, Dave Martin wrote:
> > > commit 096622104e14d8a1db4860bd557717067a0515d2 upstream.
> > > 
> > > There are some tricky dependencies between the different stages of
> > > flushing the FPSIMD register state during exec, and these can race
> > > with context switch in ways that can cause the old task's regs to
> > > leak across.  In particular, a context switch during the memset() can
> > > cause some of the task's old FPSIMD registers to reappear.
> > > 
> > > Disabling preemption for this small window would be no big deal for
> > > performance: preemption is already disabled for similar scenarios
> > > like updating the FPSIMD registers in sigreturn.
> > > 
> > > So, instead of rearranging things in ways that might swap existing
> > > subtle bugs for new ones, this patch just disables preemption
> > > around the FPSIMD state flushing so that races of this type can't
> > > occur here.  This brings fpsimd_flush_thread() into line with other
> > > code paths.
> > > 
> > > Cc: <stable@vger.kernel.org> # 3.16.x
> > > Cc: <stable@vger.kernel.org> # 4.1.x-4.9.x
> > > Fixes: 674c242c9323 ("arm64: flush FP/SIMD state correctly after execve()")
> > > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > > 
> > > For stable only.
> > > 
> > > 3.17.x-4.0.x don't appear active, and this patch isn't sufficient to fix
> > > them (they would need 674c242c9323 also).
> > 
> > 3.18 is "semi-active" in that I'm trying to keep it alive for the
> > millions of devices that rely on it out in the world at the moment...
> 
> Fair enough, I'll bear that in mind for future fixes.
> 
> Any ideas how long it's likely to linger for?

No idea, probably until I get really sick of it.  If you, or any company
you know, relies on it, please let me know and I'll be glad to talk
about it with you...

thanks,

greg k-h
