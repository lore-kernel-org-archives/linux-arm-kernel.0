From: khilman@ti.com (Kevin Hilman)
Date: Thu, 05 Jul 2012 15:06:31 -0700
Subject: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <alpine.DEB.2.00.1207041257200.6760@utopia.booyaka.com> (Paul
 Walmsley's message of "Wed, 4 Jul 2012 12:59:34 -0600 (MDT)")
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
 <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
 <4FDA45F5.9090300@ti.com>
 <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com>
 <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
 <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
 <4FF475E6.3060308@ti.com>
 <alpine.DEB.2.00.1207041257200.6760@utopia.booyaka.com>
Message-ID: <87pq89euc8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Beno?t
>
> On Wed, 4 Jul 2012, Benoit Cousson wrote:
>
>> > @@ -1141,8 +1144,16 @@ static void _enable_sysc(struct omap_hwmod *oh)
>> >  	sf = oh->class->sysc->sysc_flags;
>> >  
>> >  	if (sf & SYSC_HAS_SIDLEMODE) {
>> > -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
>> > -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>> > +		clkdm_act = ((oh->clkdm &&
>> > +			      oh->clkdm->flags & CLKDM_ACTIVE_WITH_MPU) ||
>> > +			     (oh->_clk->clkdm &&
>> 
>> This is crashing on OMAP4 due to a NULL oh->_clk that can happen on some
>> hwmod.
>> 
>> +			     (oh->_clk && oh->_clk->clkdm &&
>> 
>> Is fixing the issue.
>
> Thanks, just made the change and pushed the patch up to 
> git://git.pwsan.com/linux-2.6 in the branch 'omap_fixes_c_3.5rc'

OK, to ensure this fix gets into v3.5-rc, I'm taking the version from
this branch and queuing up as a PM fix Tony.

Kevin
