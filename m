From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Oct 2012 10:26:42 -0600
Subject: [PATCH] ARM: kirkwood: DT board setup for Network Space v2 and
 parents
In-Reply-To: <20121009111701.GQ11837@lunn.ch>
References: <1349277270-24962-1-git-send-email-simon.guinot@sequanux.org>
 <20121003154310.GI11837@lunn.ch> <20121003220916.GW31897@kw.sim.vm.gnt>
 <20121004055443.GK21046@lunn.ch> <20121004075335.GY31897@kw.sim.vm.gnt>
 <506DAE12.7000003@wwwdotorg.org> <20121009111701.GQ11837@lunn.ch>
Message-ID: <50745042.2020807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2012 05:17 AM, Andrew Lunn wrote:
>>>> The question is, what is the appropriate name. How common is
>>>> this common C code? Are there ns2 where this C code is not
>>>> appropriate. One thing to remember is that most of this C code
>>>> will soon disappear and become DT. All the mpp will be replaced
>>>> with pinctrl in 3.8. I hope we can get the Ethernet setup in DT
>>>> as well. You are working on ns2_led, so all the C code will be
>>>> replaced by DT. So all we are really left with is power off GPIO
>>>> handling.
>>>>
>>>> So i think the danger of using lacie,ns2_common, and then finding
>>>> it does not work with some other ns2 device is quite low.
>>
>> lacie,ns2_common doesn't sound like a HW description, but rather a SW
>> invention. DT should be describing purely the HW. If there's no common
>> HW between these compatible boards (which seems unlikely), then there
>> shouldn't be a shared compatible value.
> 
> Actually, there is common hardware between these boards:
> 
> NS2 LED driver
> Pinctrl setup
> GPIO used for power off
> Ethernet configuration.
> 
> At the moment, we don't have DT for these, so there is C code.  The
> "lacie,ns2_common" compatibility string would be used to enable this C
> code for these boards.

The typical way to support this is to simply include a .dtsi file from
both board-specific .dts file. That .dtsi file will provide the
description of the two common pieces of hardware.

In the interim where you're stilling using some board file C code rather
than DT for this common part, just trigger that C code from any of the
compatible values for the boards where it's needed. Don't invent a new
compatible value that means "run this C code".
