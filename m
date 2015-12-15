From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 15 Dec 2015 08:34:58 -0800
Subject: [for-4.4-rc6 PATCH] scatterlist: fix sg_phys() masking
In-Reply-To: <20151215103524.GH18805@8bytes.org>
References: <20151214231739.10377.11843.stgit@dwillia2-desk3.jf.intel.com>
 <20151215103524.GH18805@8bytes.org>
Message-ID: <CAPcyv4j26tOvPPAw_N7N_OoRBE4=6tM6N4QcNZziGMuJWBdbDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 2:35 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Mon, Dec 14, 2015 at 03:17:39PM -0800, Dan Williams wrote:
>> commit db0fa0cb0157 "scatterlist: use sg_phys()" did replacements of the
>> form:
>>
>>     phys_addr_t phys = page_to_phys(sg_page(s));
>>     phys_addr_t phys = sg_phys(s) & PAGE_MASK;
>>
>> However, this breaks platforms where sizeof(phys_addr_t) >
>> sizeof(unsigned long).  Since PAGE_MASK is an unsigned long this
>> inadvertently masks the high bits returned by sg_phys().  Convert to
>> PHYSICAL_PAGE_MASK in these cases which will do the proper sign
>> extension.
>>
>> As caught by the kbuild robot, a generic fallback definition of
>> PHYSICAL_PAGE_MASK is needed for several archs.
>
> It is getting late in the cycle already, isn't it better to revert
> db0fa0cb0157 for now and queue a fixed version for the next round? Then
> you can also replace all the 'sg_phys() & MASK' parts by a new sg helper
> which just returns the page-aligned physical address.
> This would not only be cleaner than your original patch but also leaves
> just one place where you need to fix things if necessary.
>

Sounds good to me.  Thanks, Joerg.
