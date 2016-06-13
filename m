From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 22:23:00 +0200
Subject: [PATCH v2 4/4] dynamic_debug: add jump label support
In-Reply-To: <3448491.s2zXTXrSlh@wuerfel>
References: <cover.1463778029.git.jbaron@akamai.com>
 <575ADDB3.7070304@akamai.com> <3448491.s2zXTXrSlh@wuerfel>
Message-ID: <5640634.eWRyv1HFLD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 13, 2016 6:05:22 PM CEST Arnd Bergmann wrote:
> On Friday, June 10, 2016 11:33:07 AM CEST Jason Baron wrote:
> > On 06/10/2016 05:54 AM, Arnd Bergmann wrote:
> > > On Friday, May 20, 2016 5:16:36 PM CEST Jason Baron wrote:
> > >> Although dynamic debug is often only used for debug builds, sometimes its
> > >> enabled for production builds as well. Minimize its impact by using jump
> > >> labels. This reduces the text section by 7000+ bytes in the kernel image
> > >> below. It does increase data, but this should only be referenced when
> > >> changing the direction of the branches, and hence usually not in cache.
> > >>
> > >>    text         data     bss     dec     hex filename
> > >> 8194852      4879776  925696 14000324         d5a0c4 vmlinux.pre
> > >> 8187337      4960224  925696 14073257         d6bda9 vmlinux.post
> > >>
> > >> Signed-off-by: Jason Baron <jbaron@akamai.com>
> > >> ---
> > > 
> > > This causes problems for some of my randconfig builds, when a dynamic
> > > debug call is used inside of an __exit function:
> > > 
> > > `.exit.text' referenced in section `__jump_table' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> > > `.exit.text' referenced in section `__jump_table' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> > > 
> > 
> > I stuck pr_debug() in a few functions marked with __exit, but did not
> > reproduce yet. Can you share your .config and gcc --version.
> > 
> 
> I found these on ARM randconfig builds e.g. this one
> http://pastebin.com/raw/KjWHxnwU
> 
> I also have some other patches applied that could have interacted with your
> change, so if you can't reproduce it easily, let me try it on a plain linux-next
> kernel.
> 
> The compiler I use is  arm-linux-gnueabi-gcc (GCC) 6.0.0 20160323 (experimental)

Update: on ARM, I have been able to reproduce this with gcc-4.6
and gcc-4.8, so I'm pretty confident that this is independent of the
toolchain. However, I have so far failed to reproduce this on x86.

Looking at the exit_ceph() function, I get these two assembly outputs,
ARM fails with the link error above:

        .section        .exit.text,"ax",%progbits
        .align  2
        .syntax unified
        .arm
        .fpu softvfp
        .type   exit_ceph, %function
exit_ceph:
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 1, uses_anonymous_args = 0
        mov     ip, sp  @,
        push    {fp, ip, lr, pc}        @
        sub     fp, ip, #4      @,,
        sub     sp, sp, #8      @,,
        .syntax divided
@ 13 "/git/arm-soc/arch/arm/include/asm/jump_label.h" 1
        1:
        nop
        .pushsection __jump_table,  "aw"
        .word 1b, .L341, descriptor.39418+20    @,
        .popsection

@ 0 "" 2
        .syntax unified
.L342:
        ldr     r0, .L344       @,
        bl      unregister_filesystem   @
        bl      ceph_xattr_exit @
        bl      destroy_caches  @
        b       .L343   @
.L341:
        mov     r1, #29 @,
        ldr     r0, .L344+4     @,
        bl      ceph_file_part  @
        mov     r3, #1072       @ tmp118,
        mov     r2, #3  @,
        stm     sp, {r0, r3}    @,,
        ldr     r1, .L344+8     @,
        ldr     r3, .L344+12    @,
        ldr     r0, .L344+16    @,
        bl      __dynamic_pr_debug      @
        b       .L342   @
.L343:
        sub     sp, fp, #12     @,,
        ldm     sp, {fp, sp, pc}        @
.L345:
        .align  2
.L344:
        .word   .LANCHOR2+224
        .word   .LC0
        .word   .LC69
        .word   .LC1
        .word   .LANCHOR0+1088
        .size   exit_ceph, .-exit_ceph


and x86 has no link error with:

        .type   exit_ceph, @function
exit_ceph:
        pushq   %rbp    #
        movq    %rsp, %rbp      #,
#APP
# 35 "/git/arm-soc/arch/x86/include/asm/jump_label.h" 1
        1:.byte 0x0f,0x1f,0x44,0x00,0
        .pushsection __jump_table,  "aw"
         .balign 8
         .quad 1b, .L350, descriptor.39765+40 + 0       #,,
        .popsection

# 0 "" 2
#NO_APP
.L351:
        movq    $ceph_fs_type, %rdi     #,
        call    unregister_filesystem   #
        call    ceph_xattr_exit #
        call    destroy_caches  #
        popq    %rbp    #
        ret
.L350:
        movl    $29, %esi       #,
        movq    $.LC0, %rdi     #,
        call    ceph_file_part  #
        movl    $1072, %r9d     #,
        movq    %rax, %r8       #, D.41790
        movq    $.LC1, %rcx     #,
        movl    $3, %edx        #,
        movq    $.LC85, %rsi    #,
        movq    $descriptor.39765, %rdi #,
        call    __dynamic_pr_debug      #
        jmp     .L351   #
        .size   exit_ceph, .-exit_ceph


In both cases, the __jump_table section clearly has a reference to a
discarded section.

	Arnd
