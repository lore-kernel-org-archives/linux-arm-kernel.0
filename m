From: panand@redhat.com (Pratyush Anand)
Date: Mon, 30 Mar 2015 20:08:27 +0530
Subject: arm64 kexec hang
In-Reply-To: <551940F5.9050102@redhat.com>
References: <1427477015.27739.30.camel@infradead.org>
 <5515C799.8010600@redhat.com> <551940F5.9050102@redhat.com>
Message-ID: <55195FE3.5090409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 30 March 2015 05:56 PM, Pratyush Anand wrote:
> Hi Geoff,
>
> On Saturday 28 March 2015 02:41 AM, Pratyush Anand wrote:
>> Hi Geoff,
>>
>> On Friday 27 March 2015 10:53 PM, Geoff Levand wrote:
>>> Hi Pratyush,
>>>
>>> On Wed, 2015-03-25 at 15:55 +0530, Pratyush Anand wrote:
>>>> So with following changes kexec load seems to complete without any
>>>> error. However, kexec reboot does not work yet, Nothing after bye
>>>> message :( (1st kernel booted with maxcpus=1)
>>>
>>> 'Bye!' doesn't mean much, other than the first kernel has
>>> almost shutdown.  I recommend for debugging you either define
>>> ARM64_DEBUG_PORT for the kexec-tools build, or have a suitable
>>> earlyprintk= on the kernel command line.  See the read_sink()
>>> routine in kexec-arm64.c.
>>>
>>
>
> Problem seems to be related to compilation of purgatory code.
>
> For example see here:
>
>    70 0000000000000120 <purgatory>:
>    71      120:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
>    72      124:       910003fd        mov     x29, sp
>    73      128:       58000100        ldr     x0, 148 <purgatory+0x28>
>    74      12c:       94000000        bl      544 <printf>
>
>
> So, when it executes instruction at address 0x128 in above code, it does
> not contain correct address of data where "I'm in purgatory" is located.
> It seems that code has been compiled as 32 bit.
>
> PC: 0x400415012c , PSTATE: 0x400003c9
> (gdb) monitor reg x0
> x0 (/64): 0x00000000041568F8
> (gdb) monitor mdw 0x00000000041568F8 4
> 0x41568f8: fffefffe fffefffe fffefffe fffefffe  : ................
>
> The buffer location passed to printf is not correct.
>
> Similarly, even if ARM64_DEBUG_PORT is programmed with correct UART TX
> register, arm64_sink is not modified correctly when elf_rel_set_symbol
> is called.
>
> So correct data is at 0x00000040041568F8 and not 0x00000000041568F8
>
> (gdb) monitor mdw 0x00000040041568F8 4
> 0x40041568f8: 206d2749 70206e69 61677275 79726f74  : I'm in purgatory
>
>
> should n't the pc relative instruction like adrp be generated instead of
> ldr.
>
> What does -mcmodel=large cflag do? May be it is causing to generate such
> instruction.
>

Following changes allows purgatory to execute.


diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 8df66f5c8273..4365bb4087ad 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -993,8 +993,8 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, 
unsigned long r_type,
  # define R_AARCH64_CALL26 283
  #endif

-       uint32_t *location = (uint32_t *)ptr;
-       uint32_t data = *location;
+       uint64_t *location = (uint64_t *)ptr;
+       uint64_t data = *location;
         const char *type = NULL;

         switch(r_type) {
@@ -1026,7 +1026,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, 
unsigned long r_type,
                 break;
         }

-       dbgprintf("%s: %s %x->%x\n", __func__, type, data, *location);
+       dbgprintf("%s: %s %lx->%lx\n", __func__, type, data, *location);
  }


So I get following and then nothing..

[  162.087569] Bye!
I'm in purgatory
purgatory: kernel_entry: 0000004000280000
purg

Hopefully, I will be able to debug it further.will come back.

~Pratyush
