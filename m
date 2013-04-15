From: ccross@android.com (Colin Cross)
Date: Mon, 15 Apr 2013 15:21:14 -0700
Subject: [RFC PATCH 1/3] pstore-ram: use write-combine mappings
In-Reply-To: <51656992.60203@gmail.com>
References: <1365563297-12480-1-git-send-email-robherring2@gmail.com>
 <CAMbhsRSvQPbzJ7Nt=OSSYE_A1e+eaUjO7XY+qRppJ5_gfWmW4A@mail.gmail.com>
 <51656992.60203@gmail.com>
Message-ID: <CAMbhsRS1hnBRoomoiNijrXZB-938d2RSs1cu9EdSfmXD3xpSQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 6:30 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 04/09/2013 10:53 PM, Colin Cross wrote:
>> On Tue, Apr 9, 2013 at 8:08 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Atomic operations are undefined behavior on ARM for device or strongly
>>> ordered memory types. So use write-combine variants for mappings. This
>>> corresponds to normal, non-cacheable memory on ARM. For many other
>>> architectures, this change should not change the mapping type.
>>
>> This is going to make ramconsole less reliable.  A debugging printk
>> followed by a __raw_writel that causes an immediate hard crash is
>> likely to lose the last updates, including the most useful message, in
>> the write buffers.
>
> It would have to be a write that hangs the bus. In my experience with
> AXI, the bus doesn't actually hang until you hit max outstanding
> transactions.

I've seen many cases where a single write to device memory in an
unclocked slave will completely and instantly hang all cpus, and the
next write will never happen.

> I think exclusive stores will limit the buffering, but that is probably
> not architecturally guaranteed.
>
> I could put a wb() in at the end of persistent_ram_write.
>
>> Also, isn't this patch unnecessary after patch 3 in this set?
>
> It is still needed in the main memory case to be architecturally correct
> to avoid multiple mappings of different memory types and exclusive
> accesses to device memory. At least on an A9, it doesn't really seem to
> matter. I could remove this for the ioremap case.

According to my reading of the latest ARM ARM (Issue C, section
A3.5.7), and Catalin's excellent explanation
(http://lists.linaro.org/pipermail/linaro-dev/2012-February/010239.html),
it is no longer considered unpredictable to have both cached and
non-cached mappings to the same memory, as long as you use proper
cache maintenance between accessing the two mappings.

In pstore_ram the cached mapping will never be accessed (and we don't
care about speculative accesses), so no cache maintenance is
necessary.  I don't see any need for this patch, and I see plenty of
possible problems.
