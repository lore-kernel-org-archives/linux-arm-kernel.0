From: amckay@iders.ca (Andrew)
Date: Thu, 18 Feb 2010 15:03:08 -0600
Subject: Compiler for Atmel AT91SAMG20
In-Reply-To: <4B746B3D.5070708@iders.ca>
References: <4B6C4C36.9030800@iders.ca>	<20100205180014.GA19538@caradoc.them.org>
	<4B746B3D.5070708@iders.ca>
Message-ID: <4B7DAB0C.9060705@iders.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm still stuck on this iptables issue with Linux 2.6.30.9. I had 
mentioned before that the size of the struct ipt_get_entries differed 
from kernelspace to userspace.

net/ipv4/netfilter/ip_tables.c:1180 sizeof(struct ipt_get_entries): 36
libiptc/libiptc.c:1322 sizeof(struct ipt_get_entries): 40

First of all is there a more appropriate list to send these questions to?

I have done some more looking.  I added -Wpadded to the CFLAGs on both 
the Kernel build and IPTables build to see if struct ipt_get_entries is 
being padded or not.

    From the Kernel:
    include/linux/netfilter_ipv4/ip_tables.h:216: warning: padding 
struct to align 'entrytable'

    From IPTables:
    ./include/linux/netfilter_ipv4/ip_tables.h:210: warning: padding 
struct to align 'entrytable'

The definition of ipt_get_entries is the same for the header file in the 
Kernel and in IPTables:

    From the Kernel:
    /* The argument to IPT_SO_GET_ENTRIES. */
    struct ipt_get_entries
    {
            /* Which table: user fills this in. */
            char name[IPT_TABLE_MAXNAMELEN];
   
            /* User fills this in: total entry size. */
            unsigned int size;
   
            /* The entries. */
            struct ipt_entry entrytable[0]; // Line 216
    };
   
    From IPTables:
    /* The argument to IPT_SO_GET_ENTRIES. */
    struct ipt_get_entries
    {
            /* Which table: user fills this in. */
            char name[IPT_TABLE_MAXNAMELEN];
   
            /* User fills this in: total entry size. */
            unsigned int size;
   
            /* The entries. */
            struct ipt_entry entrytable[0]; // Line 210
    };

Why is Kernel and IPTables being padded differently?  I'm using the same 
compiler for both.  Is there an option being passed to the compiler that 
is changing the struct alignment on me?  I don't see anything that jumps 
out as changing the alignment for structs (ie. -fpack-struct)

   ip_tables.c compiled in Kernel:
    arm-none-linux-gnueabi-gcc 
-Wp,-MD,net/ipv4/netfilter/.ip_tables.o.d  -nostdinc -isystem 
/home/andrew/WIP/AT91/arm-2009q3/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/include 
-Iinclude  -I/home/andrew/WIP/AT91/kernel/linux/arch/arm/include 
-include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian 
-Iarch/arm/mach-at91/include -Wpacked -Wpadded -Wall -Wundef 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
-Werror-implicit-function-declaration -fno-delete-null-pointer-checks 
-Os -marm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables 
-D__LINUX_ARM_ARCH__=5 -march=armv5te -mtune=arm9tdmi -msoft-float -Uarm 
-Wframe-larger-than=1024 -fno-stack-protector -fomit-frame-pointer 
-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow 
-fno-dwarf2-cfi-asm   -D"KBUILD_STR(s)=#s" 
-D"KBUILD_BASENAME=KBUILD_STR(ip_tables)"  
-D"KBUILD_MODNAME=KBUILD_STR(ip_tables)"  -c -o 
net/ipv4/netfilter/ip_tables.o net/ipv4/netfilter/ip_tables.c

    libip4tc.c compile in IPTables 1.4.5:
    libtool: compile:  
/home/andrew/WIP/AT91/arm-2009q3//bin/arm-none-linux-gnueabi-gcc 
-DHAVE_CONFIG_H -I. -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES 
-D_FILE_OFFSET_BITS=64 -D_REENTRANT -Wall -Waggregate-return 
-Wmissing-declarations -Wmissing-prototypes -Wredundant-decls -Wshadow 
-Wstrict-prototypes -Winline -pipe 
-DXTABLES_LIBDIR=\"/home/andrew/WIP/JBX300/_filesystem_/libexec/xtables\" 
-DXTABLES_INTERNAL -I./include -I./include -I 
/home/andrew/WIP/JBX300/Linux/Kernel/linux/include -I 
/home/andrew/WIP/JBX300/Linux/Kernel/linux/include -save-temps -Wpadded 
-MT libiptc/libip4tc.lo -MD -MP -MF libiptc/.deps/libip4tc.Tpo -c 
libiptc/libip4tc.c  -fPIC -DPIC -o libiptc/.libs/libip4tc.o

