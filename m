From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 17:24:11 +0100
Subject: [PATCH] arm*: efi: drop permanent mapping of the UEFI System table
In-Reply-To: <20160222160910.GK3435@leverpostej>
References: <1456153179-27214-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160222154314.GJ3435@leverpostej>
 <CAKv+Gu_pnjL557dE1xez_y2tESOjZj9_2XEbNtm_b4yAA-WdYg@mail.gmail.com>
 <20160222160910.GK3435@leverpostej>
Message-ID: <CAKv+Gu-S1hMuLgE+bumnXVC1QpHYu7aWUzHtzbDy3HkUS_WS6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 17:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Feb 22, 2016 at 04:56:57PM +0100, Ard Biesheuvel wrote:
>> On 22 February 2016 at 16:43, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Mon, Feb 22, 2016 at 03:59:39PM +0100, Ard Biesheuvel wrote:
>> >> The permanent, writable mapping of the UEFI System table is only
>> >> referenced during invocations of UEFI Runtime Services, at which time
>> >> the UEFI virtual mapping is available, which also covers the system
>> >> table (since the runtime services themselves need access to it)
>> >
>> > I'm not sure it's strictly true that the runtime services themselves
>> > need access to the system table. Why would that be necessary? Are
>> > runtime services mandated to indirect calls via the system table?
>> >
>>
>> They don't need access per se, but they are allowed to reference it,
>> and so the memory remapping layer must make it accessible after
>> SetVirtualAddressMap(). The spec lists explicitly which fields are
>> still valid after ExitBootServices()
>
> I was language-lawyering ;)
>
> I appreciate that they _can_, I just didn't think it was true that they
> _must_ (i.e. that they always "need to access it"). Per the below that's
> likely moot.
>

Runtime services drivers must call ConvertPointer() to translate the
pointer variables in their global state to their virtual equivalents.
So unless a Runtime driver does not have such state at all, it needs
access to the runtime services table, which is usually retrieved
through the system table. So yes, you're right. And yes, it's moot :-)

>> SetVirtualAddressMap() is a runtime service, and one of the things it
>> does is update the pointers in the system table, hence it must be
>> located in RuntimeService memory, because anything else may be gone by
>> this time.
>
> Good point. That does imply that it must be in EfiRuntimeServices*
> memory.
>
>> > From the spec, I couldn't find a mandate that the system table (nor the
>> > runtime services table) were in a region of EfiRuntimeServicesData
>> > memory. I suspect I'm looking in the wrong place...
>>
>> We should clarify it if it is not clear (or if I turn out to be wrong)
>
> I'm hoping that I've simply missed something. Perhaps the implication
> above was intentional, albeit rather opaque.
>
> Otherwise, I certainly agree a clarification would be a good thing!
>
> Mark.
