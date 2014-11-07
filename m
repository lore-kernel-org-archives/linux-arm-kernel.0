From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Nov 2014 11:29:36 +0100
Subject: [GIT PULL] arm64: UEFI updates for 3.19
In-Reply-To: <20141107100434.GA32336@arm.com>
References: <CAKv+Gu8LEFvdu99vCHbHGPmGLpHWdT+Wb2DECzBEEg8g_yynvg@mail.gmail.com>
 <CAKv+Gu8bpgGWRbgdGYHSy515LOXapCm4stv5xJo_tNNhahcTYw@mail.gmail.com>
 <20141107100434.GA32336@arm.com>
Message-ID: <CAKv+Gu9Hf2ATGxVbukxyqihChvc9TDvkejPq6KGkvFdJBPT5LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2014 11:04, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Nov 07, 2014 at 07:34:12AM +0000, Ard Biesheuvel wrote:
>> You are not going to believe this, but I received a report about boot
>> failures on legacy (non-EFI) x86 using the SMBIOS 3.0 code, so could
>> you please hold off on pulling this until we know what is going on
>> there? This does not affect ARM at all, but I may need to update patch
>> 'dmi: add support for SMBIOS 3.0 64-bit entry point' to drop the
>> SMBIOS 3.0 check in the non-EFI code path.
>
> D'oh, I put this into -next last night (perhaps that's where the report came
> from), so I'll recreate that branch now without your series.
>

Ah, yes, that is probably where they found it. Note that this is a
different patch than the one that has been causing us (me) grief
before, but apparently it now has infected other patches as well :-)

> Please send another pull request without the SMBIOS patch, then we can
> perhaps add that on top later on (that way it's easier to revert in the
> future :).
>

In the mean time, we have pinpointed this. It turns out that on x86,
the RHS of this expression

u64 dmi_base = get_unaligned_le32(buf + 8);

is promoted to a signed type before being assigned, even if
get_unaligned_le32() returns u32.
On ARM, it works as expected.

I have confirmation from Matt and another Intel engineer that adding a
(arguably redundant) 'u32' cast solves the issue.

Should I include the corrected patch and send an updated pull request?
Or if you and Matt prefer so, we could take this patch and the
preceding one (efi: dmi: add support for SMBIOS 3.0 UEFI configuration
table) through Matt's tree as well. There are no interdependencies
between those two and the other patches.

-- 
Ard.
