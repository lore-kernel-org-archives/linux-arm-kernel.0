From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Aug 2016 19:26:32 +0200
Subject: [PATCH] arm64: kernel: avoid literal load of virtual address with
 MMU off
In-Reply-To: <20160817171134.GF20762@e104818-lin.cambridge.arm.com>
References: <1471449281-10367-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160817171134.GF20762@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu8tdLPkaJs-rTjUA6VbfF8w=Bx_0nX4Jb5AL21fnTw9iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2016 at 19:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Aug 17, 2016 at 05:54:41PM +0200, Ard Biesheuvel wrote:
>> Literal loads of virtual addresses are subject to runtime relocation when
>> CONFIG_RELOCATABLE=y, and given that the relocation routines run with the
>> MMU and caches enabled, literal loads of relocated values performed with
>> the MMU off are not guaranteed to return the latest value unless the
>> memory covering the literal is cleaned to the PoC explicitly.
>>
>> So defer the literal load until after the MMU has been enabled, just like
>> we do for primary_switch() and secondary_switch() in head.S.
>
> I think for consistency with head.S the patch is fine but do we actually
> expect a literal pool value to be inconsistent between cache and PoC?

Yes. Any literals covered by R_AARCH64_ABS64 relocations at link time
will be covered by R_AARCH64_RELATIVE at runtime (when
CONFIG_RELOCATABLE=y). Since AArch64 uses the RELA format, the targets
of the relocations will contain zeroes before the relocation routine
runs, and no cache maintenance is performed. This means a relocatable
image requires runtime processing even if it is loaded unrandomised.

> Presumably, the first time the kernel image was loaded it had to be
> cleaned to PoC but after that we wouldn't expect modifications of the
> literal pool dataz
>
> --
> Catalin
