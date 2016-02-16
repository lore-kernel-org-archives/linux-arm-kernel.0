From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Feb 2016 23:04:12 +0000
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <56C39538.6090009@linux.intel.com>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
 <20160216103104.GC14509@arm.com> <56C300AD.8070505@arm.com>
 <20160216122153.GD19413@e104818-lin.cambridge.arm.com>
 <20160216160055.GH14509@arm.com> <20160216170408.GL14509@arm.com>
 <CA+55aFw-86k4gY46Et=e02HQQSxjUK2Jfz0SJz8tWtk5P8YZFA@mail.gmail.com>
 <56C39538.6090009@linux.intel.com>
Message-ID: <20160216230409.GA24379@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 01:31:36PM -0800, Arjan van de Ven wrote:
> On 2/16/2016 10:50 AM, Linus Torvalds wrote:
> >On Tue, Feb 16, 2016 at 9:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> >>[replying to self and adding some x86 people]
> >>
> >>Background: Euntaik reports a problem where userspace has ended up with
> >>a memory page mapped adjacent to an MMIO page (e.g. from /dev/mem or a
> >>PCI memory bar from someplace in /sys). strncpy_from_user happens with
> >>the word-at-a-time implementation, and we end up reading into the MMIO
> >>page.
> 
> how does this work if the adjacent page is not accessible?

do_strncpy_from_user() assumes by default that it can read a word at a
time using get_user() but checks its return value in case it failed and
falls back to byte at a time. What happens on arm64 is that for
alignment faults we don't have a handler that would search the exception
table and run the get_user() fixup.

> isn't the general rule for such basic functions "don't touch memory
> unless you KNOW it is there"

Well, user access routines are in general safe with this via the
exception handling + fixup mechanism (which usually returns -EFAULT).
That's what do_strncpy_from_user() tries to do by optimising away the
boundary checks.

-- 
Catalin
