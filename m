From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 22 Sep 2016 11:39:35 -0700
Subject: [RFC 1/4] arm64: dts: msm8992 SoC and LG Bullhead (Nexus 5X)
 support
In-Reply-To: <6cf4c215-e8a3-a9db-fcf1-8b56b5c1fab9@redhat.com>
References: <1467938467-21607-1-git-send-email-jmcnicol@redhat.com>
 <1467938467-21607-2-git-send-email-jmcnicol@redhat.com>
 <20160708174125.GC7896@hector.attlocal.net>
 <6cf4c215-e8a3-a9db-fcf1-8b56b5c1fab9@redhat.com>
Message-ID: <147456957514.9057.12155171248212777735@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jeremy McNicoll (2016-09-20 17:42:02)
> On 2016-07-08 10:41 AM, Andy Gross wrote:
> > On Thu, Jul 07, 2016 at 05:41:04PM -0700, Jeremy McNicoll wrote:
> >> +
> >> +#include "../qcom/msm8992.dtsi"
> >> +
> >> +/ {
> >> +    model = "LGE MSM8992 BULLHEAD rev-1.01";
> >> +    compatible = "qcom,msm8992";
> >> +    qcom,board-id = <0xb64 0>;
> >
> > Please work with sboyd to add the board-id to the dtbTool.  We don't put
> > board-ids in the dts file.  We post-process the dtb file and add them then.
> >
> 
> sboyd has all the info he needs for this, I believe its just with legal 
> now.  Will remove for V2.

I've pushed out an update for dtbtool to have these msm ids.

> 
> >> +
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/clock/qcom,gcc-msm8994.h>
> >> +
> >> +/ {
> >> +    model = "Qualcomm Technologies, Inc. MSM 8992";
> >> +    compatible = "qcom,msm8992";
> >> +    qcom,msm-id = <251 0>, <252 0>;
> 
> This is needed or else the LK provides the following error
> 
> [5380] qcom,msm-id entry not found
> 
> and refuses to boot.
> 
> 
> >> +    qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;
> >
> > See above comment on ids.
> 
> removal of this (pmic-id) seems to be ok.
> 

Having the msm ids (and the pmic ids) in dtbtool isn't going to help
here though. I believe the bootloader on these devices uses a design of
appended dtbs where each dtb has the qcom,{msm-id,board-id,pmic-id}
properties in them. The QCDT "header" that dtbtool generates is not
used.

To fix that problem we'll need to update dtbtool to inject these
properties into the dtbs based on the compatible strings. Or get
maintainers to accept that these ids are now necessary for proper
functionality.

Furthermore, the value of board-id (0xb64) is concerning. qcom only
supports a certain set of values there for their boards, but vendors are
free to do whatever they want with that value. This means they can reuse
existing values that would map to qcom's concept of the "mtp" or "cdp"
boards, or they can numbers that would alias with other vendors.
Thankfully, msm-id and pmic-id are values that are under qcom's control,
so those are always going to be unique and sane. Really all that could
alias is board-id.

What does this all mean? We can't support non-qcom boards in the same
boot.img because of the possibility for the board-id property to alias
between different dtbs. Or at least dtbtool will have to do some alias
analysis and eject one aliasing dtbs from the blob. It also means that
we have a lot of work to do in dtbtool to inject these properties based
on strings, and to have custom parsers for different vendor prefixes so
that we know what values to inject (the nightmare is growing).

I've asked the bootloader folks to fix this in future platforms so that
we match based on the compatible string, instead of having to do any
post processing. Basically, put dtbtool logic into the bootloader. The
discussion is still on-going, but I'm hopeful that we don't need to keep
doing things here with post-processing and the headache will be reduced.
That could totally backfire though if vendors decide to leave the
bootloader unchanged and boot the "qcom,msm8992-mtp" dtb that's been
slightly tweaked for their design. Let's hope that doesn't happen.
