From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Mar 2013 09:47:27 -0600
Subject: [PATCH 1/7] kbuild: create an "include chroot" for DT bindings
In-Reply-To: <20130318151348.GB4713@S2101-09.ap.freescale.net>
References: <1362594183-21523-1-git-send-email-swarren@wwwdotorg.org>
 <20130318151348.GB4713@S2101-09.ap.freescale.net>
Message-ID: <5147370F.9030500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 09:13 AM, Shawn Guo wrote:
> On Wed, Mar 06, 2013 at 11:22:57AM -0700, Stephen Warren wrote:
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
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
>> Acked-by: Michal Marek <mmarek@suse.cz>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> This first patch was previously posted separately as V2. I'm including
>> it here to keep it with the whole series. I hope this series can be
>> applied as a topic branch in arm-soc.
> 
> So no comments on the series means that we can start maintain it on
> a topic branch, so that people can base their works on it?

I was thinking of reposting the series today due to lack of responses,
so that the content was freshly available in people's inboxes.
