From: digetx@gmail.com (Dmitry Osipenko)
Date: Wed, 20 Dec 2017 15:49:39 +0300
Subject: [PATCH 1/9] ARM: enable secure platform-only erratas
In-Reply-To: <20171219232810.GI10595@n2100.armlinux.org.uk>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <77ce738c15b992a92bee3a18e5468342fb2dc5ab.1500510157.git.mirq-linux@rere.qmqm.pl>
 <bdff72b9-8ebd-a426-b27b-fe055d45cfb1@gmail.com>
 <20171219232810.GI10595@n2100.armlinux.org.uk>
Message-ID: <21964ae9-4c60-36b2-627d-04e4e975a38d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.12.2017 02:28, Russell King - ARM Linux wrote:
> On Thu, Oct 05, 2017 at 09:16:12PM +0300, Dmitry Osipenko wrote:
>> On 20.07.2017 03:29, Micha? Miros?aw wrote:
>>> Allow secure-only erratas to be used in multiarch kernel.
>>>
>>> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
>>> ---
>>>  arch/arm/Kconfig | 20 ++++++++++++++------
>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index a208bfe367b5..a1eff866550b 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -696,6 +696,14 @@ config ARCH_MULTI_CPU_AUTO
>>>  
>>>  endmenu
>>>  
>>> +config ARCH_ASSUME_SECURE_PLATFORM
>>> +	bool "Enable ERRATAs using secure-only registers"
>>> +	default !ARCH_MULTIPLATFORM
>>
>> I think default should always be "Yes" and this option shouldn't affect
>> multiplatform kernels. So a multiplatform kernel wouldn't be an option
>> for your device.
> 
> No, that changes the current behaviour.
> 
> Current behaviour is for the secure-only errata to be disabled when the
> multi-platform option is enabled, because multi-platform kernels have to
> be able to run in the non-secure world.  Defaulting this option to "yes"
> means that these errata become visible.

Indeed, I got it inverted.

> I have to wonder why you need this though - your patches seem to be
> targetting a platform that runs in non-secure world, and enabling these
> errata would make the kernel non-bootable on your platform.

Perhaps because Micha? made the Tegra's CPU reset handler hardcoded to either
secure or to non-secure case based on the kernels configuration. I've showed how
we can get rid of that inflexibility in [0], maybe Micha? could pick up the idea
in the next iteration of the patches.

[0] https://marc.info/?l=linux-tegra&m=151371042522835
