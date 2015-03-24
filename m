From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 16:41:32 +0100
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <alpine.LFD.2.11.1503241112420.27567@knanqh.ubzr>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <alpine.LFD.2.11.1503241112420.27567@knanqh.ubzr>
Message-ID: <CAKv+Gu8ejzFLt50-_XWALQFBENshfAL8SHf+WsfV03vyBsK5wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2015 at 16:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 24 Mar 2015, Ard Biesheuvel wrote:
>
>> On 24 March 2015 at 13:22, Dave Martin <Dave.Martin@arm.com> wrote:
>> > How many such veneers get added in the your kernel configuration, and
>> > how many are actually necessary (i.e., calls between MMU-off code and
>> > elsewhere)?
>> >
>>
>> Very few. In addition to the example (which will be addressed in
>> another way regardless) there are some resume functions that get
>> allocated in .data, and those would need it as well.
>
>
> What are they? I thought we removed all instances of those already.
>

It is cpu_resume() and then some mach specific sleep.S files that do a
relative branch to cpu_resume().
But it seems cpu_resume() could easily be moved to .text, it's just
one PC relative load that needs to be rewritten

>> I have also proposed b_far/bl_far macros that could be used there as
>> well.
>
> Could the automatic veneer insertion replace the unconditional
> b_far/bl_far usage?  The former would be preferable to the later.
>
>
> Nicolas
