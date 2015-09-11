From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 16:36:55 +0100
Subject: [PATCH] arm/xen: Enable user access to the kernel before issuing
 a privcmd call
In-Reply-To: <20150911152525.GU21084@n2100.arm.linux.org.uk>
References: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
 <1441981760.3549.57.camel@citrix.com> <55F2E909.70600@citrix.com>
 <1441983304.3549.73.camel@citrix.com> <55F2EBA6.6060008@citrix.com>
 <20150911152525.GU21084@n2100.arm.linux.org.uk>
Message-ID: <55F2F517.6020105@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/15 16:25, Russell King - ARM Linux wrote:
> On Fri, Sep 11, 2015 at 03:56:38PM +0100, Julien Grall wrote:
>> Well, we can't assume that the function will be called with uaccess
>> disabled.
> 
> Please explain your reasoning.

I think I was confused about the usage of uaccess.
Thank you for the explanation.

> The reason copy_from_user() et.al. need to save and restore the DACR is
> because the DACR may be in one of two states on older ARM architectures.
> It may have set the kernel domain to 'manager' mode, to allow these
> accessors to work on kernel memory, or the kernel domain may be in
> 'client' mode, thereby preventing the accessors from touching kernel
> memory.
> 
> Unless the code path is reachable with the kernel domain in manager
> mode, (iow, a set_fs(KERNEL_DS) or set_fs(get_ds()) has been done) then
> it should be safe to use uaccess_disable/uaccess_enable.


I believe that our privcmd driver doesn't made any usage of set_fs(...),
so I will use the uaccess_{disable,enable} macro.

Regards,

-- 
Julien Grall
