From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 2 Mar 2017 09:23:27 +0200
Subject: [RESEND PATCH v2 0/5] Fix the parse_dt of exynos dsi and remove
 the OF graph
In-Reply-To: <a9e52516-bb05-7ad3-01d5-da1fe3bc7548@samsung.com>
References: <CGME20170228081811epcas5p3c0a8151d94511e47a0e0d2b8787b1fb0@epcas5p3.samsung.com>
 <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
 <CAJKOXPfv8wJ+0L4G_0sB1Qh-svXx4VvNJH_1THSy5SsXuUstzA@mail.gmail.com>
 <a9e52516-bb05-7ad3-01d5-da1fe3bc7548@samsung.com>
Message-ID: <CAJKOXPeP-86=AsNH-xodkMpLJm1uLG0tKq2bz93FE5oFBDB4mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 2, 2017 at 3:44 AM, Hoegeun Kwon <hoegeun.kwon@samsung.com> wrote:
> On 02/28/2017 06:58 PM, Krzysztof Kozlowski wrote:
>> Discussions in previous thread lead us to bisectability problem.
>> Bisectability in regular driver changes is one thing but in case of
>> driver + DTS the gap is much bigger. DTS will go through separate tree
>> and branches. How do you want to solve the problem?
>
>
> Sorry for the delay in reply, Mar 1st was the holiday.
> I thought of two solutions.
>
> 1. squash the patches in a single patch

No, for the same reason. DTS code/patches have to go through arm-soc
DTS branch without mixing with any driver changes. Otherwise arm-soc
guys are angry.

> 2. split the dts related patches so that the first part adds the:
> +    samsung,burst-clock-frequency = <512000000>;
> +    samsung,esc-clock-frequency = <16000000>;
>
> and the second part at the end removes the 'port' node
> So it consists of 6 patches in total.

That's a solution. The remaining DTS patches would go in next release...

Another solution would be for this release cycle:
        if (of_property_does_not_exist(node, "samsung,burst-clock-frequency") {
                // Fallback to old parsing mode
                node = of_graph_get_endpoint_by_regs(node, DSI_PORT_OUT, 0);
                if (!node) {
                        dev_err(dev, "no burst-clock-frequency nor
output port with endpoint specified\n");
                        return -EINVAL;
                }
        }
        ret = exynos_dsi_of_read_u32(node, "samsung,burst-clock-frequency",
                                     &dsi->burst_clk_rate);
        ...

...and in next release the DTS patches would go in. This would give
you also DTB backward compatibility. However still DTS could be
applied later, after driver changes gets into mainline.

Personally I would prefer your solution #2 (with separate DTS patch
adding new properties). Does it sound reasonable for Inki?

Thanks for looking into this problem.

Best regards,
Krzysztof
