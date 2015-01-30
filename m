From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 15:49:26 +0000
Subject: [PATCH v10 2/2] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <54CBA426.7050900@hurleysoftware.com>
References: <sc9836-serial-v10>
 <1422443324-25082-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1422443324-25082-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <54CA5128.8050500@gmail.com> <54CA568E.6080306@hurleysoftware.com>
 <20150129160553.GC26493@n2100.arm.linux.org.uk>
 <20150130101838.GC16744@ulmo> <54CB72F7.8060706@hurleysoftware.com>
 <20150130140854.GJ26493@n2100.arm.linux.org.uk>
 <54CBA426.7050900@hurleysoftware.com>
Message-ID: <20150130154926.GN26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 10:32:54AM -0500, Peter Hurley wrote:
> Before you say consistency, I think you should look at the stats below.
> IOW, if you want to change the error code return from probe() for
> consistency's sake, a tree-wide patch would be the appropriate way.

Now look outside the serial driver sub-tree.

There are 1234 instances of platform_get_resource(, IORESOURCE_MEM, ) in
the drivers/ sub-tree, with 700 instances of devm_ioremap_resource()
being used there.  Of the devm_ioremap_resource() instances:

- 555 use platform_get_resource() in the preceding two lines - which is
  not enough to do anything but rely on the -EINVAL return value.
- 16 mention ENODEV in the preceding three lines.

There are 132 which use platform_get_resource() and return ENODEV within
the following three lines (which may intersect with the above 16 number)
and 88 which use EINVAL.

So, there are in total 643 instances where a missing resource returns
EINVAL, and between 132 and 148 instances which return ENODEV.

Yes, 643 + 148 isn't 1234, but I'm not going to read through all 1234
locations just for the sake of this thread.   What's clear though is that
more than 50% of sites using platform_get_resource(, IORESOURCE_MEM, )
return EINVAL for the lack of a resource.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
