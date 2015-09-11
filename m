From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 16:20:34 +0100
Subject: [PATCH] arm/xen: Enable user access to the kernel before issuing
 a privcmd call
In-Reply-To: <55F2E909.70600@citrix.com>
References: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
 <1441981760.3549.57.camel@citrix.com> <55F2E909.70600@citrix.com>
Message-ID: <20150911152034.GT21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:45:29PM +0100, Julien Grall wrote:
> Looking to the uaccess_save macro:
> 
>         .macro  uaccess_save, tmp
> #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         mrc     p15, 0, \tmp, c3, c0, 0
>         str     \tmp, [sp, #S_FRAME_SIZE]
> #endif
>         .endm
> 
> 
> It's saving the register on the Stack with an offset S_FRAME_SIZE.
> AFAICT, S_FRAME_SIZE is the size of the pt_regs structure.

While in the kernel, the uaccess state will be disabled except for the
specific sites reading or writing userspace.  That means the user-access
part of the DACR is well known.

What isn't known is whether we're executing here in the kernel segment
(set_fs(get_ds())) or not - which allows the kernel to use the userspace
accessors to safely read from its own memory space.

If we can assume that's not in effect, then the DACR value is fully
known at this point, and you can just do a:

	uaccess_enable rtmp
	HVC call
	uaccess_disable rtmp

where rtmp is a register you can afford to be changed by the macro.
I suspect 'ip' would be a good choice there.

Please put the macros as close to __HVC(XEN_IMM) as possible.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
