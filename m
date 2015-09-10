From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 10 Sep 2015 11:19:51 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <20150910095208.GA29293@leverpostej>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
Message-ID: <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Sep 2015, Mark Rutland wrote:
> Hi,
> 
> I'm not necessarily opposed to the renaming, but I think that this is
> the least important thing to standardize for this to work.
> 
> On Thu, Sep 10, 2015 at 09:41:56AM +0100, Shannon Zhao wrote:
> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > These EFI stub parameters are used to internal communication between EFI
> > stub and Linux kernel and EFI stub creates these parameters. But for Xen
> > on ARM when booting with UEFI, Xen will create a minimal DT providing
> > these parameters for Dom0 and Dom0 is not only Linux kernel, but also
> > other OS (such as FreeBSD) which will be used in the future.
> 
> Currently the Linux EFI stub and kernel have a symbiotic relationship,
> because they're intimately coupled and we don't have kexec (yet) on EFI
> platforms to loosen that coupling.
> 
> If an agent other than the (kernel-specific) stub is going to provide
> this to the kernel, then we need more specified than just the property
> names.
> 
> That at least includes the following:
> 
> * The state of boot services (we currently have the EFI stub call
>   ExitBootServices(), and I believe this is crucial to the plan for
>   kexec).
> 
> * The state of the address map (we currently have the EFI stub call
>   SetVirtualAddressMap()).
> 
> * The virtual address range(s) that SetVirtualAddressMap() may map
>   elements to (this logic is currently in the EFI stub, and this matches
>   the expectations of the kernel that it is tied to).
> 
> > So here we plan to standardize the names by dropping the prefix
> > "linux," and make them common to other OS. Also this will not break
> > the compatibility since these parameters are used to internal
> > communication between EFI stub and kernel.
> 
> For the moment this is true, but will not be once we have kexec, so
> there's a dependency (or anti-dependency) there.
> 
> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > ---
> > Look at [1] for the discussion about this in Xen ML. The purpose of this
> > patch is to standardize the names to make Linux ARM kernel work on Xen
> > with UEFI. Also it hopes other OS(e.g. FreeBSD), which will be used as
> > Dom0 on Xen, could support this mechanism as well.
> > 
> > [1]http://lists.xenproject.org/archives/html/xen-devel/2015-08/msg02250.html
> 
> Per this post, it looks like to pass a DTB to the kernel Xen already
> needs to know it's a Linux kernel...
> 
> I wasn't aware that there was a common standard for arm(64) kernels
> other than a PE/COFF EFI application.
> 
> Does Xen not talk to EFI itself and/or give the kernel a virtual EFI
> interface?

Xen talks to EFI itself but the interface provided to dom0 is somewhat
different: there are no BootServices (Xen calls ExitBootServices before
running the kernel), and the RuntimeServices go via hypercalls (see
drivers/xen/efi.c).
