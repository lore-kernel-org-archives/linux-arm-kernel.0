From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 14 Nov 2017 11:20:57 +0000
Subject: arm64 crashkernel fails to boot on acpi-only machines due to ACPI
 regions being no longer mapped as NOMAP
In-Reply-To: <20171113092730.GA29552@linaro.org>
References: <CACi5LpM_95ebYFguPTyjWk+qHT5rDJVXiYDkNWbszo6Zw41zRA@mail.gmail.com>
 <CACi5LpNV_E9pvhTwLcy6vtEj9qbL1ZEHe-5sv=iiW0k9JxPD1Q@mail.gmail.com>
 <20171113092730.GA29552@linaro.org>
Message-ID: <CAKv+Gu_eQ-s0J22tKeHKJme4qXcvxvDkS7vKrNW+o_XtMTkMhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2017 at 09:27, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Hi,
>
> On Fri, Nov 10, 2017 at 05:41:56PM +0530, Bhupesh Sharma wrote:
>> Resent with Akashi's correct email address.
>>
>> On Fri, Nov 10, 2017 at 5:39 PM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> > Hi Ard, Akashi
>> >
>> > I have met an issue on an arm64 board using the latest master branch from Linus.
>   (snip)
>> >
>> > 8. Also, I think now the crashkernel handling changed by
>> > e7cd190385d17790cc3eb3821b1094b00aacf325 (arm64: mark reserved
>> > memblock regions explicitly in iomem), needs to be changed to handle
>> > the change added by Ard to fix this issue on ACPI only machines.
>> >
>> > I have a dirty hack in place, but I would like to have your opinions
>> > about what can be a more concrete fix to this issue (as we mark these
>> > regions as System RAM now rather than NOMAP) and I don't have a DTB
>> > based machine to test on currently.
>
> I don't know much about acpi reclaim regions,
> can you please tell me how your change affects your panic case?
>

Does this help at all?

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7768423b39d3..61d867647cca 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -213,7 +213,7 @@ static void __init request_standard_resources(void)

        for_each_memblock(memory, region) {
                res = alloc_bootmem_low(sizeof(*res));
-               if (memblock_is_nomap(region)) {
+               if (memblock_is_nomap(region) || memblock_is_reserved(region)) {
                        res->name  = "reserved";
                        res->flags = IORESOURCE_MEM;
                } else {
