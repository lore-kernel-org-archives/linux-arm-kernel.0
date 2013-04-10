From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 10 Apr 2013 21:46:50 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410200344.GO14496@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 10 Apr 2013 21:03:44 +0100")
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
 <20130410114229.GH14496@n2100.arm.linux.org.uk>
 <yw1xip3u8uni.fsf@unicorn.mansr.com>
 <20130410185421.GI14496@n2100.arm.linux.org.uk>
 <yw1xehei8a19.fsf@unicorn.mansr.com>
 <20130410200344.GO14496@n2100.arm.linux.org.uk>
Message-ID: <yw1x61zu866d.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Apr 10, 2013 at 08:23:30PM +0100, M?ns Rullg?rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Wed, Apr 10, 2013 at 12:58:09PM +0100, M?ns Rullg?rd wrote:
>> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> >> 
>> >> > On Wed, Apr 10, 2013 at 12:18:19PM +0100, M?ns Rullg?rd wrote:
>> >> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> >> >> 
>> >> >> > The situation with VFP is likely less disruptive - only instructions
>> >> >> > which aren't implemented in hardware (or, for example, if you ask for
>> >> >> > inexact exceptions to be enabled) which are bounced to the software
>> >> >> > support code will be affected.  I think OMAP should get away unscathed,
>> >> >> > but ARM's implementation will bounce if inexact exceptions are enabled
>> >> >> 
>> >> >> What do you mean by this?  OMAP uses ARM's cores.
>> >> >
>> >> > OMAP's VFP reports that it never traps to support code for VFP instructions,
>> >> > so the emulation code is never used on OMAP.
>> >> 
>> >> That is true for OMAP2 (ARM1136/VFP11) and OMAP3 (Cortex-A8).  OMAP4
>> >> (Cortex-A9) and OMAP5 (Cortex-A15) both trap on vector operations.
>> >
>> > No.  Both OMAP3 and OMAP4 report that they are VFP subarchitecture 3,
>> > and the VFP subarchitecture 3 never traps to support code for any
>> > instruction (it's the "null subarchitecture" value.)
>> 
>> VFPv3 does not require hardware support for vector operations, and the
>> Cortex-A9 NEON TRM [1] says this:
>>
>>    ARMv7 deprecates the use of VFP vector mode. The Cortex-A9 NEON MPE
>>    hardware does not support VFP vector operations. [...] The Cortex-A9
>>    NEON MPE provides high speed VFP operation without support code.
>>    However, if an application requires VFP vector operation, then it
>>    must use support code.
>> 
>> [1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0409i/CHDEEJDB.html
>> 
>> The VFP-only TRM [2] contains similar language:
>> 
>>   The use of VFP vector mode is deprecated in ARMv7.  Vector operations
>>   are not supported in hardware.  If you use vectors, support code is
>>   required.
>> 
>> [2] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0408i/I1019986.html
>> 
>> The Cortex-A15 TRM [3] follows suit:
>> 
>>   Vector operations are not supported.  Any attempt to execute a vector
>>   operation results in an Undefined Instruction exception.  If an
>>   application requires VFP vector operation, then it must use VFP
>>   support code.
>> 
>> [3] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0438h/CEGCDBHC.html
>> 
>> In future, if you checked the relevant documentation before making bold
>> claims, you might avoid making a fool of yourself.
>
> Oh fuck off, just really fuck off you total dickface.  Really, do you
> think that I, being the one who created the VFP support code, haven't
> read the VFP documentation?  Christ, you are fucking thick.

I'll ignore the insults for now, but you really should consider watching
your tone if you want to be taken seriously.

> Subarchitecture, bits [22:16]
> 0b0000011
> VFP architecture v3 or later with Null subarchitecture. The entire floating-point
> implementation is in hardware, and no software support code is required. The
> VFP architecture version is indicated by the MVFR0 and MVFR1 registers.
> This value can be used only by an implementation that does not support the trap
> enable bits in the FPSCR, see Floating-point Status and Control Register
> (FPSCR) on page A2-28.

This means merely that the implementation never traps on things like
denormal inputs or over/underflow.  It has nothing to do with vector
support.

Both the ARM ARM and the various TRMs make it abundantly clear that
vector operations are optional *and* that some of the cores do *not*
implement them in hardware.

I have also run code with vector operations on A9, and I assure you it
does trap.

> And both OMAP3 and OMAP4 report *this* subarchitecture version.  Maybe
> it's you who needs to take a reading lesson instead of making a prat of
> *yourself*.

Same subarchitecture, different variants.  

-- 
M?ns Rullg?rd
mans at mansr.com
