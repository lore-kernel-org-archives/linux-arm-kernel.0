From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 16:51:07 +0100
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <alpine.LFD.2.11.1503241125450.27567@knanqh.ubzr>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <alpine.LFD.2.11.1503241112420.27567@knanqh.ubzr>
 <CAKv+Gu_kLtCqM1FtFRQdyBkzT3Rdqx90zcPFdtovnGOFf=d+3g@mail.gmail.com>
 <alpine.LFD.2.11.1503241125450.27567@knanqh.ubzr>
Message-ID: <CAKv+Gu9pNZFjrRbRkK=Yp5RkV6GCM2NmVWzXRYmqmS97q+e0NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2015 at 16:49, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 24 Mar 2015, Ard Biesheuvel wrote:
>
>> On 24 March 2015 at 16:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > On Tue, 24 Mar 2015, Ard Biesheuvel wrote:
>> >
>> >> On 24 March 2015 at 13:22, Dave Martin <Dave.Martin@arm.com> wrote:
>> >> > How many such veneers get added in the your kernel configuration, and
>> >> > how many are actually necessary (i.e., calls between MMU-off code and
>> >> > elsewhere)?
>> >> >
>> >>
>> >> Very few. In addition to the example (which will be addressed in
>> >> another way regardless) there are some resume functions that get
>> >> allocated in .data, and those would need it as well.
>> >
>> >
>> > What are they? I thought we removed all instances of those already.
>> >
>> >> I have also proposed b_far/bl_far macros that could be used there as
>> >> well.
>> >
>> > Could the automatic veneer insertion replace the unconditional
>> > b_far/bl_far usage?  The former would be preferable to the later.
>> >
>>
>> Agreed. I am not entirely sure why those functions don't get a veneer.
>> Perhaps simply because .data is not annotated as executable?
>>
>> Frankly, I don't really understand the purpose of putting those in
>> .data in the first place. but if they need to remain there, I can try
>> to figure out how to get the linker to emit veneers for those as well.
>
> I'm guilty of introducing the first instance of code in .data back in
> ... hrm ... 1998 or so.  I wasn't as experienced in ARM assembly back
> then and the resume code needed to fetch its context data while the MMU
> was off. So the easy way was simply to put the code next to the data
> block and get its address using adr.
>
> These days we know how to write code to obtain position independent
> memory addresses at run time. One such example is commit b4e6153704
> where the bl relocation also exceeded its range.  But I thought I had
> converted all those instances already.
>

Yes, there are still some instances left of that, including the core
cpu_resume() itself.
(and they all copy the same comment :-))
