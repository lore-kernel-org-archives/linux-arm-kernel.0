From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 15 Nov 2016 10:55:20 +0100
Subject: [PATCH v2] staging: vc04_services: rework ioctl code path
In-Reply-To: <20161111061531.23507-1-mzoran@crowfest.net>
References: <20161111061531.23507-1-mzoran@crowfest.net>
Message-ID: <20161115095520.GA18059@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:15:31PM -0800, Michael Zoran wrote:
> VCHIQ/vc04_services has a userland device interface
> that includes ioctls. The current ioctl implementation
> is a single monolithic function over 1,000+ lines
> that handles 17 different ioctls through a complex
> maze of switch and if statements.
> 
> The change reimplements that code path by breaking
> up the code into smaller, easier to maintain functions
> and uses a dispatch table to invoke the correct function.
> 
> Testing:
> 
> 1. vchiq_test -f 10 and vchiq_test -p 1 were run from a native
> 64-bit OS(debian sid).
> 
> 2. vchiq_test -f 10 and vchiq_test -p 1 where run from a 32-bit
> chroot install from the same OS.
> 
> Both test cases pass.
> 
> This is V2 of this patch.  Changes include:
> 
> 1. More code has been moved to the dispatch routine.
> The dispatch routine is now responsible for copying the top-level
> data into and out of kernel space by using the data encoded in
> the ioctl command number.
> 
> 2. The number of parameters have been reduced for the handling
> functions by giving a different prototype to ioctls that pass
> no arguments.
> 
> 3. Macros in linux/compat.h are now used for compatibility data
> structures.
> 
> Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 1733 +++++++++++++-------
>  .../interface/vchiq_arm/vchiq_ioctl.h              |   96 ++
>  2 files changed, 1200 insertions(+), 629 deletions(-)

This is a rough patch to review, can you break this up into a patch
series that moves each ioctl to a separate function as needed?

thanks,

greg k-h
