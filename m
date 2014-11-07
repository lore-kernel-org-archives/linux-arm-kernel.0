From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Nov 2014 12:06:02 +0100
Subject: [GIT PULL] arm64: UEFI updates for 3.19
In-Reply-To: <1415357313.14686.115.camel@mfleming-mobl1.ger.corp.intel.com>
References: <CAKv+Gu8LEFvdu99vCHbHGPmGLpHWdT+Wb2DECzBEEg8g_yynvg@mail.gmail.com>
 <CAKv+Gu8bpgGWRbgdGYHSy515LOXapCm4stv5xJo_tNNhahcTYw@mail.gmail.com>
 <20141107100434.GA32336@arm.com>
 <CAKv+Gu9Hf2ATGxVbukxyqihChvc9TDvkejPq6KGkvFdJBPT5LA@mail.gmail.com>
 <1415357313.14686.115.camel@mfleming-mobl1.ger.corp.intel.com>
Message-ID: <CAKv+Gu9woybrvA0vikmcOeyVs0xTsAwBVu1=QsvaM9_Eb0pUEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2014 11:48, Matt Fleming <matt.fleming@intel.com> wrote:
> On Fri, 2014-11-07 at 11:29 +0100, Ard Biesheuvel wrote:
>>
>> I have confirmation from Matt and another Intel engineer that adding a
>> (arguably redundant) 'u32' cast solves the issue.
>
> I think we need to get a better handle on this.
>
> It is completely surprising to me that type promotion from u32 to u64
> goes through sign extension.
>
> And by "surprising" I mean, it sounds wrong.
>
> Ard, if you could throw me a unified diff of objdump -dr vmlinux, with
> and without the u32 cast, I'll take a look at figuring out what's
> happening.
>

With my compiler

gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu9)

the objdump of drivers/firmware/dmi_scan.o is identical with and
without the 'u32' cast.

If I look at the original code:

dmi_base = (buf[11] << 24) | (buf[10] << 16) | (buf[9] << 8) | buf[8];

I see a 'cltq' instruction in the dump that disappears once I add the
'u32' cast (which is what we addressed by introducing the
get_unaligned_le32() in the 1st place)

So, I'd happily share more objdumps, but perhaps we should find out
first which compiler Yuanhan has been using?

-- 
Ard.
