From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Nov 2014 13:25:09 +0100
Subject: [GIT PULL] arm64: UEFI updates for 3.19
In-Reply-To: <20141107112407.GH24745@yliu-dev.sh.intel.com>
References: <CAKv+Gu8LEFvdu99vCHbHGPmGLpHWdT+Wb2DECzBEEg8g_yynvg@mail.gmail.com>
 <CAKv+Gu8bpgGWRbgdGYHSy515LOXapCm4stv5xJo_tNNhahcTYw@mail.gmail.com>
 <20141107100434.GA32336@arm.com>
 <CAKv+Gu9Hf2ATGxVbukxyqihChvc9TDvkejPq6KGkvFdJBPT5LA@mail.gmail.com>
 <1415357313.14686.115.camel@mfleming-mobl1.ger.corp.intel.com>
 <CAKv+Gu9woybrvA0vikmcOeyVs0xTsAwBVu1=QsvaM9_Eb0pUEQ@mail.gmail.com>
 <20141107112407.GH24745@yliu-dev.sh.intel.com>
Message-ID: <CAKv+Gu9E9b6zMnXh4On7_0GgZ-gFyx0Gitb0Jm__FYAqRz4VmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2014 12:24, Yuanhan Liu <yuanhan.liu@linux.intel.com> wrote:
> On Fri, Nov 07, 2014 at 12:06:02PM +0100, Ard Biesheuvel wrote:
>> On 7 November 2014 11:48, Matt Fleming <matt.fleming@intel.com> wrote:
>> > On Fri, 2014-11-07 at 11:29 +0100, Ard Biesheuvel wrote:
>> >>
>> >> I have confirmation from Matt and another Intel engineer that adding a
>> >> (arguably redundant) 'u32' cast solves the issue.
>> >
>> > I think we need to get a better handle on this.
>> >
>> > It is completely surprising to me that type promotion from u32 to u64
>> > goes through sign extension.
>> >
>> > And by "surprising" I mean, it sounds wrong.
>> >
>> > Ard, if you could throw me a unified diff of objdump -dr vmlinux, with
>> > and without the u32 cast, I'll take a look at figuring out what's
>> > happening.
>> >
>>
>> With my compiler
>>
>> gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu9)
>>
>> the objdump of drivers/firmware/dmi_scan.o is identical with and
>> without the 'u32' cast.
>>
>> If I look at the original code:
>>
>> dmi_base = (buf[11] << 24) | (buf[10] << 16) | (buf[9] << 8) | buf[8];
>>
>> I see a 'cltq' instruction in the dump that disappears once I add the
>> 'u32' cast (which is what we addressed by introducing the
>> get_unaligned_le32() in the 1st place)
>
> Yes, that's another mistake I made :(
>
> The story is that LKP reports this issue with an old commit:
> aacdce6e880894acb57d71dcb2e3fc61b4ed4e96("dmi: add support for SMBIOS
> 3.0 64-bit entry point"), where still use the original code you showed
> above:
>
>                 dmi_num = (buf[13] << 8) | buf[12];
>                 dmi_len = (buf[7] << 8) | buf[6];
>                 dmi_base = (buf[11] << 24) | (buf[10] << 16) |
>                         (buf[9] << 8) | buf[8];
>
> I didn't except there are two version, thus when it failed to apply the
> debug patch you gave me, I just thought you wrote the debug patch on top
> your branch, and I applied on based of the first bad commit("aacdce6e").
>
> Hence I fixed it manually and got your debug patch applied, but still
> with those original code, hence it never works.
>
> And then you ask me to do the (u32) cast, which is based on
> get_unaligned_le32(), I then changed the original code to
> get_unaligned_le16/32(), and did the cast, which works as expected, and
> I then thought the cast did work. And actually, it's the change to
> get_unaligned_le16/32() works: I double confirmed it this time, and
> that's why I didn't see such panic with your updated commits from
> efi-for-arm64(the code we used bisect is from efi-for-3.19).
>
>
> So, it's totally kind of stupid mistakes I made. Very sorry for the
> noise and for taking you guys time!
>

No worries. At the very least, we are a bit more confident now than
before that the code is fine.

Thanks,
Ard.
