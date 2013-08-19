From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Aug 2013 14:36:24 -0500
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <52122FF5.7000802@samsung.com>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
 <CAL_JsqJLv-dUb=64vP+OeP8=Usw7=r6RKqJAXCSPryCFGZ89_w@mail.gmail.com>
 <52089E23.1090406@samsung.com>
 <CAL_JsqJR_mdCiA8knd3COuZ=DcpuAtdzsCy8tAPMSMq67m=SAw@mail.gmail.com>
 <52122FF5.7000802@samsung.com>
Message-ID: <CAL_JsqLGFkU-5vmsiQ8Z9UfZk5SwHf0VY_dc25DkjO0BGuA24A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 9:47 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
>
> On 8/13/2013 3:00 PM, Rob Herring wrote:
>>
>> On Mon, Aug 12, 2013 at 3:34 AM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>> > Hello,
>> >
>> >
>> > On 8/10/2013 7:33 PM, Rob Herring wrote:

[snip]

>> > early_init_dt_scan_memory() is also called from of_scan_flat_dt() and
>> > it also implements similar state machine to parse fdt. The only
>> > difference is the fact that "memory" is a direct child of root node,
>> > so the state machine is much simpler (there is no need to parse
>> > /memory/reserved-memory path).
>> >
>>
>> If you have already found the memory node, then why find it again? I
>> don't think the existing scan functions handle anything but top-level
>> nodes very well. So doing something like this from
>> early_init_dt_scan_memory() is what I was thinking. It is a very rough
>> sketch:
>>
>> // find the reserved-memory node
>> for (ndepth = 0, off = fdt_next_node(blob, parent_offset, &ndepth);
>>      (off >= 0) && (ndepth > 0);
>>      off = fdt_next_node(blob, off, &ndepth)) {
>>      if (ndepth == 1) {
>>          name = fdt_get_name(blob, off, 0), off);
>>          if (strcmp(name, "reserved-memory") == 0) {
>>               parent_offset = off;
>>               break; // found
>>      }
>> }
>>
>> // find the child nodes
>> for (ndepth = 0, off = fdt_next_node(blob, parent_offset, &ndepth);
>>      (off >= 0) && (ndepth == 1);
>>      off = fdt_next_node(blob, off, &ndepth)) {
>>      // now handle each child
>> }
>>
>> These could probably be further refined with some loop iterator macros.
>
>
> The above code looks pretty nice, but there are some problems with it:
>
> 1. Although it would look nice to call it from early_init_dt_scan_memory()
> it won't be possible, because that time it is too early. memblock structures
> are initialized after a call to early_init_dt_scan_memory() and until that
> no changes to memory layout are easily possible.

Okay. So the reserved areas have to be setup after memblock_add is
called. It seems that what exactly early_init_dt_add_memory_arch does
varies by arch. For example, arm64 directly does a memblock_add call
and would probably work as I suggested. The arm code just puts the
information in an intermediate arch specific struct until later. There
is a lot of room for clean-up in the early DT code to reduce the
amount of arch code.

> 2. Currently there are no fdt parsing functions in the kernel. I've tried
> to split of_scan_flat_dt() into fdt_next_node() + fdt_get_name() and use
> them both in of_scan_flat_dt() and above reserved memory parsing functions.
> In the end I got quite a lot of code, which is still quite hard to follow.
>
> Because of the above I decided to resurrect of_scan_flat_dt_by_path()
> function from the previous version and use #size-cells/#address-cells
> attributes from root node what in the end simplified reserved memory
> parsing function. I hope that it can be accepted after such changes
> without introducing a burden caused by the whole infrastructure for
> manual parsing fdt.

This all looks fine at first glance.

Rob
