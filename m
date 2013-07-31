From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 1 Aug 2013 04:34:03 +0900
Subject: [PATCH] ARM: Fix memblock_reserve() to include stext
In-Reply-To: <20130731094352.GV24642@n2100.arm.linux.org.uk>
References: <20130731055807.14054.70106.sendpatchset@w520>
 <20130731094352.GV24642@n2100.arm.linux.org.uk>
Message-ID: <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 6:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 31, 2013 at 02:58:07PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This fix for the ARM architecture will include stext
>> in the memblock_reserve() call to make sure that the
>> following symbols are not overwritten (from System.map):
>>
>> c0008000 T _text
>> c0008000 T stext
>> ...
>> c0008138 T secondary_startup
>> ...
>> c0009000 T _stext
>>
>> With this patch applied CPU Hotplug starts working
>> again. Without this patch code in secondary_startup
>> never gets reached as expected.
>>
>> This issue started triggering on kernels later than
>> v3.10 - perhaps a side effect of the CPU Hotplug init
>> section rework - so this is a fix for v3.11-rc.
>
> This is not the right fix.  The commit you previously pointed out (removal
> of CPU hotplug) probably means there's a missing annotation somewhere in
> the code.
>
> And yes - the __CPUINIT just before ENTRY(secondary_startup) was removed
> rather than being replaced with a .text (in both head.S and head-nommu.S).
> Same goes for ENTRY(lookup_processor_type) in head-common.S.  All these
> need to be replaced with .text to stop them falling into the head section.

Thanks for your guidance, Russell. The right way to fix this now seems
pretty clear to me.

Are you aware of any existing fix for this or anyone working on
solving this issue? If not then I don't mind stepping up. I can
however think of quite a few other things to do if this has been
solved already though, so please let me know if you think I should
focus on fixing this.

Cheers,

/ magnus
