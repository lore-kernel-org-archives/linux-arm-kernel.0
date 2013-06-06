From: jp.francois@cynove.com (jean-philippe francois)
Date: Thu, 6 Jun 2013 09:56:47 +0200
Subject: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
In-Reply-To: <alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
 <alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com>
Message-ID: <CAGGh5h1gBin0vWFf=SpB4eCQX69a2U+J6u2ccF_Oo_4R62+5fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/5 Paul Walmsley <paul@pwsan.com>:
> Hi
>
> On Thu, 30 May 2013, Jean-Philippe Francois wrote:
>
>> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the clock
>> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned clock
>> have parent defined as clk_divider. Instead of using container_of to eventually get
>> to the register and directly mess with the divider, change freq via clk_set_rate,
>> and let the clock framework toggle the divider value.
>> Tested with  3.9 on dm3730.
>>
>> Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>
>
> Tested this patch before applying, and noticed that it causes the
> retention dynamic idle power management test to fail here on the
> 3730beaglexm:
>
> http://www.pwsan.com/omap/testlogs/fixes_b_v3.10-rc/20130605113443/pm/3730beaglexm/3730beaglexm_log.txt
>
> Not sure at this point if this is caused by the patch, or if the patch is
> just unmasking another bug.
>
> Jean, Mike, Rajendra, care to take a look at this?
>

I am booting with nohlt on my board, because I otherwise have memory
corruption error.
I never looked into it because power consumption is currently a non
issue for us, and the board
will always be working anyway.

However I have a beaglexm too, so I can probably help with testing.

Does the first version [1] of the patch, that only touch the MSB of
the divider also trigger the
bug ?

[1]  https://patchwork.kernel.org/patch/2609681/

Jean-Philippe
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
