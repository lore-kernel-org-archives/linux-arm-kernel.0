From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Aug 2013 15:37:36 +0100
Subject: [Patch v3 3/3] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <5220AD5B.2090300@arm.com>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-4-git-send-email-punit.agrawal@arm.com>
 <20130830112448.GC12160@mudshark.cambridge.arm.com>
 <5220AD5B.2090300@arm.com>
Message-ID: <20130830143736.GI12160@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 03:34:03PM +0100, Punit Agrawal wrote:
> On 30/08/13 12:24, Will Deacon wrote:
> > cci_probed is marked as __init, so you have a section mismatch here:
> >
> >    arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
> >    WARNING: drivers/bus/built-in.o(.text+0xb48): Section mismatch in reference from the function cci_platform_probe() to the function .init.text:cci_probed()
> >    The function cci_platform_probe() references
> >    the function __init cci_probed().
> >    This is often because cci_platform_probe lacks a __init
> >    annotation or the annotation of cci_probed is wrong.
> >
> 
> Good catch. Missed this one.
> 
> > Unfortunately, resolving this requires removing a bunch of annotations (see
> > patch below), so you might want to reconsider how the probe checking is
> > handled (by moving the cci_init_status check out of cci_init).
> >
> 
> In cci_platform_probe, cci_probed is called to check whether the CCI has 
> been initialised, and also to initialise it if required.
> 
> Even if the check for cci_init_status is moved out, I'll still need to 
> call cci_init which will again cause a section mis-match.

Ok.

> I think removing the annotations is the way to go. Is it OK to fold your 
> patch into the CCI PMU patch, or you prefer to keep it separate?

I can just merge it in when I take your patches into my tree (which I'll do
now...).

Cheers,

Will
