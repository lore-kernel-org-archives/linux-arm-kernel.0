From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 8 Feb 2011 11:31:19 -0700
Subject: [PATCH 3/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <201102081924.37654.arnd@arndb.de>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<201102081625.57049.arnd@arndb.de>
	<99854086-e4ef-4940-a454-5f3a43caaf3a@VA3EHSMHS003.ehs.local>
	<201102081924.37654.arnd@arndb.de>
Message-ID: <AANLkTimGcdm3omDL=KhxJ7wPhWp0B7oWRA7FQHwUrMNE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 8, 2011 at 11:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 February 2011 18:53:50 John Linn wrote:
>> Maybe I'm being dense here, just wanting to be clear.
>>
>> But that still doesn't provide physical addresses for each device like
>> you would need to put in the resources
>> for platform devices.
>
> No, you're right. If you want to have them in proper resource
> structures, you need the physical addresses as unsigned long
> numbers, not the virtual address pointers.
>
>> Do you just cast them back to an integer then?
>
> No, you certainly never do that, it would be a clear
> violation of the type system. You should assume that
> physical and virtual addresses are different, and never
> build any driver code under the assumption that the
> virtual addresses are fixed (except perhaps the PCI
> PIO window).
>
> My personal recommendation would be to either put the
> physical address into the resource structure and have
> the driver ioremap the registers, or to map the entire
> registers at boot time, and have the driver use the
> hardcoded values while ignoring the resources.
>
> The ioremap approach is more flexible, in particular when
> you build a kernel that can have the devices at varying
> locations, but it doesn't work for all the low-level devices
> that you might need to talk to before the MMU code is
> fully initialized, such as timers and interrupt controllers.

Arnd's right. Don't let the code make any assumptions about
phys==virt, use phys address in the resource structure, and ioremap
whenever you can.  Only when ioremap isn't available should you have
virt addrss macros which are derived from the phys address ones.

g.
