From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Jul 2014 11:39:54 +0100
Subject: [PATCH v7 0/4] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <53C39D5F.6050901@linaro.org>
References: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
 <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
 <20140712101602.GH21766@n2100.arm.linux.org.uk>
 <20140712111004.GI21766@n2100.arm.linux.org.uk> <53C39D5F.6050901@linaro.org>
Message-ID: <53C3B37A.8030506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/14 10:05, Daniel Thompson wrote:
> On 12/07/14 12:10, Russell King - ARM Linux wrote:
>> On Sat, Jul 12, 2014 at 11:16:02AM +0100, Russell King - ARM Linux wrote:
>>> On Mon, Jun 30, 2014 at 12:30:51PM +0100, Daniel Thompson wrote:
>>>> This patchset removes some single-platform compatibility tricks related
>>>> to DEBUG_LL and, as a result, allows multi_v7_defconfig derived builds
>>>> to enable DEBUG_LL. Currently the user selected kbuild setting is
>>>> ignored and the PL01X's DEBUG_LL stub is silently selected instead. This
>>>> is a pain if your hardware doesn't have this cell, not least because it
>>>> takes a little time to figure out that kbuild built the wrong code.
>>>
>>> I don't think this is quite right, because I'm now seeing randconfig
>>> finding build errors with this.  We can end up with this configuration:
>>>
>>> CONFIG_DEBUG_LL=y
>>> CONFIG_DEBUG_LL_UART_NONE=y
>>> # CONFIG_DEBUG_ICEDCC is not set
>>> # CONFIG_DEBUG_SEMIHOSTING is not set
>>> # CONFIG_DEBUG_LL_UART_8250 is not set
>>> # CONFIG_DEBUG_LL_UART_PL01X is not set
>>> CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
>>> # CONFIG_DEBUG_UART_8250 is not set
>>>
>>> which results in:
>>>
>>> arch/arm/kernel/debug.S:24:33: fatal error: mach/debug-macro.S: No such file or directory
>>> make[2]: *** [arch/arm/kernel/debug.o] Error 1
>>> arch/arm/kernel/head.S:27:33: fatal error: mach/debug-macro.S: No such file or directory
>>> make[2]: *** [arch/arm/kernel/head.o] Error 1
>>> Full config file:
>>> http://www.arm.linux.org.uk/developer/build/file.php?lid=11023
> 
> Thanks. I will look at this.
> 
> Problem is that by making the build system honour the user choice we end
> up breaking the build when the user makes a bad choice (albeit a bad
> choice that they should not have been given in the first place).
> 
> I guess the best fix is to get rid of CONFIG_DEBUG_LL_UART_NONE altogether.
> 
> 
>> Note that this also breaks building versatile as an oldconfig.  I'll drop
>> the patch series from my tree for the time being.
> 
> There is a difficult problem with oldconfig.
> 
> Today DEBUG_LL only works on versatile defconfigs (and oldconfig
> upgrades from there) because although CONFIG_DEBUG_LL_UART_NONE is
> selected the build system does not honour this and behaves as though the
> use selected CONFIG_DEBUG_LL_UART_PL01X instead.
> 
> Unfortunately if we fix this and remove CONFIG_DEBUG_LL_UART_NONE as
> proposed above then the oldconfig will silently select
> CONFIG_DEBUG_SEMIHOSTING.
> 
> In other words I will be able to offer a patch so that oldconfig
> *compiles* but I don't know how to get it to preserve behaviour (or
> whether this matters).
> 
> Hints about what to do would be very welcome.

Russell,

Out of interest, would you accept the much less ambitious older version
of this patch for the upcoming merge window:
http://thread.gmane.org/gmane.linux.kernel/1678055

The version linked above solves the problems for multi-platform kernel
users (which were caused by SPEARr being enabled in the default
multi-platform builds) but doesn't seek to fix things like ICEDCC and
semihosting for the remaining single platform kernels.


Daniel.
