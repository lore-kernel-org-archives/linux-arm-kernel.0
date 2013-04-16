From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Apr 2013 07:58:27 -0500
Subject: [RFC PATCH 1/3] pstore-ram: use write-combine mappings
In-Reply-To: <20130416084418.GA30756@mudshark.cambridge.arm.com>
References: <1365563297-12480-1-git-send-email-robherring2@gmail.com>
 <CAMbhsRSvQPbzJ7Nt=OSSYE_A1e+eaUjO7XY+qRppJ5_gfWmW4A@mail.gmail.com>
 <51656992.60203@gmail.com>
 <CAMbhsRS1hnBRoomoiNijrXZB-938d2RSs1cu9EdSfmXD3xpSQg@mail.gmail.com>
 <516C9454.4060009@gmail.com>
 <CAMbhsRRT7tOBHppvjJEW5wRtVaUhwxr8=YQY=Sy0VAFeBg1JmQ@mail.gmail.com>
 <20130416084418.GA30756@mudshark.cambridge.arm.com>
Message-ID: <516D4AF3.5060205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 03:44 AM, Will Deacon wrote:
> On Tue, Apr 16, 2013 at 01:43:09AM +0100, Colin Cross wrote:
>> On Mon, Apr 15, 2013 at 4:59 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> Exclusive accesses still have further restrictions. From section 3.4.5:
>>>
>>> ? It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can be
>>> performed to a memory region
>>>    with the Device or Strongly-ordered memory attribute. Unless the
>>> implementation documentation explicitly
>>>   states that LDREX and STREX operations to a memory region with the
>>> Device or Strongly-ordered attribute are
>>>  permitted, the effect of such operations is UNPREDICTABLE.
>>>
>>>
>>> Given that it is implementation defined, I don't see how Linux can rely
>>> on that behavior.
>>
>> I see, the problem is that while noncached and writecombined appear to
>> be similar mappings, noncached is mapped in PRRR to strongly-ordered,
>> while writecombined is mapped to unbufferable normal memory.
>>
>> I think adding a wmb() to persistent_ram_write is going to be
>> expensive on cpus with outer caches like the L2X0, where wmb() will
>> result in a spinlock.  Is there a real SoC where this doesn't work?
> 
> A real SoC where exclusives don't work to memory not mapped as normal? Take
> your pick...

This patch doesn't actually fix problems for me. Exclusives to DDR work
for any memory type for me as the DDR controller has an exclusive
monitor. It takes write-thru cache mapping to get internal RAM to work.

Rob
