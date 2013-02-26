From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Feb 2013 08:07:30 -0600
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <20130226113538.GS17833@n2100.arm.linux.org.uk>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
Message-ID: <512CC1A2.3060704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 05:35 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 26, 2013 at 10:23:26AM +0000, Arnd Bergmann wrote:
>> On Monday 25 February 2013, Stephen Warren wrote:
>>> Is there any other alternative I'm not seeing? Having the kernel
>>> suddenly become incompatible with any currently extant bootloader when I
>>> enable CONFIG_MULTIPLATFORM doesn't seem like a great idea.
>>
>> Could we make those errata be run-time enabled only when not booting
>> in secure mode?
> 
> The long and the short answer to this is... no.
> 
> 1. It is impossible to tell whether we're running secure or non-secure.
> 
> 2. Errata need to be applied before the MMU is initialized.  We need the
>    MMU to be initialized to run any C code what so ever, so calling out
>    to platform specific code to set errata is not possible.  Moreover,
>    we no longer determine the platform in the assembly code since DT
>    came along: this was removed because detecting it in DT from assembly
>    is far from trivial (you'd need to write an assembly DT parser).
> 
> Now, as for having the secure mode errata enabled on a kernel running in
> non-secure mode... what happens today is that we check whether something
> before the kernel has enabled the workaround, and we omit to write to
> the register.
> 
> What that means is that we expect whatever came before the kernel to have
> appropriately enabled the bits in the secure registers.  If it hasn't,
> and you have one of these secure mode workarounds enabled, the kernel
> will fault at boot time.

Only when booting in non-secure mode...

> So, if Stephen has working configs with these secure mode workarounds
> enabled, this means that the bits in the secure registers must already
> be appropriately set.

...and Stephen is booting in secure mode.

> Could the problem be that someone has made all errata workarounds, even
> those which apply after the system is up and running, depend on
> !MULTIPLATFORM ?

I don't think so. All those work-arounds remain and can be enabled.
There was one (430973) which had both a boot time chicken bit setting
and runtime piece. Only the boot time part of it is disabled for multi-plat.

Rob
