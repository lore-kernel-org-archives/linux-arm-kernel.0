From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Mar 2014 16:21:01 +0100
Subject: [PATCH v6 6/6] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <20140310144414.GT6457@e106497-lin.cambridge.arm.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com>
 <201403081815.08829.arnd@arndb.de>
 <20140310144414.GT6457@e106497-lin.cambridge.arm.com>
Message-ID: <2115856.ZTdgp5fkma@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014 14:44:14 Liviu Dudau wrote:
> I will try to improve the error handling in the next patchset version.
> However I am still confused about the earlier discussion on
> pci_register_io_range(). Your suggestion initially was to return an
> error in the default weak implementation, but in your last email you
> are talking about returning 'port'.

You can do either one: 'port' should be positive or zero, while the
error would always be negative. We do the same thing in many interfaces
in the kernel.

> My idea when I've introduced the
> helper function was that it would return an error if it fails to
> register the IO range and zero otherwise. I agree that we can treat
> the default 'do nothing with the IO range' case as an error, with
> the caveat that will force architectures that use this code to
> provide their own implementation of pci_register_io_range() in order
> to avoid failure, even for the cases where the architecture has a 1:1
> mapping between IO and CPU addresses.

Which architectures are you thinking of? The only one I know that
does this is ia64, and we won't ever have to support this helper
on that architecture.

I did not ask to treat 'do nothing with the IO range' as an error,
what I meant is that we should treat 'architecture cannot translate
from I/O space to memory space but DT lists a translation anyway'
as an error. On x86, you should never see an entry for the I/O space
in "ranges", so we will not call this function unless there is a
bug in DT.

	Arnd
