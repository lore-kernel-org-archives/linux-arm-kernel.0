From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Feb 2014 10:37:31 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <530501A7.2030703@ti.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <530501A7.2030703@ti.com>
Message-ID: <20140220103731.GB15994@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 07:10:31PM +0000, Russ Dill wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 02/19/2014 08:12 AM, Lorenzo Pieralisi wrote:
> 
> + *  https://patchwork.kernel.org/patch/96442/
> 

I am guessing the snippets of code your comments refer to.

> I think the idea here is to get the CPU into a state so that later
> when we resume from the resume kernel, the actual CPU state matches
> the state we have in kernel. The main thing flush_thread does is clear
> out any and all FP state.

Which has already been saved through syscore_suspend()....

> The may be part of the patchset that is OBE.

It has to be updated then.

> cpu_resume makes many assumptions about the state of the state of the
> CPU, the primary being that the MMU is disabled, but also that all
> caches and IRQs are disabled. soft_restart does all this for us.
> 
> 
> 
> ah, you are saying just return from __swsusp_arch_save_image and allow
> cpu_suspend_abort to be called, placing the result of swsusp_save
> somewhere else. This may work and would reduce the complexity of the
> code slightly.

Yes. Basically you are doing a soft reboot just to return 0.

> This is taken from the previous iteration of the patchset, I think the
> comment is OBE.

Updated it please then.

> But this is still required to select the right mapping for our copying.

/me confused. Please describe what switching to idmap is meant to
achieve. In the patch above the copied swapper pgdir is not even used, I
would like to understand why this is done.

> I don't remember why I needed to prevent gcc from manipulating the
> stack here.

That's not a good reason to mark a function with attr __naked. If it is
needed we leave it there, if it is not it has to go.

> This is another holdover from previous patch versions that may be OBE.

See above.

Lorenzo
