From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 09 Dec 2013 20:04:21 +0100
Subject: [linux-sunxi] Re: [PATCH 04/10] net: stmmac: sunxi platfrom
 extensions for GMAC in Allwinner A20 SoC's
In-Reply-To: <CAGb2v64LNxnz--vn0u9zwmt7MQJZ=uz2fs0H3zDSse_XDfdK4Q@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org> <52A5A52C.50605@st.com>
 <52A5ECF4.6030301@redhat.com>
 <CAGb2v64LNxnz--vn0u9zwmt7MQJZ=uz2fs0H3zDSse_XDfdK4Q@mail.gmail.com>
Message-ID: <52A61435.6040803@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/09/2013 06:56 PM, Chen-Yu Tsai wrote:
> Hi,
>
> On Tue, Dec 10, 2013 at 12:16 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 12/09/2013 12:10 PM, srinivas kandagatla wrote:
>>>
>>> Hi Chen,
>>> Good to know that Allwinner uses gmac.
>>>
>>> On ST SoC, we have very similar requirements, before we merge any of
>>> these changes I think we need to come up with common way to solve both
>>> Allwinner and ST SOCs use cases.
>>>
>>> I have already posted few patches on to net-dev
>>> http://lkml.org/lkml/2013/11/12/243 to add Glue driver on top of stmmac
>>> driver.
>>>
>>>
>>> There are few reasons for the way I have done it.
>>>
>>> 1> I did not want to modify gmac driver in any sense to when a new SOC
>>> support is added.
>>> 2> As the SOC specific glue logic sits on top of standard GMAC IP, it
>>> makes sense to represent it proper harware hierarchy.
>>
>>
>> On top often is not the correct term / how things are done in practice.
>>
>> Most of the time the glue are modifications to the ip block, iow in
>> hardware they are not nested / hierarchical at all. We've had similar
>> constructs for ahci platform drivers and there we are actively trying to
>> move away from the whole nested platform devices as that has various
>> issues:
>>
>> 1) It is wrong / does not reflect reality
>> 2) It breaks deferred probing which is often used on SOCs
>>
>> I actually think Wens' approach using a SOC specific init function
>> in platform data is sound, and this is also used a lot else where.
>>
>> As for using the nested approach elsewhere, I only know about AHCI
>> platform driver doing that, and there we are actively trying to move
>> away from it.
>>
>>
>> Now reading this has also made me take a closer look at wens' patch
>> for this. Wens, I see that you directly modify registers in the ccm
>> that is a big no-no instead you should add a helper function to
>> sunxi-clk.c and use that, see ie:
>> https://bitbucket.org/emiliolopez/linux/commits/2b95847d9aa4aa13317dd7358ffcbd951dcb5eff?at=master
>
> Yes, this has been raised by Maxime. The odd "GMAC_IF_TYPE_RGMII" or
> "gmac interface type bit" has been bugging me.
>
> Additionally, the TX clock has 2 inputs (not counting MII [1]).
> The internal one is most likely controlled by the GMAC. The clock
> rate is set internally to match the link speed. The external clock
> source has controllable dividers to get the correct clock rate.
> This shouldn't be hard to model with CCF though.
>
> In hardware, this is probably a mux between the GMAC clock generator
> and the GMAC data transmit logic.
>
> My current plan is to choose MII when the clock is disabled,
> and choose either of the inputs when it is enabled. I will
> have to learn more about the CCF first.

OK, in this case I would be tempted to just go with a custom sunxi
function in the sunx-clk mode like what we have for the mmc stuff,
but if you think you can model this with the regular clock stuff,
that is of course fine too :)

Regards,

Hans
