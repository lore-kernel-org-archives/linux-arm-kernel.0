From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon, 2 Mar 2015 16:59:40 -0800
Subject: [PATCH 2/3] dtb: change binding name to match with newer firmware
 DT
In-Reply-To: <20150302144858.GG16779@leverpostej>
References: <1425067710-14879-1-git-send-email-isubramanian@apm.com>
 <1425067710-14879-3-git-send-email-isubramanian@apm.com>
 <4061014.S4PDWltU3G@wuerfel>
 <CAKh23Fm5HpNEfs40RTf_XtQ6ris5cCheAcY1WdLND04AwsvdSQ@mail.gmail.com>
 <20150302144858.GG16779@leverpostej>
Message-ID: <CAKh23FmLyagk93PHuCxE1Qc=ck6Djkf9oFxjGALe1mqF+U6yPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 6:48 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Feb 27, 2015 at 11:52:54PM +0000, Iyappan Subramanian wrote:
>> On Fri, Feb 27, 2015 at 12:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 27 February 2015 12:08:29 Iyappan Subramanian wrote:
>> >> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> >> index f1ad9c2..a857794 100644
>> >> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> >> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> >> @@ -622,7 +622,7 @@
>> >>                 };
>> >>
>> >>                 sgenet0: ethernet at 1f210000 {
>> >> -                       compatible = "apm,xgene-enet";
>> >> +                       compatible = "apm,xgene1-sgenet";
>> >>                         status = "disabled";
>> >>                         reg = <0x0 0x1f210000 0x0 0xd100>,
>> >>                               <0x0 0x1f200000 0x0 0Xc300>,
>> >>
>> >
>> > This will break booting the new dtb on older kernels, right?
>>
>> This will not break booting older kernels.  In fact, this will fix it,
>> by having the specific binding,
>> older kernel that does not have support for these interfaces, will not
>> call probe.
>>
>> For example, 3.17 kernel that does not have support for SGMII based 1G
>> and XFI 10G interfaces
>> will not probe these interfaces when booted with newer dtb.
>
> I'm guessing that in the existing DTBs, these nodes are always disabled?

These nodes does not exist on 3.17 kernel dtb.
The problem was reported when booted using Tianocore with Device tree,
which has these nodes, but the 3.17 kernel does not have support for
these nodes.

>
> If that's the case then we don't have a problem; we'll never probe these
> nodes for an existing DTB.

With this patch, the following combinations were tested,
u-boot + 3.17 kernel + 3.17 dtb -> this patch will no effect on this
combination, only RGMII based 1G will be probed
u-boot + 3.19 kernel + 3.19 dtb + this patch -> all the 3 ethernet
interfaces was probed
Tianocore (w/ Device Tree) + 3.19 kernel + this patch -> all the 3
ethernet interfaces were probed
Tianocore (w/ ACPI) + 3.19 kernel + this patch -> all the 3 ethernet
interfaces were probed


>
> Mark.
