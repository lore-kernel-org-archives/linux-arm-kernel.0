From: robh@kernel.org (Rob Herring)
Date: Mon, 28 Sep 2015 08:44:58 -0500
Subject: [PATCH v2 07/10] dts/ls2085a: Update DTSI to add support of
 various peripherals
In-Reply-To: <CAFTCetQ1EE332AnihKFw_Emf7_E4=OcVg2sRDoq3R-siyDZgKg@mail.gmail.com>
References: <1441350322-4671-1-git-send-email-bhupesh.sharma@freescale.com>
 <CAL_Jsq+9izV8vkrF1tK96M-VRGTMJ+GN5o=RsnCBDcnh-at5kA@mail.gmail.com>
 <CAFTCetQ1EE332AnihKFw_Emf7_E4=OcVg2sRDoq3R-siyDZgKg@mail.gmail.com>
Message-ID: <CAL_Jsq+NYgJ-mzbsBKmxzyMOrWsuL6o-gGMpPRERDNfdsCxfWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 5:03 AM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
> Hi Rob,
>
> On Sat, Sep 5, 2015 at 2:45 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On Fri, Sep 4, 2015 at 2:05 AM, Bhupesh Sharma
>> <bhupesh.sharma@freescale.com> wrote:
>>> This patch updates the LS2085a DTSI (DTS Include) file to add
>>> support for various peripherals supported by FSL LS2085a SoC, for e.g.:
>>>         - USB 3.0 Host
>>>         - PMU
>>>         - CCN-504
>>>         - Watchdog
>>>         - SATA
>>>         - SPI
>>>         - PCIe
>>>         - etc.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>>> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
>>> Signed-off-by: Alison Wang <alison.wang@freescale.com>
>>> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
>>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
>>> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  469 +++++++++++++++++++++++-
>>>  1 file changed, 459 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>>> index 333d942..5fee0a7 100644
>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>
> [snip..]

>>> @@ -139,25 +173,440 @@
>>>                              <1 10 0x8>; /* Hypervisor PPI, active-low */
>>>         };
>>>
>>> +       amba {
>>> +               compatible = "arm,amba-bus";
>>
>> Use simple-bus. "arm,amba-bus" is meaningless.
>
> Not sure I understand your comment here. Without this
> compatible in place I cannot see the 'drivers/amba/bus.c'
> amba_match() function getting called which in turn will call the
> amba_lookup() function,
> thus invoking the probe function of the sp805_wdt driver.

I'm not saying the devices are not amba_bustype devices. That has
nothing to do with matching them. "arm,primecell" is what matters
there. There is nothing visible to s/w about "arm,amba-bus," and it is
ambiguous as there are multiple types of AMBA buses (APB, AHB, AXI).
So unless you have bus level registers, use simple-bus. If you have
doubts, try changing it and see that it still works.

Rob
