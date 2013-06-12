From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Jun 2013 17:58:49 +0100
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <51B76E99.3090001@wwwdotorg.org>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
 <51B767A8.7000506@wwwdotorg.org>
 <20130611182927.GP3439@mudshark.cambridge.arm.com>
 <51B76E99.3090001@wwwdotorg.org>
Message-ID: <20130612165849.GJ2563@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Jun 11, 2013 at 07:38:17PM +0100, Stephen Warren wrote:
> On 06/11/2013 12:29 PM, Will Deacon wrote:
> > Yes, you're right. In fact, since we don't support KEXEC_JUMP on ARM, we
> > could dispense with machine_shutdown altogether (just make it do nothing)
> > and move the code into machine_kexec, which has a much better name.
> > 
> > What do you think?
> 
> That seems fine to me. Or, if I'm changing the prototype of
> machine_shutdown(), I could just rename it to e.g.
> machine_kexec_shutdown() while I'm at it?

Probably best to leave it alone as it has a declaration in linux/reboot.h
and is referenced directly by the core kexec code. Moving all this into
machine_kexec is a better move.

> Actually, I was wondering if ARM's implementation wasn't already
> KEXEC_JUMP; after all, it uses soft_restart(), which simply jumps to the
> new kernel rather than doing any kind of HW reset, right? I must admit
> though, the Kconfig for KEXEC_JUMP doesn't really help me understand
> what the difference is supposed to be.

I think KEXEC_JUMP keeps both of the kernels `alive' at the same time, so
you can `jump' between them -- that's certainly not what we do on ARM.

Will
