From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 4 Jul 2012 18:01:35 +0200
Subject: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
 <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
 <4FDA45F5.9090300@ti.com>
 <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com>
 <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
Message-ID: <4FF468DF.10108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 07/04/2012 02:48 PM, Paul Walmsley wrote:
> Hi Beno?t,
> 
> On Fri, 15 Jun 2012, Cousson, Benoit wrote:
> 
>> My point is simple, we should not add any new custom flag when all the 
>> information to detect such exception are already there in the current 
>> data and represent accurately what the HW is doing.
> 
> This seems like the crux of the issue.  We don't have sufficient 
> information to detect this exception in our current data, in my view.  
> The software additionally must know when it can rely on a clockdomain 
> remaining active when the MPU is active.

Yes, indeed, but that will be accurate mostly for OMAP3.
On OMAP4, *in theory* the dynamic dependency should always ensure that a
clock domain will be accessible upon any initiator requests.
In that case the notion of a domain active when the MPU is active become
a little bit less accurate.
Except when we have to force the static dep because of HW bugs
workaround. In that case, we are in the same situation than OMAP3.

> Ideally the hardcoded clockdomain sleep dependencies would be encoded, and 
> we could test the intersection of those and the software-programmable 
> clockdomain sleep dependencies.  But such a change seems too complex for 
> the -rc cycle.  So the updated patch below uses a clockdomain data flag 
> for this instead.

Yep, I do agree that encoding that kind of information will require more
thought and much more code.

I have the feeling that some information about the IP idle behavior
should help figuring out that module like counter_32k, GPIO or mailbox
can be handled without real SW control.

This intermediate approach is thus good for the moment.


> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 4 Jul 2012 05:22:53 -0600
> Subject: [PATCH] ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer

[...]

> @@ -1208,8 +1219,13 @@ static void _idle_sysc(struct omap_hwmod *oh)
>  	sf = oh->class->sysc->sysc_flags;
>  
>  	if (sf & SYSC_HAS_SIDLEMODE) {
> -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
> +		/* XXX What about HWMOD_IDLEMODE_SMART_WKUP? */

What do you mean here?

Regards,
Benoit
