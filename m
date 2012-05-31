From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jun 2012 00:04:35 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC721DD.5020905@gmail.com>
References: <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com> <20120531030016.GB29372@mbp>
 <4FC6E172.4080601@gmail.com>
 <20120531031941.GA29906@mbp> <4FC6E7CE.9090004@gmail.com>
 <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
 <4FC6FC38.8090904@gmail.com>
 <CAHkRjk4jJphxST86km4ybuVTGxAr-a=3Ag9cQpEysLYxBt-6WQ@mail.gmail.com>
 <4FC706DA.5040308@gmail.com> <20120531065603.GA2442@mbp>
 <4FC71C13.7090301@gmail.com> <4FC721DD.5020905@gmail.com>
Message-ID: <CAHkRjk7qL1zDO4WD_LPh5v+v4aiU9Z1wHgMF3v=ykVUwKuw+YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2012 15:46,  <snakky.zhang@gmail.com> wrote:
> On 2012?05?31? 15:21, bill4carson wrote:
>> On 2012?05?31? 14:56, Catalin Marinas wrote:
>>> On Thu, May 31, 2012 at 06:51:22AM +0100, bill4carson wrote:
>>>> On 2012?05?31? 13:19, Catalin Marinas wrote:
>>>>> On 31 May 2012 13:06, bill4carson<bill4carson@gmail.com> ? wrote:
>>>>>> On 2012?05?31? 11:58, Catalin Marinas wrote:
>>>>>>> I still didn't fully understand what the problem is. So, to make
>>>>>>> sure,
>>>>>>> if you run some applications from flash using a yaffs filesystem, you
>>>>>>> get random crashes. Is this correct? If yes, a solution is to
>>>>>>> actually
>>>>>>> call flush_dcache_page() on the CPU that does the page copying from
>>>>>>> flash into RAM, which could be the yaffs filesystem.
>>>>>>
>>>>>>
>>>>>> The story goes like this:
>>>>>> function "flush_dcache_page" should be global effective
>>>>>> but in ARMv6 MPCore, it was not, it was just local effective due
>>>>>> to hardware design.
>>>>>
>>>>>
>>>>> Yes, I know this.
>>>>
>>>>
>>>> Then, why not fix "flush_dcache_page" to make it globally effective?
>>>
>>>
>>> Performance?
>>>
>>> And it's also just ARM11MPCore microarchitecture specific.
>>>
> Yes, seems newer CPUs has no such limitation thus this function is global
> effective naturally. :-)
>
> And , I find Mips's c-r4k also has this issue but it use IPI to make it.
> Details in arch/mips/mm/c-r4k.c.

Rather than IPI we would better use the read-for-ownership trick like
in this patch to make flush_dcache_page global (no need for
write-for-ownership):

http://dchs.spinics.net/lists/arm-kernel/msg125075.html

(it may no longer apply, I haven't checked it for some time).

That's the first thing. Secondly you still need preemption disable so
that it is not preempted between RFO and the actual cache cleaning.

-- 
Catalin
