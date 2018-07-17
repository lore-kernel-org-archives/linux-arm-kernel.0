From: hari.vyas@broadcom.com (Hari Vyas)
Date: Tue, 17 Jul 2018 19:10:25 +0530
Subject: [PATCH] arm64: fix kernel panic on serror exception caused by
 user process
In-Reply-To: <20180717114815.5a3rbcznfzvi2xh6@lakrids.cambridge.arm.com>
References: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
 <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
 <20180717100628.s5emikyc6orira2q@lakrids.cambridge.arm.com>
 <CAM5rFu_trZpt20H2GAUq8GYTOuJMSmEknsQaEkPkDwFHPVDPeA@mail.gmail.com>
 <20180717114815.5a3rbcznfzvi2xh6@lakrids.cambridge.arm.com>
Message-ID: <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 5:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jul 17, 2018 at 05:02:04PM +0530, Hari Vyas wrote:
>> On Tue, Jul 17, 2018 at 3:36 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Jul 17, 2018 at 03:01:21PM +0530, Hari Vyas wrote:
>> >> On executing simple user level "devmem 0x0" command, kernel panics.
>> >> As 0x0 address is mostly not matched to any valid memory so exception
>> >> is expected and raised which results in unconditional kernel panic
>> >> by serror handler.
>> >
>> > Having access to /dev/mem means that userspace can bring down the system
>> > in any number of ways.
>> >
>> > Why did userspace do this, and why do you think this shouldn't be fatal?
>> >
>> I understand,  here /dev/mem is accessible but access is issued by
>> user application devmem (which user can even do by mistake or
>> deliberately) and
>> don't think system/kernel should be  penalized for such type of minor mistake.
>
> Sorry, but this is simply a risk of exposing /dev/mem to userspace.
>
> The user could also use devmem to poke devices in ways which could
> permanently damage them. If you cannot trust the user to not do such
> things, you must not give them access to /dev/mem.
>
Okay. Don't think it is a question of trust. If access happens from
kernel mode, I understand but If user mode initiated
access(from devmem(which is just an example) or any other application)
into outside or invalid region of system
address brings complete kernel down, at least I will be surprised.
If all other also think kernel panic okay in this case, then no
further action is required from my side.
>> >> This is happening after newly introduced serror handling framework
>> >> change which panics kernel on any any serror without checking
>> >> processor mode.`
>> >
>> > This is the expected behaviour. The processor mode is not relevant,
>> > because Serror is asynchronous -- so we cannot attribute it to userspace
>> > instructions.
>> >
>> We recently moved to 4.17 version but if my understanding is correct
>> till  Kernel 4.14, same access was resulting in bad mode and due to
>> user process initiation,
>> kernel was throwing exception and devmem was killed but  not
>> resulting in kernel panic.
>
> ... indeed, and this was a bug, which was addressed by ensuring that
> an uncontainable SError was always fatal.
>
If I check commit message for do_serror(), it says some hooks can be
added to avoid panic.
---
commit a92d4d1454ab8b43b80b89fa31fcedb8821f8164
Author: Xie XiuQi <xiexiuqi@huawei.com>

Future patches may change do_serror() to return if the SError
Interrupt was notification of a
corrected error
 --

>> >> Kernel panic is fixed by checking processor mode in serror handler.
>> >> On kernel mode, normal kernel panic action is taken and system halts.
>> >> On user mode, only user process is killed and further panic action is
>> >> not initiated.
>> >
>> > This is not safe.
>> >
>> > For example, an Serror could result from the kernel page tables being
>> > programmed to point at device memory. A TLB walk for TTBR1 made while
>> > userspace was executing could result in an SError, and killing userspace
>> > alone is insufficient to contain the error.
>> >
>> Yes. Serror exception just gives indication and needs to be further
>> analyzed but here case is direct and known and can be handled.
>
> As abovem, the kernel does not have enough information to determine the
> cause. It cannot distinguish your case from the one I described, and the
> only sane thing to do in this case is to panic().
>
Believe notification and if possible corrective action is important and.
As stated, if all also think that kernel should panic in this situation,
issue can be closed. No issue from my end.

Regards,
hari
> Thanks,
> Mark.
