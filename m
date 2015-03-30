From: Dave.Martin@arm.com (Dave P Martin)
Date: Mon, 30 Mar 2015 13:06:12 +0100
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <CAKv+Gu8Wr7MY6ogMjNFBDU=GMgYrFga7CD5-kf2msSH5vk+ubQ@mail.gmail.com>
References: <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
 <20150325104603.GA3560@e103592.cambridge.arm.com>
 <20150326113648.GC8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8ktOUcQrGOwMfbt8s2QG+RFdnKBykVfhXPTLSUFtWQyA@mail.gmail.com>
 <20150326122203.GG8656@n2100.arm.linux.org.uk>
 <CAKv+Gu-ctXuiM2mcgbqfkBkP_96tivjac0jv+XJ48XSpqRf=Yg@mail.gmail.com>
 <20150326125334.GA27016@e103592.cambridge.arm.com>
 <CAKv+Gu9CDnFSiRrntzTDZDFhb3Cq1M-Dt_xKxvNUszZJpSrzpg@mail.gmail.com>
 <20150326131913.GA6140@e103592.cambridge.arm.com>
 <CAKv+Gu8Wr7MY6ogMjNFBDU=GMgYrFga7CD5-kf2msSH5vk+ubQ@mail.gmail.com>
Message-ID: <20150330120612.GB22336@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 12:01:03AM +0000, Ard Biesheuvel wrote:
> On 26 March 2015 at 14:19, Dave P Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Mar 26, 2015 at 01:05:09PM +0000, Ard Biesheuvel wrote:
> >> On 26 March 2015 at 13:53, Dave P Martin <Dave.Martin@arm.com> wrote:

[...]

> > THUMB2_KERNEL generates a kernel which is very nearly 100% Thumb
> > code, so BX should be very rare when veneers are not involved.
> >
> >> > Ard, can you should build a couple of !THUMB2_KERNEL/pre-v5
> >> > configurations with your change and check, just to be sure?
> >> >

[...]

> ARM kernel with --pic-veneer:
> =============================
> $ readelf -A vmlinux
> Attribute Section: aeabi
> File Attributes
>   Tag_CPU_name: "4T"
>   Tag_CPU_arch: v4T
>   Tag_ARM_ISA_use: Yes
>   Tag_THUMB_ISA_use: Thumb-1
>   [...]
> 
> $ size vmlinux
>    text   data    bss    dec    hex filename
> 38287123 13496224 9589540 61372887 3a879d7 vmlinux
> 
> $ grep -c veneer System.map
> 493
> 
> Veneers look like this:
> 
> c247d53c <__sys_write_veneer>:
> c247d53c:       e59fc000        ldr     ip, [pc]
> c247d540:       e08ff00c        add     pc, pc, ip
> c247d544:       fdd3aa8c        .word   0xfdd3aa8c
> 
> c247d548 <__init_rt_rq_veneer>:
> c247d548:       e59fc000        ldr     ip, [pc]
> c247d54c:       e08ff00c        add     pc, pc, ip
> c247d550:       fdbf9600        .word   0xfdbf9600
> 
> c247d554 <__read_boot_clock_veneer>:
> c247d554:       e59fc000        ldr     ip, [pc]
> c247d558:       e08ff00c        add     pc, pc, ip
> c247d55c:       fdb91310        .word   0xfdb91310
> 
> Thumb2 kernel with --pic-veneer
> ===============================
> Attribute Section: aeabi
> File Attributes
>   Tag_CPU_name: "7-A"
>   Tag_CPU_arch: v7
>   Tag_CPU_arch_profile: Application
>   Tag_ARM_ISA_use: Yes
>   Tag_THUMB_ISA_use: Thumb-2
>   [...]
> 
> $ size vmlinux
>    text   data    bss    dec    hex filename
> 29353740 13644128 9614052 52611920 322cb50 vmlinux
> 
> $ grep -c veneer System.map
> 1928
> 
> Veneers look like this:
> 
> c014f9d8 <____down_interruptible_veneer>:
> c014f9d8:       e59fc004        ldr     ip, [pc, #4]
> c014f9dc:       e08fc00c        add     ip, pc, ip
> c014f9e0:       e12fff1c        bx      ip
> c014f9e4:       0128de45        .word   0x0128de45
> 
> c014f9e8 <___raw_write_unlock_veneer>:
> c014f9e8:       4778            bx      pc
> c014f9ea:       46c0            nop
> c014f9ec:       e59fc004        ldr     ip, [pc, #4]
> c014f9f0:       e08fc00c        add     ip, pc, ip
> c014f9f4:       e12fff1c        bx      ip
> c014f9f8:       012901e1        .word   0x012901e1
> 
> c014f9fc <____mutex_unlock_slowpath_veneer>:
> c014f9fc:       e59fc004        ldr     ip, [pc, #4]
> c014fa00:       e08fc00c        add     ip, pc, ip
> c014fa04:       e12fff1c        bx      ip
> c014fa08:       0128d8e1        .word   0x0128d8e1
> 
> $ arm-linux-gnueabihf-objdump -d vmlinux |grep -E bx\\s+pc -c
> 319
> 
> This number does not change when adding --use-blx, so there is probably not
> much point in adding it.

Fair enough -- thanks for checking.

Cheers
---Dave
