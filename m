From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 16:25:25 +0100
Subject: [PATCH] arm/xen: Enable user access to the kernel before issuing
 a privcmd call
In-Reply-To: <55F2EBA6.6060008@citrix.com>
References: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
 <1441981760.3549.57.camel@citrix.com> <55F2E909.70600@citrix.com>
 <1441983304.3549.73.camel@citrix.com> <55F2EBA6.6060008@citrix.com>
Message-ID: <20150911152525.GU21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:56:38PM +0100, Julien Grall wrote:
> Well, we can't assume that the function will be called with uaccess
> disabled.

Please explain your reasoning.

The reason copy_from_user() et.al. need to save and restore the DACR is
because the DACR may be in one of two states on older ARM architectures.
It may have set the kernel domain to 'manager' mode, to allow these
accessors to work on kernel memory, or the kernel domain may be in
'client' mode, thereby preventing the accessors from touching kernel
memory.

Unless the code path is reachable with the kernel domain in manager
mode, (iow, a set_fs(KERNEL_DS) or set_fs(get_ds()) has been done) then
it should be safe to use uaccess_disable/uaccess_enable.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
