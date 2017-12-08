From: glin@suse.com (Gary Lin)
Date: Fri, 8 Dec 2017 18:03:02 +0800
Subject: [RFC v3 PATCH 0/2] Introduce Security Version to EFI Stub
In-Reply-To: <20171207142657.52e1363a@alans-desktop>
References: <20171205100148.5757-1-glin@suse.com>
 <20171207142657.52e1363a@alans-desktop>
Message-ID: <20171208100302.an3bi3baewifcakc@GaryWorkstation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 02:26:57PM +0000, Alan Cox wrote:
> On Tue,  5 Dec 2017 18:01:46 +0800
> Gary Lin <glin@suse.com> wrote:
> 
> > The series of patches introduce Security Version to EFI stub.
> > 
> > Security Version is a monotonically increasing number and designed to
> > prevent the user from loading an insecure kernel accidentally. The
> > bootloader maintains a list of security versions corresponding to
> > different distributions. After fixing a critical vulnerability, the
> > distribution kernel maintainer bumps the "version", and the bootloader
> > updates the list automatically. 
> 
> This seems a mindbogglingly complicated way to implement something you
> could do with a trivial script in the package that updates the list of
> iffy kernels and when generating the new grub.conf puts them in a menu
> of 'old insecure' kernels.
> 
Ya, a menu for those kernels is also a kind of warning to the users.
Thanks for pointing the direction.

> Why do you even need this in the EFI stub ?
> 
For 2 reasons.

1. We want the version number being unalterable. In a system with UEFI
   Secure Boot, the signature appended to the kernel guarantees that the
   version number is genuine.

2. For the cross-architecture support. Since the version number could be
   anywhere in the image file, we need at least a offset to point to the
   version number. That's why I choose the resource section/table in the
   EFI header. It exists as long as the EFI stub exists. The design of
   the directory allows different data stored separately.

If there is a better place for the version number, I'd be glad to adopt
it.

> What happens if you want to invalidate an old kernel but not push a new
> one ? Today if you've got a package that maintains the list of 'iffy'
> kernels you can push a tiny package, under your scheme you've got to push
> new kernels which is an un-necessary and high risk OS change.
> 
The idea is that the security version only bumps only when it's really
necessary. For example, the new kernel fixes a severe bug that invalidates
the signature check of the modules. Or, the distro makes an official
release and would like to obsolete the alpha/beta/RC kernel. Anyway, it
depends on the distro policy.

Actually, our main target is only for the enterprise server, and the
kernel update path is relatively simple. Since it may bring some
confusion in a multi-boot system, we are currently not planning to
enable SV for the community distro, i.e. openSUSE.

Thanks,

Gary Lin
