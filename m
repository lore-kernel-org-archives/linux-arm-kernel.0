From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Thu, 19 Dec 2013 15:38:45 +0530
Subject: [PATCH v5 2/4] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <CALicx6towYZrV30yVUxzNzUY17H5PsebDm_vB7pUtXP5R-xUqQ@mail.gmail.com>
References: <1385793148-28979-1-git-send-email-vijay.kilari@gmail.com>
 <1385793148-28979-3-git-send-email-vijay.kilari@gmail.com>
 <20131203101637.GA7552@e106331-lin.cambridge.arm.com>
 <20131203112139.GC1169@mudshark.cambridge.arm.com>
 <20131203133843.GH1169@mudshark.cambridge.arm.com>
 <CALicx6towYZrV30yVUxzNzUY17H5PsebDm_vB7pUtXP5R-xUqQ@mail.gmail.com>
Message-ID: <CALicx6sLWpLXThbbKktFpEdHxwhCFqw4DJostuTWJ2WBhkZ96A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 11:29 AM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> On Tue, Dec 3, 2013 at 7:08 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Dec 03, 2013 at 11:21:39AM +0000, Will Deacon wrote:
>>> On Tue, Dec 03, 2013 at 10:16:37AM +0000, Mark Rutland wrote:
>>> > I think that there's a slight problem with this on BE systems.
>>>
>>> [...]
>>>
>>> > On Sat, Nov 30, 2013 at 06:32:26AM +0000, vijay.kilari at gmail.com wrote:
>>> > > +       { "pstate", 4, offsetof(struct pt_regs, pstate)},
>>> >
>>> > As pt_regs::pstate is a u64, we're only describing half of the field
>>> > here (to match GDB's expectations). While we happen to get the half
>>> > we're interested in on an LE system, on a BE system this will point at
>>> > the zeroed half.
>>>
>>> Yup, I think you're right. It's almost as if this hasn't been tested on a BE
>>> system.
>>>
>>> Given that a large proportion of this CC list *do* actually care about BE,
>>> I'd like to see a tested-by from one of them before this gets merged. I'm
>>> pretty sure GDB has a testsuite which might be of some use.
>>
>> Having said that, our ptrace interface (built around regsets) treats pstate
>> as 64-bit, so we should do the same thing for kgdb and let GDB work out
>> which bits it's interested in.
>>
>> So: make pstate 8 bytes and test/fix GDB to deal with that (like it should
>> do for userspace already).
>>
>
> I have tested with BE & LE. it works fine except displaying 'pstate' contents
> in BE is wrong
>
> If I change pstate offset as below, it works
>
> #ifdef __AARCH64EB__
>         { "pstate", 4, offsetof(struct pt_regs, pstate) + 4},
> #else
>         { "pstate", 4, offsetof(struct pt_regs, pstate)},
> #endif
>
> I am checking with tool chain guy to patch GDB to make pstate as 8 bytes.
> After that, I will re-send the patch series
>

    Thanks to Andrew, GDB tool was patched here to interpret pstate as 8 bytes
    https://sourceware.org/ml/gdb-patches/2013-12/msg00720.html

>> Will
