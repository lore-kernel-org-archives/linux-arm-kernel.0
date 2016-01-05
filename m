From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Jan 2016 12:21:51 +0000
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c:
 calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160105114549.GX16023@sirena.org.uk>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
 <20160104235512.GW16023@sirena.org.uk>
 <20160104163528.be56a4b1.akpm@linux-foundation.org>
 <20160105114549.GX16023@sirena.org.uk>
Message-ID: <568BB55F.2020709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/01/16 11:45, Mark Brown wrote:
> On Mon, Jan 04, 2016 at 04:35:28PM -0800, Andrew Morton wrote:
>> On Mon, 4 Jan 2016 23:55:12 +0000 Mark Brown <broonie@kernel.org> wrote:
>>> On Mon, Jan 04, 2016 at 03:09:46PM -0800, Andrew Morton wrote:
>
>>>> Thanks.  That patch has rather a blooper if
>>>> CONFIG_HAVE_MEMBLOCK_NODE_MAP=n.  Is that the case in your testing?
>
>>> Seems to be what's making a difference from a quick run through, yes.
>
>> OK, thanks.
>
> Seems like I was mistaken here somehow or there's some other problem -
> I've kicked off another bisect for today's -next:
>
>     https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/137/console
>
> and will follow up with any results.
>

With both patches applied(one already in today's -next), I am able to
boot on ARM64 platform but I get huge load(for each pfn) of below warning:

-->8

BUG: Bad page state in process swapper  pfn:900000
page:ffffffbde4000000 count:0 mapcount:1 mapping: (null) index:0x0
flags: 0x0()
page dumped because: nonzero mapcount
Modules linked in:
Hardware name: ARM Juno development board (r0) (DT)
Call trace:
[<ffffffc000089830>] dump_backtrace+0x0/0x180
[<ffffffc0000899c4>] show_stack+0x14/0x20
[<ffffffc000335008>] dump_stack+0x90/0xc8
[<ffffffc0001531f8>] bad_page+0xd8/0x138
[<ffffffc000153470>] free_pages_prepare+0x218/0x290
[<ffffffc000154d4c>] __free_pages_ok+0x1c/0xb8
[<ffffffc000155638>] __free_pages+0x30/0x50
[<ffffffc00092fa9c>] __free_pages_bootmem+0xa0/0xa8
[<ffffffc0009321d0>] free_all_bootmem+0x11c/0x184
[<ffffffc000925264>] mem_init+0x48/0x1b4
[<ffffffc0009217e0>] start_kernel+0x224/0x3b4
[<0000000080663000>] 0x80663000
Disabling lock debugging due to kernel taint

-- 
Regards,
Sudeep
