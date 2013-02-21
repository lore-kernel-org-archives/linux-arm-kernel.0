From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Feb 2013 11:43:13 -0700
Subject: [PATCH] kbuild: create an "include chroot" for DT bindings
In-Reply-To: <20130221043751.GB17738@S2101-09.ap.freescale.net>
References: <1361394356-19385-1-git-send-email-swarren@wwwdotorg.org>
 <20130221043751.GB17738@S2101-09.ap.freescale.net>
Message-ID: <51266AC1.8040507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 09:37 PM, Shawn Guo wrote:
> On Wed, Feb 20, 2013 at 02:05:56PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The recent dtc+cpp support allows header files and C pre-processor
>> defines/macros to be used when compiling device tree files. These
>> headers will typically define various constants that are part of the
>> device tree bindings.
>>
>> The original patch which set up the dtc+cpp include path only considered
>> using those headers from device tree files. However, they are also
>> useful for kernel code which needs to interpret the device tree.
>>
>> In both the DT files and the kernel, I'd like to include the DT-related
>> headers in the same way, for example, <dt-bindings/gpio/tegra-gpio.h>.
>> That will simplify any text which discusses the DT header locations.
>>
>> Creating a <dt-bindings/> for kernel source to use is as simple as
>> placing files into include/dt-bindings/.
>>
>> However, when compiling DT files, the include path should be restricted
>> so that only the dt-bindings path is available; arbitrary kernel headers
>> shouldn't be exposed. For this reason, create a specific include
>> directory for use by dtc+cpp, and symlink dt-bindings from there to the
>> actual location of include/dt-bindings/. For want of a better location,
>> place this "include chroot" into the existing dts/ directory.
>>
>> arch/*/boot/dts/include/dt-bindings -> ../../../../../dt-bindings
> 
> ../../../../../include/dt-bindings

Yup.

> And, I would expect only the headers that will actually be referenced
> by kernel should go into include/dt-bindings.  There is no point to
> put headers that will not be included by kernel but only by dts files
> into there, and instead arch/arm/boot/dts/include should just be good
> enough for them.  With this agreed ...

There are two things that include DT-related headers:

a) Device trees (*.dts, *.dtsi)
b) The kernel

All the headers relevant here fall into category (a) by definition. I'd
actually expect most to also fall into category (b), although I can see
that category (b) might be a strict subset of category (a).

I believe you're proposing only storing category (b) headers in
include/dt-bindings/, and storing any others I suppose in arch/*/boot/dts/.

But, my thoughts are that /all/ these headers (both categories) should
be stored in one place for consistency.

That way, if/when the DT binding docs, these headers, and the DT files
themselves move out of the kernel, we'll end up with some other
repository/repositories that might have the following top-level
directories (or at least these sets of logical data):

1) DT binding documents
2) Headers that define constants for (1)
3) DT files (*.dts/*.dtsi)

We need at least some of (2) in the kernel for drivers to share the
constant definitions, so my proposal is to simply copy /all/ the headers
from (2) into the kernel's include/dt-bindings/. That keeps things
simple; simply copy everything and maintain the same hierarchy under
that "root" directory. Otherwise, we'll be constantly wondering which
headers to copy, perhaps moving things back/forth as people realize that
the kernel needs them, etc.
