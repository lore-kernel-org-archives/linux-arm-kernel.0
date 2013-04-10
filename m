From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 10 Apr 2013 14:38:21 -0400
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410104002.GF14496@n2100.arm.linux.org.uk>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
Message-ID: <CAKON4Ozhk1kfnzi4+j_2dkGbAG07MKFa3SXOKjy7oWhNh6HNVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 6:40 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> I have just committed a patch to remove the arch/arm/nwfpe code from
> the kernel, and the VFP code emulating the FP operations.
>
> This I have done after it has been brought to my attention by the OSADL's
> GPL-violations project that the license for the softfloat library is
> incompatible with GPLv2.  This is because the FSF have ruled that
> indemnification clauses consitute an "additional restriction" which is
> incompatible with the GPLv2 section 6.  NWFPE contains the softfloat
> library, and VFP's emulation code is a derivative of softfloat.
>
> This will be very disruptive for ARMv4 and ARMv5 CPUs, which will no
> longer be able to run userspace with NWFPE support removed.  A possible
> solution there is to resurrect FASTFPE support and merge that into
> mainline in place of NWFPE.  FASTFPE's hooks are all present in the
> kernel, and it should just be a case of adding the FASTFPE code.
> However, FASTFPE is probably lacking GDB and signal stack support.
> (FastFPE's per-thread workspace is different from NWFPE.)
>
> The situation with VFP is likely less disruptive - only instructions
> which aren't implemented in hardware (or, for example, if you ask for
> inexact exceptions to be enabled) which are bounced to the software
> support code will be affected.  I think OMAP should get away unscathed,
> but ARM's implementation will bounce if inexact exceptions are enabled
> or in a few corner cases.  Qualcomm is likely to be the worst affected
> by this.
>
> Will Deacon has tested debian armhf on a Cortex-A15 with VFP emulation
> support removed, which boots successfully.
>
> There is some discussion that needs to happen to investigate possible
> solutions to this, which are:
>
> 1. Whether we can persuade John to relicense his code.  From what I
>    understand from the discussions which have already happened, John
>    is against that because he requires the indemnification clause.

Does it work to have him donate the copyright for the code to the FSF?
Then he wouldn't own it anymore and wouldn't need indemnification. FSF
would reissue under GPLv2 since it would be the owner of the copyright
with the ability to relicense.

>
>    It has been suggested that someone from the community could indemnify
>    John, but that doesn't make any sense to me - and it would be hard to
>    see how that in itself wouldn't require some kind of additional clause
>    which could in itself be seen as an additional restriction.
>
> 2. Someone creates a clean-room GPLv2 compatible softfloat
>    implementation.
>
> 3. Something else?
>
> As I will be away for the next week, and unable to deal with this in any
> way, I have taken the only option available to me at the present time and
> removed the offending code, which is a change I will be pushing upstream
> today.  This brings us back to a compliant situation, to the best of my
> knowledge.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--
Jon Smirl
jonsmirl at gmail.com
