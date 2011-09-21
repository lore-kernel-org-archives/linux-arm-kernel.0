From: sjg@chromium.org (Simon Glass)
Date: Wed, 21 Sep 2011 15:58:01 -0700
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <alpine.LFD.2.00.1109201546400.12663@xanadu.home>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919200317.GC16381@n2100.arm.linux.org.uk>
	<CAPnjgZ3+b=nhApZxV1aBGejxEr7MGN1e8neP-ychtVO2Ego2yQ@mail.gmail.com>
	<20110920075916.GD16381@n2100.arm.linux.org.uk>
	<CAPnjgZ2-Ttmoa8zwSVqL70vXDoJv=-Z2XyVBuTi-bm4-0c6E-Q@mail.gmail.com>
	<20110920185121.GA17169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109201546400.12663@xanadu.home>
Message-ID: <CAPnjgZ2N7prDoVWh9r2nDnwgezvn39d9XOE59VjYC7VcNn7y=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Sep 20, 2011 at 12:57 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 20 Sep 2011, Russell King - ARM Linux wrote:
>
>> On Tue, Sep 20, 2011 at 10:00:06AM -0700, Simon Glass wrote:
>> > Hmm even more out there, I wonder if we can modify the BUG macro to
>> > put the bug table entry into one of two separate depending on whether
>> > BUG is in an __exit function or not? Then at link time, either concat
>> > the two tables, or just ignore the exit one...
>>
>> That was the same thought for the SMP alternatives problem - I think
>> Nicolas proposed that there should be some way that the linker can
>> do sections based on the current section name. ?That'd allow us to
>> have .alt.smp.exit.text and __bug_table.exit.text etc.
>
> Initially that was proposed by Dave Martin, then I tried to push things
> ahead a bit in the Linaro toolchain work group.
>
> The thread with the latest exchanges can be viewed here:
> http://news.gmane.org/group/gmane.linux.linaro.toolchain/thread=1270

The thread is from July. Does that mean it is dead?

>
> In a nutshell, it seems that enhancing gas to support this isn't
> trivial, and we are asked how beneficial (i.e. how much smaller the
> kernel image would be if all those sections could actually be split and
> discarded at link time) this would be to justify the effort.

Well it's probably not a huge benefit in terms of kernel size. Exit
code tends to be relatively small, and many distributions use modules
extensively now anyway. But there is also the issue of the workarounds
in the lds file, and where this might lead in the years ahead.

Would it be easier / less intrusive to add a new .pushsubsection
directive which prepends the current section name to the name you give
it?

Regards,
Simon
>
>
> Nicolas
>
