From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 3 Dec 2013 16:32:28 +0000
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <529E04AB.5060304@linaro.org>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
 <20131203160018.67542a53@alan.etchedpixels.co.uk>
 <529E04AB.5060304@linaro.org>
Message-ID: <20131203163228.3313dff8@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > How does the patch ensure new kernels on existing hypervisor versions
> > don't break ?
> 
> As Ian said on the thread "xen-block: correctly define structures in
> public headers" (see thread https://lkml.org/lkml/2013/12/3/155), the
> ABI is not yet fixed for ARM.

And if you are one of the existing users that helps how ?

> > 
> > What is the failure case given the alignment change seems potentially to
> > produce valid but incorrect I/O requests - can it cause corruption ?
> 
> The request ID will likely be wrong, so the guest won't accept the
> request. It should not corrupt the block device.

"Would likely" 

That seems joyously confident.

So at the very least your guest should deliberately issue a request which
will error if the ABI version mismatches, and at that point you know
which ABI to use so the guest can keep compatibility trivially.

> > It seems to me you should be defining
> > 
> > struct blkif_request_rw_v2
> > 
> > and using the correct version according to which API the hypervisor
> > requires, not just breaking it.
> 
> This API doesn't involve the hypervisor. It's only a way to talk between
> DOM0 and a guest. Without this change you will break compatibility with
> other OSes.

With this change you break compatibility between the existing OS's,new
guests and old DOM0 and vice versa.

If a request in old format is guaranteed to error in new format (or you
can construct one that will) then you can trivially support both APIs on
the guest side at least for a while. That will avoid regressions when
people mix versions and also mean you've got a much better ability to
find a bug if stuff breaks as you won't have to switch guest and dom0
together when debugging.

Alan
