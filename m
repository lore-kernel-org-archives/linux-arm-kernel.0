From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Fri, 5 Jan 2018 21:23:34 +0900
Subject: [PATCH 00/13] replace print_symbol() with printk()-s
In-Reply-To: <20180105120131.GA417@jagdpanzerIV>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
 <20180105100300.j3svmcvvpfe2iows@pathway.suse.cz>
 <20180105102105.GB471@jagdpanzerIV>
 <20180105120131.GA417@jagdpanzerIV>
Message-ID: <20180105122334.GB417@jagdpanzerIV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (01/05/18 21:01), Sergey Senozhatsky wrote:
[..]
> but, print_symbol() is compiled out on !CONFIG_KALLSYMS systems. so,
> basically, we compile out some of errors print outs; even more, on ia64
> ia64_do_show_stack() does nothing when there is no CONFIG_KALLSYMS [all
> ia64 defconfigs have KALLSYMS_ALL enabled]. printk(%pS), unlike
> print_symbol(), is not compiled out and prints the function address
> when symbolic name is not available. but, at a glance, print_symbol()
> in most of the cases has printk(registers) next to it or before it, so
> it doesn't look like we are introducing a regression here by switching
> to printk(%pS).

well, if this is a problem, then we can have

static inline void print_symbol(const char *fmt, unsigned long addr)
{
       printk(fmt, addr);
}

for CONFIG_KALLSYMS builds, and an empty print_symbol() for !CONFIG_KALLSYMS
builds.


but we still have tons printk(%pS) in the kernel and even print_ip_sym()
(which is not compiled out on !CONFIG_KALLSYMS). so it seems to me that
we can drop print_symbol()/__print_symbol() and switch to printk(%pS)
after all.

	-ss
