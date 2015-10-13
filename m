From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Oct 2015 20:22:50 +0100
Subject: [PATCH v1 0/2] arm64: runtime workaround for erratum #843419
In-Reply-To: <20151013151355.GQ21550@arm.com>
References: <1442590800-14645-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151013151355.GQ21550@arm.com>
Message-ID: <CAKv+Gu-i0j46L6dMMMtNG_7z1ufGd4bckKG9m8B1tV-Fv0rCdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2015 at 16:13, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Fri, Sep 18, 2015 at 04:39:58PM +0100, Ard Biesheuvel wrote:
>> This implements a workaround for the A53 erratum that may result in adrp
>> instructions to produce incorrect values if they appear in either of
>> the last two instruction slots of a 4 KB page.
>>
>> Instead of building modules using the large code model, this approach
>> uses veneers to call the adrp instructions at unaffected offsets, unless
>> they can be converted into adr instructions, which is even better (this
>> depends on whether the symbol is with 1 MB of the place)
>
> As discussed at Connect, we should evaluate the performance penalty of
> the existing workaround before making this more complicated. I tried to
> do that today by building xfs as a module, then copying an xfs disk
> image containing a git clone of the kernel into tmpfs, loop mounting
> that and md5summing all of the files.
>
> The performance eppears to be the same with and without the errata
> workaround enabled, but I wondered if you had a better idea for a test
> (short of writing a synthetic module)?
>

Good question. The AArch64 large model is essentially the 64-bit
equivalent of the pre-v7 AArch32 approach of adr instructions combined
with literal pools that are interspersed with the instructions in
.text. Even though movt/movw pairs carry absolute values in their
immediate fields (and thus can be used for any value and not just
nearby addresses), the use of v7 movt/movw pairs can be considered the
equivalent of the small model with its adrp/add pairs.

This means that any justification for preferring movt/movw over
literal pools should carry over to this case, and I'd be interested if
there is any knowledge internally at ARM regarding the use cases that
get a significant speedup. Obviously, workloads that are sensitive to
L1 efficiency are likely to be affected (since the literals go via the
D-cache) but I don't have any numbers to back up the claim that the
large model is slower in the real world.

-- 
Ard.
