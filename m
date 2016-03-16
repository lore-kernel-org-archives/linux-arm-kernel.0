From: panand@redhat.com (Pratyush Anand)
Date: Wed, 16 Mar 2016 11:13:56 +0530
Subject: [PATCH v11 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <56E858D8.8030300@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-4-git-send-email-dave.long@linaro.org>
 <56E858D8.8030300@arm.com>
Message-ID: <20160316054329.GC28915@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/2016:06:47:52 PM, James Morse wrote:
> Hi David,
> 
> On 09/03/16 05:32, David Long wrote:
> > From: "David A. Long" <dave.long@linaro.org>
> > diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> > index 4699cd7..0ac2131 100644
> > --- a/arch/arm64/lib/copy_from_user.S
> > +++ b/arch/arm64/lib/copy_from_user.S
> > @@ -66,6 +66,7 @@
> >  	.endm
> >  
> >  end	.req	x5
> > +	.section .kprobes.text,"ax",%progbits
> >  ENTRY(__copy_from_user)
> >  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
> >  	    CONFIG_ARM64_PAN)
> > diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> > index 7512bbb..e4eb84c 100644
> > --- a/arch/arm64/lib/copy_to_user.S
> > +++ b/arch/arm64/lib/copy_to_user.S
> > @@ -65,6 +65,7 @@
> >  	.endm
> >  
> >  end	.req	x5
> > +	.section .kprobes.text,"ax",%progbits
> >  ENTRY(__copy_to_user)
> >  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
> >  	    CONFIG_ARM64_PAN)
> > 
> 
> If I understand this correctly -  you can't kprobe these ldr/str instructions as
> the fault handler wouldn't find kprobe's out-of line version of the instruction
> in the exception table... but why only these two functions? (for library
> functions, we also have clear_user() and copy_in_user()...)

May be not clear_user() because those are inlined, but may be __clear_user().

There can be many other functions (see [1], [2] and can be many more) which need
to be blacklisted, but I think they can always be added latter on, and atleast
this aspect should not hinder inclusion of these patches.

> 
> The get_user()/put_user() stuff in uaccess.h gets inlined all over the kernel, I
> don't think its feasible to put all of these in a separate section.

Yes, It does not seem possible to blacklist  inlined functions. There can be
some other places like valid kprobable instructions in atomic context, .word
instruction having data as valid instruction, etc... So, probably its not
possible to make 100% safe, but yes wherever possible, we should take care.

Infact, other ARCHs are also not completely safe. One can try to instrument
kprobe on all the symbols in Kallsyms on an x86_64 machine and kernel crashes.

> 
> Is it feasible to search the exception table at runtime instead? If an
> address-to-be-kprobed appears in the list, we know it could generate exceptions,
> so we should report that we can't probe this address. That would catch all of
> the library functions, all the places uaccess.h was inlined, and anything new
> that gets invented in the future.

Sorry, probably I could not get it. How can an inlined addresses range be placed
in exception table or any other code area.

~Pratyush

[1] https://github.com/pratyushanand/linux/commit/855bc4dbb98ceafac4c933e00d203b1cd7ee9ca4
[2] https://github.com/pratyushanand/linux/commit/8bc586d6f767240e9ffa582f45a9ad11de47ecfb
