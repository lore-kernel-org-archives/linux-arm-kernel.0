From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Feb 2014 11:17:10 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <52F892C8.80508@st.com>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140207170903.GT5976@mudshark.cambridge.arm.com>
 <52F892C8.80508@st.com>
Message-ID: <20140210111710.GC17766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 08:50:16AM +0000, Fabrice Gasnier wrote:
> On 02/07/2014 06:09 PM, Will Deacon wrote:
> > On Fri, Feb 07, 2014 at 04:19:15PM +0000, Fabrice GASNIER wrote:
> >> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> >> index 4636d56..ef15709 100644
> >> --- a/arch/arm/kernel/traps.c
> >> +++ b/arch/arm/kernel/traps.c
> >> @@ -900,6 +900,10 @@ void __init early_trap_init(void *vectors_base)
> >>   
> >>   	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
> >>   	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
> >> +
> >> +	/* Enable imprecise aborts */
> >> +	local_abt_enable();
> > Surely we want to enable this as early as possible? Now, putting this into
> > head.S is ugly, as it duplicating it across all the proc*.S files, so why
> > not setup_arch?
> Sorry, I'm not sure to understand your last comment.
> At least, I need it enabled before probing drivers (PCIe bus)
> I've added imprecise abort enable code in traps.c, following Russel 
> King's advice, please see:
> http://archive.arm.linux.org.uk/lurker/message/20140131.170827.d752a1cc.en.html
> As abort bit is local to a cpu, i've also added it in smp.c, but this 
> may not be the right place ?
> 
> Please elaborate,

I was just suggesting that we move your local_abt_enable() call to
setup_arch, since that's called before early_trap_init on the primary CPU.

Will
