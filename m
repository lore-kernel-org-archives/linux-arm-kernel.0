From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 Oct 2018 14:09:49 +0200
Subject: [PATCH 2/2] ARM: copypage: do not use naked functions
In-Reply-To: <20181016083341.GE30658@n2100.armlinux.org.uk>
References: <20181015222621.14673-1-stefan@agner.ch>
 <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr>
 <20181015224152.GA30658@n2100.armlinux.org.uk>
 <4e598f27e3dc7ae9fd96a6cf097d1154@agner.ch>
 <nycvar.YSQ.7.76.1810151908450.1498@knanqh.ubzr>
 <20181016083341.GE30658@n2100.armlinux.org.uk>
Message-ID: <473d9036247c467d1d3c0573ebad09c1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2018 10:33, Russell King - ARM Linux wrote:
> On Mon, Oct 15, 2018 at 07:27:43PM -0400, Nicolas Pitre wrote:
>> It's hard to see what that commit was actually fixing, but the operands
>> usage is wrong as explained already. Maybe the generated code has been
>> OK for all those years but that is due to luck rather than correctness.
> ...
>> No idea. Maybe Russell remembers?
>> Maybe digging into the mailing list archive might tell.
> 
> I found this as a reply to the patch by Mikael Pettersson:
> 
> I've tested and verified that this bit enables a gcc-4.5 compiled kernel
> to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
> With neither or only one of the patches applied, the kernel oopses hard
> in copy_user_page() as it tries to start /sbin/init.
> ...
> - the asm() bodies of these __naked functions have inadequate input
>   parameter constraints, in particular they fail to declare any
>   dependencies on the functions' formal parameters; gcc-4.5 sees this
>   and skips the parameter setup before calling these functions, causing
>   runtime crashes; Khem's patch (this one) fixes that
>   (copypage-xscale.c already had correct asm() constraints so it works
>   with only the __naked fix, these other copypage-*.c files need both
>   patches to work)
> 
> So, while wrong to the GCC manual, it's fixing a bug that is present
> with gcc-4.5 and who-knows what other GCC versions.  Reverting the
> commit has the chance to cause regressions with GCC.

The build system requires at least GCC 4.6 currently, so we do not have
to deal with 4.5.

> 
> It looks like any change here needs to be validated on a range of
> GCC versions, because there are versions of GCC known not to follow
> it's manual!

The commit message as well as the above message sounds more like it was
a newly introduced behavior in 4.5. I would suggest to at least check
4.6 to make sure it has been corrected.

--
Stefan
