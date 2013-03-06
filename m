From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 09:14:38 -0700
Subject: [PATCH V2 REPOST] kbuild: create an "include chroot" for DT
 bindings
In-Reply-To: <5136E866.20008@gmail.com>
References: <1362506797-21905-1-git-send-email-swarren@wwwdotorg.org>
 <5136E866.20008@gmail.com>
Message-ID: <51376B6E.2060806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2013 11:55 PM, Rob Herring wrote:
> On 03/05/2013 12:06 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The recent dtc+cpp support allows header files and C pre-processor
>> defines/macros to be used when compiling device tree files. These
>> headers will typically define various constants that are part of the
>> device tree bindings.
>>
>> The original patch which set up the dtc+cpp include path only considered
>> using those headers from device tree files. However, most are also
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
>> arch/*/boot/dts/include/dt-bindings -> ../../../../../include/dt-bindings
>>
>> Some headers used by device tree files may not be useful to the kernel;
>> they may be used simply to aid in constructing the DT file (e.g. macros
>> to create a node), but not define any information that the kernel needs
>> to share. These may be placed directly into arch/*/boot/dts/ along with
>> the DT files themselves.
>>
>> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
>> Acked-by: Michal Marek <mmarek@suse.cz>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Grant, Rob,
>>
>> This is a pre-requisite for people to convert their *.dts files to use
>> cpp, and hence is likely to be useful for a number of ARM subarch trees.
>> Perhaps this patch can be placed into a standalone topic branch in the
>> DT repo so we can all merge it. Assuming this patch is OK, I would also
>> repost the patches that create common headers defining IRQ, and GPIO
>> flags, which would place files into the new include/dt-bindings
>> directory.
> 
> This looks fine to me. As all these will all be arm-soc branches with
> the dependency, it probably makes more sense for Arnd/Olof to apply this
> and create the branch for this single patch.

OK, that'd work fine for me too. I expect that arm-soc branch would also
include the few patches to create some common headers, once I repost.
