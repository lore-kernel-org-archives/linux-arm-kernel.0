From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 09:36:44 +0300
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com>
 <536B1A9C.7050006@ti.com>
 <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
Message-ID: <536C777C.8000600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 19:01, Paul Walmsley wrote:
> Hi Archit,
> 
> On Thu, 8 May 2014, Archit Taneja wrote:
> 
>> Hi Paul,
>>
>> On Thursday 08 May 2014 10:07 AM, Paul Walmsley wrote:
>>> Hi,
>>>
>>> On Wed, 12 Mar 2014, Tomi Valkeinen wrote:
>>>
>>>> This patch adds hwmod data for omap5 display subsystem. I have tested this
>>>> on
>>>> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet,
>>>> as the
>>>> mainline is missing omap5 HDMI driver.
>>>>
>>>> I do see this when booting:
>>>>
>>>>    omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>>>>    omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
>>>>
>>>> But at least DSI works just fine.
>>>
>>> Am looking at this for v3.16.  But I think someone needs to take a look at
>>> those warnings and figure out why they are happening.
>>
>> We associate DSS clock domain's MODULEMODE bits only with the dss_core hwmod.
>> The rest of the dss hwmods don't touch MODULEMODE.
>>
>> Therefore, these hwmods cannot be enabled independently, and reset.
>>
>> We don't face this issue in the omapdss driver since the platform devices
>> corresponding to these hwmods have their parent as the platform device
>> corresponding to 'dss_core'. This parent child-relation ensures that
>> 'dss_core' is enabled when the a child calls a pm_runtime_get function.
>>
>> The problem is that we have multiple hwmods which use the same MODULEMODE bit.
>> There is no use-counting done when it comes to enabling/disabling modulemode.
>> If there was such a thing, we could have provided MODULEMODE flags even for
>> the children hwmods.
> 
> Thanks for the summary.  This is indeed a long-overdue item for the hwmod 
> core code.  Can you please patch the hwmod core code to add this?  I'd 
> suggest making the use-counting functionality conditional on a hwmod flag 
> that you can set for all of the DSS hwmods.  (Ideally, the core code would 
> detect that several modules share the same MODULEMODE bits, and 
> automatically set it for those cases, but that seems a bit too complex for 
> a first cut.)

Can we still go forward with this patch as it is? As far as I
understand, the warnings are harmless (more or less), but without this
patch we won't have OMAP5 display support.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/67aef498/attachment.sig>
