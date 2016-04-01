From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Apr 2016 12:33:50 +0300
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
Message-ID: <56FE407E.9030803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 03/21/16 19:44, Paul Walmsley wrote:
> Hi P?ter,
> 
> On Mon, 21 Mar 2016, Peter Ujfalusi wrote:
> 
>> On 03/19/16 21:38, Paul Walmsley wrote:
>>> On Fri, 18 Mar 2016, Peter Ujfalusi wrote:
>>>
>>>> Hi,
>>>>
>>>> Chanes since v1:
>>>> - removed the ASoC patch as Mark has applied it already
>>>> - Added my signed-off to the hwmod patch
>>>> - New patch to handle the case when the sidetone hwmod has been removed for
>>>>   legacy boot.
>>>>
>>>> The series addresses a long standing issue with McBSP2/3 regarding to hwmod
>>>> setup. When booting with DT a warning is printed that mcbsp2/3 is using two
>>>> hwmod.
>>>> The root of the issue is the way how the hwmod data was constructed in the first
>>>> place for OMAP3 McBSP2/3.
>>>> After re-reading the TRM it is clear that the sidetone should not have it's
>>>> own hwmod data as it is not a separate IP, it is part of the McBSP module. It
>>>> can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE bit is only
>>>> sets the autoidle from the internal McBSP_iclk clock to the sidetone block of
>>>> the same McBSP.
>>>
>>> NAK, at least without further discussion - see my comments on the v1 0/3 
>>> introduction.
>>
>> Yes, I could have sent the first series as RFC, but I believe(d) that this is
>> the correct way to fix the McBSP sidetone integration.
> 
> Yep not a problem.  You're handling the process correctly.  There's no 
> need to send things as an RFC unless you are unsure. 
> 
> What you and I are doing now is exactly how the discussion and review 
> process is supposed to work.

So what shall we do with the OMAP3 McBSP2/3 sidetone? It has been broken in DT
boot since the first time we booted OMAP3 with DT... Only in legacy mode we
can have properly working ST.

I have the second level of patches based on this set (I think I need to resend
this series since I might have changed it, can not recall) for both arch/arm
and ASoC to have working ST in legacy and DT boot. We will no longer have
warning regarding to broken hwmod data in DT boot.
But all is based on the assumption that we agree at some point that the ST
block is part of the McBSP module ;)

If I need to write separate driver for the McBSP module's ST block, it would
mean some sort of API between the McBSP and ST driver. This is not straight
forward since there are registers both in McBSP block and ST block that needs
to be configured in specific order -> simple enable_st() would not work
(probably enable_st_stage1(), enable_st_stage2()) and callbacks from McBSP to
ST, ST to McBSP also going to be needed. As far as I can see it is going to be
a huge mess.

Other option would be to deprecate the ST support as such, but that would
leave the n900 guys in trouble as they need ST to be functional...

-- 
P?ter
