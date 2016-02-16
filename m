From: arjan@linux.intel.com (Arjan van de Ven)
Date: Tue, 16 Feb 2016 13:31:36 -0800
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <CA+55aFw-86k4gY46Et=e02HQQSxjUK2Jfz0SJz8tWtk5P8YZFA@mail.gmail.com>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
 <20160216103104.GC14509@arm.com> <56C300AD.8070505@arm.com>
 <20160216122153.GD19413@e104818-lin.cambridge.arm.com>
 <20160216160055.GH14509@arm.com> <20160216170408.GL14509@arm.com>
 <CA+55aFw-86k4gY46Et=e02HQQSxjUK2Jfz0SJz8tWtk5P8YZFA@mail.gmail.com>
Message-ID: <56C39538.6090009@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/16/2016 10:50 AM, Linus Torvalds wrote:
> On Tue, Feb 16, 2016 at 9:04 AM, Will Deacon <will.deacon@arm.com> wrote:
>> [replying to self and adding some x86 people]
>>
>> Background: Euntaik reports a problem where userspace has ended up with
>> a memory page mapped adjacent to an MMIO page (e.g. from /dev/mem or a
>> PCI memory bar from someplace in /sys). strncpy_from_user happens with
>> the word-at-a-time implementation, and we end up reading into the MMIO
>> page.

how does this work if the adjacent page is not accessible?
or has some other magic fault handler, or is on an NFS filesystem where
the server is rebooting?

isn't the general rule for such basic functions "don't touch memory unless you KNOW it is there"



> Of course, no actual real program will do that for mixing MMIO and
> non-MMIO, and so we might obviously add code to always add a guard
> page for the normal case when a specific address isn't asked for. So
> as a heuristic to make sure it doesn't happen by mistake it possibly
> makes sense.

but what happens to the read if the page isn't present?
or is execute-only or .. or ..
