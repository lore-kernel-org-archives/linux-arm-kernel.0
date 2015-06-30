From: michael@ellerman.id.au (Michael Ellerman)
Date: Tue, 30 Jun 2015 13:29:05 +1000
Subject: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
In-Reply-To: <5581BCD0.2040405@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
 <CAL_JsqK3L9Hv9bhAtwAAXVYjLJBTOG9=4ddOo-SFqnD-_KieCQ@mail.gmail.com>
 <5581BCD0.2040405@linaro.org>
Message-ID: <1435634945.24866.2.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-17 at 14:30 -0400, David Long wrote:
> On 06/16/15 09:17, Rob Herring wrote:
> > On Mon, Jun 15, 2015 at 11:42 AM, David Long <dave.long@linaro.org> wrote:
> >>
> >>   #define REG_OFFSET_NAME(r) \
> >>          {.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
> >>   #define REG_OFFSET_END {.name = NULL, .offset = 0}
> >
> > Can't you also move these? ARM is complicated with the "ARM_"
> > prefixing, but the others appear to be the same. Maybe you can remove
> > the prefix or redefine the macro for ARM.
> 
> That would mandate that all the architecture-specific pt_regs structures 
> would have to use a top-level named field for each named register.

Why does it mandate that?

See eg. powerpc where we use REG_OFFSET_NAME for the top-level named fields and
then a different macro for the array elements:

  #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
  #define GPR_OFFSET_NAME(num)	\
  	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
  
  static const struct pt_regs_offset regoffset_table[] = {
  	GPR_OFFSET_NAME(0),
  	GPR_OFFSET_NAME(1),
  	GPR_OFFSET_NAME(2),
  	GPR_OFFSET_NAME(3),
  	...
  	REG_OFFSET_NAME(nip),
  	REG_OFFSET_NAME(msr),


So I don't see why REG_OFFSET_NAME couldn't be common.

cheers
