From: amckay@iders.ca (Andrew)
Date: Thu, 11 Feb 2010 14:40:29 -0600
Subject: Compiler for Atmel AT91SAMG20
In-Reply-To: <20100205180014.GA19538@caradoc.them.org>
References: <4B6C4C36.9030800@iders.ca>
	<20100205180014.GA19538@caradoc.them.org>
Message-ID: <4B746B3D.5070708@iders.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the reply.  I have switched to the arm-none-linux-gnueabi 
tools to compile my kernel and userspace applications.  It fixes one 
getsockopt call.  But now I have another similar issue with another 
getsockopt call.  In iptables libiptc.c

        /* Initialize current state */
        h->sockfd = sockfd;
        h->info = info;

        h->entries->size = h->info.size;

        tmp = sizeof(STRUCT_GET_ENTRIES) + h->info.size;

        if (getsockopt(h->sockfd, TC_IPPROTO, SO_GET_ENTRIES, h->entries,
                       &tmp) < 0){
                printf("getsockopt failed\n");
                goto error;
        }

I added some trace code to the kernel:

static int
get_entries(struct net *net, struct ipt_get_entries __user *uptr, int *len)
{
        int ret;
        struct ipt_get_entries get;
        struct xt_table *t;

        if (*len < sizeof(get)) {
                duprintf("get_entries: %u < %zu\n", *len, sizeof(get));
                printk("%s:%d get_entries: %u < %zu\n", __FILE__, 
__LINE__, *len, sizeof(get));
                return -EINVAL;
        }
        if (copy_from_user(&get, uptr, sizeof(get)) != 0)
                return -EFAULT;
        if (*len != sizeof(struct ipt_get_entries) + get.size) {
                duprintf("get_entries: %u != %zu\n",
                         *len, sizeof(get) + get.size);
                printk("%s:%d get_entries: %u != %zu\n",
                         __FILE__, __LINE__, *len, sizeof(get) + get.size);
                return -EINVAL;
        }
.
.
.

The error printed out is:
net/ipv4/netfilter/ip_tables.c:1178 get_entries: 660 != 656

I've done some digging on google and found that there is mention of this 
error with a 32-bit version of iptables running on a 64-bit kernel.  
However since this is running on an ARM board both the kernel and 
userspace applications are 32-bit.  There is a kernel option called 
CONFIG_COMPAT which is used to add 32-bit support in a 64-bit kernel.  
However this option is only available if the architecture of the kernel 
is IA64.

I haven't found a mention of a final solution to this problem in my 
searches yet.

I did a bit more digging and found that the struct ipt_get_entries is 
different sizes in kernel space and in user space.  In kernel space it 
is being reported as 36 bytes, in userspace the struct is being reported 
as 40 bytes.

net/ipv4/netfilter/ip_tables.c:1180 sizeof(struct ipt_get_entries): 36
sizeof(STRUCT_GET_ENTRIES): 40

It looking@the struct it should be 36 bytes large if it is unpadded.  
So it appears that iptables is padding that struct.  I wonder if the 
fact that I'm cross compiling this application on a 64-bit machine is 
confusing the configuration process, and making it tell the compiler to 
align the struct on 8 byte boundaries.  I have compared the definition 
of the struct in the kernel headers and the headers in my toolchain.  
They appear to be the same.

Kernel:
/* The argument to IPT_SO_GET_ENTRIES. */
struct ipt_get_entries
{
        /* Which table: user fills this in. */
        char name[IPT_TABLE_MAXNAMELEN];

        /* User fills this in: total entry size. */
        unsigned int size;

        /* The entries. */
        struct ipt_entry entrytable[0];
};

Toolchain:/* The argument to IPT_SO_GET_ENTRIES. */
struct ipt_get_entries
{
        /* Which table: user fills this in. */
        char name[IPT_TABLE_MAXNAMELEN];

        /* User fills this in: total entry size. */
        unsigned int size;

        /* The entries. */
        struct ipt_entry entrytable[0];
};

Does anyone know how to go about fixing this problem?

Thanks
Andrew McKay
Iders Inc.


Daniel Jacobowitz wrote:
> On Fri, Feb 05, 2010 at 10:49:58AM -0600, Andrew wrote:
>   
>> The compiler I'm using for the Kernel (Code Sourcery's GNU
>> cross-toolchain arm-2008q3-66-arm-none-eabi) is set to pack structs
>> by default, and the compilers that I use for userspace applications
>> do not pack structs.
>>     
>
> That's the wrong compiler.  Use the arm-none-linux-gnueabi tools to
> build the Linux kernel.
>
> The EABI tools should have the same ABI as the Linux tools though, so
> I don't know what you mean by not packing structs.  Make sure both
> your kernel and userspace compilers are using the EABI!  Or, if you
> are not using an EABI userspace, disable CONFIG_AEABI.
>
>   
