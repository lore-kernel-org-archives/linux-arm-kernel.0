From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 29 Oct 2015 13:08:51 -0700
Subject: [GIT PULL] memremap fix for 4.3
In-Reply-To: <20151029170950.GP8644@n2100.arm.linux.org.uk>
References: <1446105610.23766.17.camel@intel.com>
 <20151029170950.GP8644@n2100.arm.linux.org.uk>
Message-ID: <CAPcyv4izsS-qj2eeMB1cpJmFMwbtPXBG_QeGVB-O44vEHnptOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 10:09 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 29, 2015 at 08:00:13AM +0000, Williams, Dan J wrote:
>> Hi Linus, please pull from:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes
>>
>> ...to receive a small fixlet for 4.3.
>>
>> The new memremap() api introduced in the 4.3 cycle to unify/replace
>> ioremap_cache() and ioremap_wt() is mishandling the highmem case.  This
>> patch has received a build success notification from a 0day-kbuild-robot
>> run and has been out for a review for a day.  Russell has not had a
>> chance to weigh in on it yet.
>
> Oh, was this merged for 4.3-rc1?  I haven't noticed any problems if it
> has.
>
>> I do not think the usage of kmap is strictly necessary as we should be
>> able to fall back to ioremap_cache(), but I include it for two reasons:
>>
>> 1/ ARM ioremap() will WARN if passed a pfn_valid() address.
>
> We don't support ioremap() on system RAM on ARM, period.  That's because
> ioremap() sets up page tables with incompatible attributes compared to
> those which are/will be setup by the lowmem/kmap* mappings, which leads
> to "unpredictable" behaviour.
>
> The only time RAM is mappable with ioremap() is if it's stolen from the
> kernel at boot time, which prevents the kernel from managing it and
> setting up memory-like mappings.
>

Ok, I read that as: "if someone calls memremap() on a 'System RAM'
address on ARM and we can't find the kernel linear address then just
pass it through to arch level remap code where it should rightly
WARN."  I'll reflow the patch with that change.