Thanks for looking into it
Andrew McKay
Iders Inc.


Andrew wrote:
> Thanks for the reply.  I have switched to the arm-none-linux-gnueabi 
> tools to compile my kernel and userspace applications.  It fixes one 
> getsockopt call.  But now I have another similar issue with another 
> getsockopt call.  In iptables libiptc.c
>
>        /* Initialize current state */
>        h->sockfd = sockfd;
>        h->info = info;
>
>        h->entries->size = h->info.size;
>
>        tmp = sizeof(STRUCT_GET_ENTRIES) + h->info.size;
>
>        if (getsockopt(h->sockfd, TC_IPPROTO, SO_GET_ENTRIES, h->entries,
>                       &tmp) < 0){
>                printf("getsockopt failed\n");
>                goto error;
>        }
>
> I added some trace code to the kernel:
>
> static int
> get_entries(struct net *net, struct ipt_get_entries __user *uptr, int 
> *len)
> {
>        int ret;
>        struct ipt_get_entries get;
>        struct xt_table *t;
>
>        if (*len < sizeof(get)) {
>                duprintf("get_entries: %u < %zu\n", *len, sizeof(get));
>                printk("%s:%d get_entries: %u < %zu\n", __FILE__, 
> __LINE__, *len, sizeof(get));
>                return -EINVAL;
>        }
>        if (copy_from_user(&get, uptr, sizeof(get)) != 0)
>                return -EFAULT;
>        if (*len != sizeof(struct ipt_get_entries) + get.size) {
>                duprintf("get_entries: %u != %zu\n",
>                         *len, sizeof(get) + get.size);
>                printk("%s:%d get_entries: %u != %zu\n",
>                         __FILE__, __LINE__, *len, sizeof(get) + 
> get.size);
>                return -EINVAL;
>        }
> .
> .
> .
>
> The error printed out is:
> net/ipv4/netfilter/ip_tables.c:1178 get_entries: 660 != 656
>
> I've done some digging on google and found that there is mention of 
> this error with a 32-bit version of iptables running on a 64-bit 
> kernel.  However since this is running on an ARM board both the kernel 
> and userspace applications are 32-bit.  There is a kernel option 
> called CONFIG_COMPAT which is used to add 32-bit support in a 64-bit 
> kernel.  However this option is only available if the architecture of 
> the kernel is IA64.
>
> I haven't found a mention of a final solution to this problem in my 
> searches yet.
>
> I did a bit more digging and found that the struct ipt_get_entries is 
> different sizes in kernel space and in user space.  In kernel space it 
> is being reported as 36 bytes, in userspace the struct is being 
> reported as 40 bytes.
>
> net/ipv4/netfilter/ip_tables.c:1180 sizeof(struct ipt_get_entries): 36
> sizeof(STRUCT_GET_ENTRIES): 40
>
> It looking at the struct it should be 36 bytes large if it is 
> unpadded.  So it appears that iptables is padding that struct.  I 
> wonder if the fact that I'm cross compiling this application on a 
> 64-bit machine is confusing the configuration process, and making it 
> tell the compiler to align the struct on 8 byte boundaries.  I have 
> compared the definition of the struct in the kernel headers and the 
> headers in my toolchain.  They appear to be the same.
>
> Kernel:
> /* The argument to IPT_SO_GET_ENTRIES. */
> struct ipt_get_entries
> {
>        /* Which table: user fills this in. */
>        char name[IPT_TABLE_MAXNAMELEN];
>
>        /* User fills this in: total entry size. */
>        unsigned int size;
>
>        /* The entries. */
>        struct ipt_entry entrytable[0];
> };
>
> Toolchain:/* The argument to IPT_SO_GET_ENTRIES. */
> struct ipt_get_entries
> {
>        /* Which table: user fills this in. */
>        char name[IPT_TABLE_MAXNAMELEN];
>
>        /* User fills this in: total entry size. */
>        unsigned int size;
>
>        /* The entries. */
>        struct ipt_entry entrytable[0];
> };
>
> Does anyone know how to go about fixing this problem?
>
> Thanks
> Andrew McKay
> Iders Inc.
