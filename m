From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Nov 2017 11:44:32 -0800
Subject: n900 in next-20170901
In-Reply-To: <5c885f60-bc8c-5f8e-dc81-57eacc57abc8@ti.com>
References: <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
 <20171114063724.GA16969@js1304-P5Q-DELUXE>
 <20171114173719.GA28152@atomide.com>
 <5c885f60-bc8c-5f8e-dc81-57eacc57abc8@ti.com>
Message-ID: <20171114194432.GB28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [171114 19:34]:
> I guess you could just use rx51_secure_dispatcher and ditch the
> save_secure_ram_context call completely (and most of the other related
> code)? That one would handle the cache also in a clean manner.
> 
> Something like:
> 
> rx51_secure_dispatcher(25, 0, FLAG_START_CRITICAL, 4,
> __pa(omap3_secure_ram_storage), 0, 1, 1);

That's different, as rx51_secure_dispatcher does the following:

- Use arguments + 1 instead of 4, we currently use just 4
- Disables local_irq and fiq, we are not doing that now
- Flushes and invalidates cache range, we are not doing that
- Calls omap_smc3 that only does mov r6, #0xff, and does not
  do mov r2, #4
- Missing nops after it's done

This just based on a quick look I did earlier. So just
because of the extra work it does we don't want to do it
even if it worked :)

Regards,

Tony
