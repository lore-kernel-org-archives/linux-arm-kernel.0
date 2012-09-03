From: robherring2@gmail.com (Rob Herring)
Date: Mon, 03 Sep 2012 16:58:36 -0500
Subject: [PATCH v2] ARM: initial multiplatform support
In-Reply-To: <201209031634.19301.arnd@arndb.de>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346436765-9709-1-git-send-email-robherring2@gmail.com>
 <201209031634.19301.arnd@arndb.de>
Message-ID: <5045280C.6060103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 11:34 AM, Arnd Bergmann wrote:
> On Friday 31 August 2012, Rob Herring wrote:
>> [Rob Herring]: Rebased to not be dependent on the mass mach header rename.
>> As a result, omap2plus, imx, mxs and ux500 are not converted. Highbank,
>> picoxcell, mvebu, socfpga, and vexpress are converted.
>>
>> v2: This version avoids the kconfig symbol name changes and simply moves
>> multi-platform enabled platform kconfig option out of the choice option
>> and into the platform's mach directory. A separate series fixes DEBUG_LL
>> for multi-platform.
> 
> This looks like a nice start to play with multiplatform, and I guess it
> would be nice to merge it for v3.7.
> 
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -254,27 +254,9 @@ config MMU
>>  #
>>  choice
>>         prompt "ARM system type"
>> +       depends on !ARCH_MULTIPLATFORM
>>         default ARCH_VERSATILE
> 
> Why did you move ARCH_MULTIPLATFORM out of the "choice" statement?
> If we leave it in there, and make it the default, then we don't
> even have to change the defconfigs any more (except the versatile
> one, which is no longer the default), which I think is quite clever
> and helps git-bisecting across this commit.

We don't have to change and of the defconfigs or .config in this patch.

Bisecting the converted platforms is a problem I guess. It can be worked
around by setting ARCH_MULTIPLATFORM before configuring. I'm not
convinced fixing it is worth the complexity added to kconfig.

> I also still think that we should allow platforms to be part of
> both multi-platform and single-platform builds, for cases it helps
> with.
> 
> For instance, we could enable one platform to be used in
> multiplatform kernels with the subset of its board files and
> device drivers that are possible, while leaving board files
> that cannot work with sparse-irq and drivers that rely on
> platform specific headers as "depends on !ARCH_MULTIPLATFORM".

Individual platforms can still do that. I just happened to convert all
platforms which have no need to be in both. While you can do that, I
don't think we should encourage it. I don't think we want to see
platforms partially converted to common clk or sparse irq. The latter is
certainly not hard to do.

Rob
