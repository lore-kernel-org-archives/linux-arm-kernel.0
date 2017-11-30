From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 30 Nov 2017 22:57:52 +0300
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Enable NFS root
In-Reply-To: <CAMuHMdVKA5YmRPcTTGafKciMF-cKtKTx+PdNJtrDRb20jCxtAA@mail.gmail.com>
References: <1493717048-10740-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXbvC90k1QYZsjWx=f7QVQyWOzi_v3u8ShDoDsSAmZsjw@mail.gmail.com>
 <20171130094354.6pktdlcuc3gettji@verge.net.au>
 <20171130125217.GE22365@bigcity.dyn.berto.se>
 <CAMuHMdVKA5YmRPcTTGafKciMF-cKtKTx+PdNJtrDRb20jCxtAA@mail.gmail.com>
Message-ID: <1d0ad706-81ee-5e0f-6f8f-696c8428af73@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2017 04:45 PM, Geert Uytterhoeven wrote:

>>>>> Enable NFS root on the r8a7795/h3ulcb and r8a7796/m3ulcb
>>>>> as per:
>>>>> * commit b2407c566ba29215 ("arm64: dts: r8a7795: enable nfs root on Salvator-X board").
>>>>> * commit 742a9dfb90f0 ("arm64: dts: r8a7796: salvator-x: Enable NFS root")
>>>>>
>>>>> Also set ignore_loglevel rw as boot args as is the case for the boards
>>>>> for the boards for other Renesas ARM/ARM64 based SoCs.
>>>>
>>>> s/for the boards//
>>>>
>>>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>>
>>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>
>>>> Gr{oetje,eeting}s,
>>>
>>> Sergei has pointed out that bootargs has seems to have effect on ARM64
>>> kernels. So I think this patch should be withdrawn and we should consider
>>> removing bootargs from those ARM64 boards where it is present.
>>>
>>
>> I don't think this is true.
>>
>> I just added a argument to bootargs to salvator-common.dtsi for some
>> hack testing and it took effect. Tested on-top of latest renesas-drivers
>> and H3 ES2.0.
>>
>>>>> DIFF <<<
>> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> index 7b30044a55367d35..4cb4b44f8be42cb4 100644
>> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
>> @@ -42,7 +42,7 @@
>>          };
>>
>>          chosen {
>> -               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
>> +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp adv748x.txbvc=1";
>>                  stdout-path = "serial0:115200n8";
>>          };
>>>>> END DIFF <<<
>>
>> # cat /sys/firmware/devicetree/base/chosen/bootargs
>> ignore_loglevel rw root=/dev/nfs ip=dhcp adv748x.txbvc=1
>>
>> And the module parameter had the expected effect on the adv7482x driver.
>> Is there another issue here which I'm missing?
> 
> 1. It may depend on the U-Boot version

    It probably does! My U-Boot clearly copies its "bootargs" env. variable 
into DT's "/chosen/bootargs" prop.

> 2. Anyone playing with CONFIG_CMDLINE and CONFIG_CMDLINE_FORCE?

    Not me (before now). Tried it now and it works as expected.

> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
