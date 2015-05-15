From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 15 May 2015 12:01:47 -0500
Subject: Bulid regression with VDSO enabled
In-Reply-To: <20150509092626.GM2067@n2100.arm.linux.org.uk>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <554CD5F8.10901@mentor.com> <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
 <554D276D.9040205@mentor.com> <20150509092626.GM2067@n2100.arm.linux.org.uk>
Message-ID: <5556267B.5070700@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the delay in following up on this.

On 05/09/2015 04:26 AM, Russell King - ARM Linux wrote:
> On Fri, May 08, 2015 at 04:15:25PM -0500, Nathan Lynch wrote:
>> I suppose it's possible to make arch/arm/vdso/Makefile honor LD, but it
>> would basically entail a rewrite.  In the meantime, using -fuse-ld=bfd
>> may suffice:
>>
>> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
>> index 8aa791051029..da0ce897edde 100644
>> --- a/arch/arm/vdso/Makefile
>> +++ b/arch/arm/vdso/Makefile
>> @@ -43,6 +43,7 @@ quiet_cmd_vdsold = VDSO    $@
>>        cmd_vdsold = $(CC) $(c_flags) -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) \
>>                     $(call cc-ldoption, -Wl$(comma)--build-id) \
>>                     -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
>> +                   $(call cc-option, -fuse-ld=bfd) \
>>                     -Wl,-z,common-page-size=4096 -o $@
> 
> Would it make more sense to have something like:
> 
> VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
> 		-Wl,-z,common-page-size=4096 \
> 		$(call cc-ldoption, -Wl$(comma)--build-id) \
> 		$(call cc-option, -fuse-ld=bfd)
> 
> and then have:
> 
> 	 cmd_vdsold = $(CC) $(c_flags) $(VDSO_LDFLAGS) \
> 		      -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@

Yes, I can see value in grouping linker directives into one variable;
there are a few in ccflags-y that could be moved to VDSO_LDFLAGS as well.


> Also, do we want to use cc-option or cc-ldoption (this question becomes
> obvious when you arrange the Makefile as I have above...)?  cc-option
> doesn't result in the linker actually being run, where as cc-ldoption
> does.

It's a corner case, but cc-option and cc-ldoption result in different
failure modes when gold is the default linker and the bfd linker is not
in $PATH:

With $(call cc-option, -fuse-ld=bfd):
  VDSO    arch/arm/vdso/vdso.so.raw
collect2: fatal error: cannot find 'ld'

With $(call cc-ldoption, -fuse-ld=bfd):
  VDSO    arch/arm/vdso/vdso.so.raw
  HOSTCC  arch/arm/vdso/vdsomunge
  MUNGE   arch/arm/vdso/vdso.so.dbg
  OBJCOPY arch/arm/vdso/vdso.so
BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
linking with -N

That is, since using cc-ldoption invokes the linker, and the bfd linker
isn't found, -fuse-ld=bfd is omitted from the command and gold gets run,
resulting in the same symptom as the report that started this thread.

I think the first one gives more of a clue as to what the user can do to
remedy the situation, so that's what I'd slightly prefer.
