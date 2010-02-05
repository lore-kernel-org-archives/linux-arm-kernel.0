From: amckay@iders.ca (Andrew)
Date: Fri, 05 Feb 2010 10:49:58 -0600
Subject: Compiler for Atmel AT91SAMG20
Message-ID: <4B6C4C36.9030800@iders.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm having an issue with the compiler that I'm using for building a 
Kernel for my Atmel AT91SAM9G20 processor.  I had a problem with 
iptables.  When I run the command it reports an error of "getsockopt 
failed strangely: Invalid argument".  I traced the problem to Kernel 
space and it not being happy with the size of the struct passed to 
kernel space.  In this case userspace thinks that the ipt_get_revision 
struct is 32 bytes, and the Kernel thinks it is 30 bytes. 

 From net/ipv4/netfilter/ip_tables.c:

static int
do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
{
        int ret;

        if (!capable(CAP_NET_ADMIN))
                return -EPERM;

        switch (cmd) {
        case IPT_SO_GET_INFO:
                ret = get_info(sock_net(sk), user, len, 0);
                break;

        case IPT_SO_GET_ENTRIES:
                ret = get_entries(sock_net(sk), user, len);
                break;

        case IPT_SO_GET_REVISION_MATCH:
        case IPT_SO_GET_REVISION_TARGET: {
                struct ipt_get_revision rev;
                int target;

                if (*len != sizeof(rev)) {
                        printk("%d != %d\n", *len, sizeof(rev));
                        printk("ipt_get_revision is different sizes\n");
                        ret = -EINVAL;
                        break;
                }
                if (copy_from_user(&rev, user, sizeof(rev)) != 0) {
                        ret = -EFAULT;
                        break;
                }

                if (cmd == IPT_SO_GET_REVISION_TARGET)
                        target = 1;
                else
                        target = 0;

                try_then_request_module(xt_find_revision(AF_INET, rev.name,
                                                         rev.revision,
                                                         target, &ret),
                                        "ipt_%s", rev.name);
                break;
        }

        default:
                duprintf("do_ipt_get_ctl: unknown request %i\n", cmd);
                ret = -EINVAL;
        }

        return ret;
}


The compiler I'm using for the Kernel (Code Sourcery's GNU 
cross-toolchain arm-2008q3-66-arm-none-eabi) is set to pack structs by 
default, and the compilers that I use for userspace applications do not 
pack structs.

I would prefer to have the compiler I use for the Kernel to not pack 
structs as all of our other toolchains don't do this.  Can anyone 
recommend another compiler for building Kernels for the AT91SAM9G20 
processor?  Or is there a way to tell the compiler to not pack structs 
when building the Kernel?  I tried adding -fpack-struct=4 to the 
KBUILD_CFLAGS but it didn't seem to make a difference on how bit the 
Kernel thinks the struct is.

My other option is to compile a glibc library for the Code Sourcery 
toolchain so I can build userspace applications with pack structs, but I 
would prefer not to do this.

Andrew McKay
Iders Inc.
