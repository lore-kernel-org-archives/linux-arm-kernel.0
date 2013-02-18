From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 23:21:19 +0900
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <51223584.5080709@cogentembedded.com>
References: <201302170143.36052.sergei.shtylyov@cogentembedded.com>
 <874nhao1nx.wl%kuninori.morimoto.gx@renesas.com>
 <51223584.5080709@cogentembedded.com>
Message-ID: <CANqRtoRdTMN=KgP4CypF+mpTN4HOSKrDAoq2pr4Pd3t-zarSjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thanks for your efforts with this SATA driver.

On Mon, Feb 18, 2013 at 11:07 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 18-02-2013 5:23, Kuninori Morimoto wrote:
>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> Add SATA clock and platform device resources on r8a7779 SoC.
>>> Add entry to r8a7779_auxdata_lookup[], so that devm_clk_get() in the
>>> driver
>>> still works when we're using the device tree.
>
>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> (snip)
>
>
>>>         /* MSTP32 clocks */
>>> +       CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
>>>         CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB
>>> EHCI port2 */
>>>         CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB
>>> OHCI port2 */
>>>         CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB
>>> EHCI port0/1 */
>>
>> (snip)
>>>
>>>   static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst
>>> = {
>>> +       OF_DEV_AUXDATA("renesas,rcar-sata", 0xfc600000, "sata_rcar",
>>> NULL),
>
>
>> ??
>> Is this settings really required for DT ??
>
>
>    Yes, TTBOMK, it's the last resort measure used in exctly this case.

Well, I have to agree with Morimoto-san here. Other vendors may chose
to use AUXDATA to map clocks, and I believe it makes sense in the case
of adding platform data as a workaround during transition to full DT
support. But for simply mapping clocks please follow the same style as
we have done so far, which is what Morimoto-san pointed out:

CLKDEV_DEV_ID("fc600000.sata_rcar", &mstp_clks[MSTP115]),

Also, I don't think SATA is needed as an early device so it should be
enough to register it late as a regular platform device. =)

Thanks,

/ magnus
