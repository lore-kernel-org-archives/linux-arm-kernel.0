From: robherring2@gmail.com (Rob Herring)
Date: Wed, 1 May 2013 08:06:56 -0500
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <20130418190923.GE14496@n2100.arm.linux.org.uk>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
 <1365251824-4852-2-git-send-email-kevin@bracey.fi>
 <20130418171801.GC14496@n2100.arm.linux.org.uk>
 <20130418182534.GD14496@n2100.arm.linux.org.uk>
 <20130418190923.GE14496@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqLFEF9o7SSCcU5isxRdKA+fQNkqOmAncOmtzeMW7KbMrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 2:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 18, 2013 at 07:25:34PM +0100, Russell King - ARM Linux wrote:
>> On Thu, Apr 18, 2013 at 06:18:01PM +0100, Russell King - ARM Linux wrote:
>> > On Sat, Apr 06, 2013 at 03:37:04PM +0300, Kevin Bracey wrote:

[...]

>> Now, with this patch applied, we guarantee that we push out any data
>> that matters from the dying CPU before platform_cpu_kill() is called.
>> That should mean that shmobile can remove that whole cpu_dead thing.
>>
>> I've tested this on OMAP, and it appears to work from a simple test of
>> CPU hotplug.  This patch(set) also kills the cpu_disable() that tegra
>> has which is just a copy of the generic version.
>
> Okay, last version for tonight, with additional comments too, and a
> hole plugged if the powering down is done by the platform via
> cpu_die().
>
>  arch/arm/kernel/smp.c               |   42 +++++++++++++++++++++++++++++++---
>  arch/arm/mach-exynos/hotplug.c      |    1 -
>  arch/arm/mach-highbank/hotplug.c    |    4 ---

Looks like this just landed in -next and it breaks highbank build.
Run-time will also be broken. See the last commit to this file in
final 3.9 which will also conflict with this one. The problem is that
highbank_set_cpu_jump calls outer cache functions which take a
spinlock and pollute the L1 cache. This all goes away once PCSI
support goes in, but for now we need another spot to clear the jump
address or just drop the highbank change.

Rob
