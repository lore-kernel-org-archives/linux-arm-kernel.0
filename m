From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 10 Apr 2013 20:23:30 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410185421.GI14496@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 10 Apr 2013 19:54:21 +0100")
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
 <20130410114229.GH14496@n2100.arm.linux.org.uk>
 <yw1xip3u8uni.fsf@unicorn.mansr.com>
 <20130410185421.GI14496@n2100.arm.linux.org.uk>
Message-ID: <yw1xehei8a19.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Apr 10, 2013 at 12:58:09PM +0100, M?ns Rullg?rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Wed, Apr 10, 2013 at 12:18:19PM +0100, M?ns Rullg?rd wrote:
>> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> >> 
>> >> > The situation with VFP is likely less disruptive - only instructions
>> >> > which aren't implemented in hardware (or, for example, if you ask for
>> >> > inexact exceptions to be enabled) which are bounced to the software
>> >> > support code will be affected.  I think OMAP should get away unscathed,
>> >> > but ARM's implementation will bounce if inexact exceptions are enabled
>> >> 
>> >> What do you mean by this?  OMAP uses ARM's cores.
>> >
>> > OMAP's VFP reports that it never traps to support code for VFP instructions,
>> > so the emulation code is never used on OMAP.
>> 
>> That is true for OMAP2 (ARM1136/VFP11) and OMAP3 (Cortex-A8).  OMAP4
>> (Cortex-A9) and OMAP5 (Cortex-A15) both trap on vector operations.
>
> No.  Both OMAP3 and OMAP4 report that they are VFP subarchitecture 3,
> and the VFP subarchitecture 3 never traps to support code for any
> instruction (it's the "null subarchitecture" value.)

VFPv3 does not require hardware support for vector operations, and the
Cortex-A9 NEON TRM [1] says this:

   ARMv7 deprecates the use of VFP vector mode. The Cortex-A9 NEON MPE
   hardware does not support VFP vector operations. [...] The Cortex-A9
   NEON MPE provides high speed VFP operation without support code.
   However, if an application requires VFP vector operation, then it
   must use support code.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0409i/CHDEEJDB.html

The VFP-only TRM [2] contains similar language:

  The use of VFP vector mode is deprecated in ARMv7.  Vector operations
  are not supported in hardware.  If you use vectors, support code is
  required.

[2] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0408i/I1019986.html

The Cortex-A15 TRM [3] follows suit:

  Vector operations are not supported.  Any attempt to execute a vector
  operation results in an Undefined Instruction exception.  If an
  application requires VFP vector operation, then it must use VFP
  support code.

[3] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0438h/CEGCDBHC.html

In future, if you checked the relevant documentation before making bold
claims, you might avoid making a fool of yourself.

-- 
M?ns Rullg?rd
mans at mansr.com
