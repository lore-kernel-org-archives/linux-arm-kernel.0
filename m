From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Mar 2016 17:51:28 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <56DDBD07.2080200@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <56DDAFA7.4090207@arm.com>
 <20160307172334.GJ19428@n2100.arm.linux.org.uk>
 <56DDBD07.2080200@arm.com>
Message-ID: <20160307175128.GK19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 05:40:23PM +0000, James Morse wrote:
> On 07/03/16 17:23, Russell King - ARM Linux wrote:
> > On Mon, Mar 07, 2016 at 04:43:19PM +0000, James Morse wrote:
> >> As far as I can see, this would only affect arm64. I can't find an equivalent
> >> memset() for x86_64.
> > 
> > I don't think you've looked hard enough. :)
> 
> Heh, Thanks! I ignored the 32bit code and instead got lost in the maze of
> underscores and alternative-strings for the 64 bit path.
> 
> Having seen that path, I've now found:
> >	/* If the destination is a kernel buffer, we always clear the end */
> >	if (!__addr_ok(to))
> >		memset(to, 0, len);
> 
> in arch/x86/lib/usercopy_64.c:copy_user_handle_tail(), which may be the x86_64
> equivalent, or I may be lost in the maze again.

x86_64 has the function in assembler:

/* Standard copy_from_user with segment limit checking */
ENTRY(_copy_from_user)
        GET_THREAD_INFO(%rax)
        movq %rsi,%rcx
        addq %rdx,%rcx
        jc bad_from_user
        cmpq TI_addr_limit(%rax),%rcx
        ja bad_from_user
        ALTERNATIVE_2 "jmp copy_user_generic_unrolled",         \
                      "jmp copy_user_generic_string",           \
                      X86_FEATURE_REP_GOOD,                     \
                      "jmp copy_user_enhanced_fast_string",     \
                      X86_FEATURE_ERMS
ENDPROC(_copy_from_user)

        .section .fixup,"ax"
        /* must zero dest */
ENTRY(bad_from_user)
bad_from_user:
        movl %edx,%ecx
        xorl %eax,%eax
        rep
        stosb
bad_to_user:
        movl %edx,%eax
        ret
ENDPROC(bad_from_user)

The memset() are the 4 instructions after bad_from_user:.  This will
be triggered if 'from' is an invalid address.

However, you're right that we end up in copy_user_handle_tail() if
we fault, which will try to copy as much data and then memset() the
remainder.  Since this is used for both copy_from_user() and
copy_to_user() I think the __addr_ok() is just a side-effect of
avoiding memsetting for the copy_to_user() case.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
