From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 23 May 2013 16:57:49 -0400 (EDT)
Subject: [PATCH 2/2] ARM: move VFP init to an earlier boot stage
In-Reply-To: <CAKv+Gu9FDprQtVitu5dojoWqY15s4ytOCxbFUjUnLsX8L92Zag@mail.gmail.com>
References: <1369294104-3849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1369294104-3849-2-git-send-email-ard.biesheuvel@linaro.org>
 <20130523084126.GI18614@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1305231108500.1918@syhkavp.arg>
 <CAKv+Gu9FDprQtVitu5dojoWqY15s4ytOCxbFUjUnLsX8L92Zag@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1305231654440.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Ard Biesheuvel wrote:

> On 23 May 2013 17:23, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Thu, 23 May 2013, Russell King - ARM Linux wrote:
> >
> >> Secondly, it makes it too easy for people to start thinking that FP is
> >> safe in the kernel.  It isn't - this will go horribly wrong if the VFP
> >> hardware bounces an instruction to the support code.
> >
> > Hmmm. good point.  We probably should set a flag in kernel_vfp_begin()
> > and BUG() if the support code is invoked while that flag is set.
> >
> 
> Currently, the lazy restore is armed even in kernel mode, so it pulls
> in the userland context if you issue NEON/VFP instructions in kernel
> mode with the FP unit off. This is probably a side effect of the VFP
> detection code relying on this code path as well.
> As kernel_vfp_begin() disarms the lazy restore and takes care of
> preserving the userland context itself, entering __und_svc because of
> NEON/VFP instructions should only be allowed in this particular case,
> i.e., VFP detection and all other instances should BUG() imho
> (regardless of if we end up doing NEON in the kernel or not). Doing it
> that way, I don't think there is a reason for keeping additional
> flags.

The concern is more about VFP instructions that could trigger an 
exception where support code is invoked to emulate that instruction.


Nicolas
