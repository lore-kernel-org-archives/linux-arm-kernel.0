From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 21 Nov 2011 15:00:36 +0200
Subject: [PATCHv9 07/18] mfd: omap-prm: added suspend prepare and
 complete callbacks
In-Reply-To: <87d3cpxnhc.fsf@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
 <1316781986-30642-8-git-send-email-t-kristo@ti.com> <87d3cpxnhc.fsf@ti.com>
Message-ID: <1321880436.2153.5.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, 2011-11-18 at 11:02 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > These are needed because runtime PM is disabled during suspend, and
> > it is bad if we get interrupts from the PRCM chain handler during it.
> > Now, PRCM interrupt forwarding is disabled until the suspend->complete,
> > which makes sure that all the needed drivers are up.
> 
> Just to clarify...  based on reading the patch, the wakeup and PRCM
> interrupts themselves still happen (and are saved). They are just not
> dispatched to the drivers until ->complete().
> 

Yea, this is true. We just postpone the dispatching until ->complete().
This is accomplished by disabling all the interrupts from the mask
register once a wakeup interrupt happens, saving the mask, and restoring
it at complete() which triggers the pending interrupts again.

> I think the changelog should be a bit clearer about that.

I can take a look at this for the next version.

-Tero

> 
> Thanks,
> 
> Kevin
