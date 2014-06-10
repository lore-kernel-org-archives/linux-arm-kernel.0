From: sdu.liu@huawei.com (Liu hua)
Date: Tue, 10 Jun 2014 14:52:32 +0800
Subject: [PATCH v3 2/2] ARM : change fixmap mapping region to support
 32 CPUs
In-Reply-To: <alpine.LFD.2.11.1405301441210.17310@knanqh.ubzr>
References: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
 <1397559967-26050-3-git-send-email-sdu.liu@huawei.com>
 <CAL_JsqKE-L2PN3mXHNdTPMEyTMR9ZtbgGB=O_V6nOXN0YC0a4A@mail.gmail.com>
 <alpine.LFD.2.11.1405301441210.17310@knanqh.ubzr>
Message-ID: <5396AB30.10607@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/5/31 3:25, Nicolas Pitre Wrote:
> On Fri, 30 May 2014, Rob Herring wrote:
> 
>> There's work in flight to support early_ioremap, early console, and RO
>> text patching which all use the fixmap region.
>>
>> There's a couple of options to solve this:
>>
>> - Only support up to 16 cpus. It could be anywhere between 17-31, but
>> that seems somewhat unlikely. Are we really ever going to see 32-bit
>> 32 core systems?
> 
> I wouldn't rule that out.  I've seen 16-core ARM chips in 2008 (although 
> they didn't go into production).  Silly limitations like that always 
> come back to bite you.  And we have better alternatives.New

 Now our team is woring on arma15 with 16 CPUs.
> 
>> - Reduce KM_TYPE_NR from 16 to 15. Based on the comment for it, we
>> probably don't want to do that. Is increasing it to the default of 20
>> worthwhile? Some of the options here would allow doing that.
>> - Add 0xffe00000-0xfff00000 to the fixmap region. This would make
>> fixmap span 2 PMDs with the top PMD having a mixture of uses like we
>> had before.
> 
> That would be my preferred approach.  Note here it could be 
> 0xffe00000-0xfffe0000 to include the whole of the previous fixmap area 
> curently unused.
> 
>> - push the PCI i/o space down to 0xfec00000 and make fixmap 4MB. This
>> is a cleaner solution as the 2 PMDs are only used for fixmap. This may
>> require some static mapping adjustments on some platforms.
> 
> No need.  With the latest changes, the fixmap area is between 0xffc00000 
> and 0xffe00000 (there is apparently a mistake in 
> Documentation/arm/memory.txt).  So currently 0xff000000-0xffc00000 is 
> free, which makes the fixmap area far away from the PCI i/o area with 
> plenti of space in between.
> 
>> - Same as previous option, but convert the PCI i/o space to fixmap
>> entries. We don't really need all 2MB for PCI.
> 
> See above.
> 
>> Also, there is an error in the documentation below:
>>
>>>
>>> Signed-off-by: Liu Hua <sdu.liu@huawei.com>
>>> ---
>>>  Documentation/arm/memory.txt   |  2 +-
> 
> Yep, good that you spotted it as well.  I failed to catch it during my 
> review so I'll send a patch.
> 

Very sorry for the mistake and ignoreing this mail. Maybe I should imporve
my email client!

Thanks again for Nicolas.

Thanks,
Liu Hua
> 
> Nicolas
> 
> .
> 
