From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Nov 2017 14:45:17 +0100
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Enable NFS root
In-Reply-To: <20171130125217.GE22365@bigcity.dyn.berto.se>
References: <1493717048-10740-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXbvC90k1QYZsjWx=f7QVQyWOzi_v3u8ShDoDsSAmZsjw@mail.gmail.com>
 <20171130094354.6pktdlcuc3gettji@verge.net.au>
 <20171130125217.GE22365@bigcity.dyn.berto.se>
Message-ID: <CAMuHMdVKA5YmRPcTTGafKciMF-cKtKTx+PdNJtrDRb20jCxtAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Thu, Nov 30, 2017 at 1:52 PM, Niklas S?derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2017-11-30 10:43:55 +0100, Simon Horman wrote:
>> On Tue, May 02, 2017 at 11:27:58AM +0200, Geert Uytterhoeven wrote:
>> > On Tue, May 2, 2017 at 11:24 AM, Simon Horman
>> > <horms+renesas@verge.net.au> wrote:
>> > > Enable NFS root on the r8a7795/h3ulcb and r8a7796/m3ulcb
>> > > as per:
>> > > * commit b2407c566ba29215 ("arm64: dts: r8a7795: enable nfs root on Salvator-X board").
>> > > * commit 742a9dfb90f0 ("arm64: dts: r8a7796: salvator-x: Enable NFS root")
>> > >
>> > > Also set ignore_loglevel rw as boot args as is the case for the boards
>> > > for the boards for other Renesas ARM/ARM64 based SoCs.
>> >
>> > s/for the boards//
>> >
>> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> >
>> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >
>> > Gr{oetje,eeting}s,
>>
>> Sergei has pointed out that bootargs has seems to have effect on ARM64
>> kernels. So I think this patch should be withdrawn and we should consider
>> removing bootargs from those ARM64 boards where it is present.
>>
>
> I don't think this is true.
>
> I just added a argument to bootargs to salvator-common.dtsi for some
> hack testing and it took effect. Tested on-top of latest renesas-drivers
> and H3 ES2.0.
>
>>>> DIFF <<<
> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> index 7b30044a55367d35..4cb4b44f8be42cb4 100644
> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> @@ -42,7 +42,7 @@
>         };
>
>         chosen {
> -               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp adv748x.txbvc=1";
>                 stdout-path = "serial0:115200n8";
>         };
>>>> END DIFF <<<
>
> # cat /sys/firmware/devicetree/base/chosen/bootargs
> ignore_loglevel rw root=/dev/nfs ip=dhcp adv748x.txbvc=1
>
> And the module parameter had the expected effect on the adv7482x driver.
> Is there another issue here which I'm missing?

1. It may depend on the U-Boot version
2. Anyone playing with CONFIG_CMDLINE and CONFIG_CMDLINE_FORCE?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
