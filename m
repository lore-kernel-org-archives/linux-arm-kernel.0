From: khilman@ti.com (Kevin Hilman)
Date: Wed, 16 May 2012 16:36:35 -0700
Subject: [PATCHv2 12/19] ARM: OMAP4: PM: update ROM return address for
 OSWR and OFF
In-Reply-To: <1336990730-26892-13-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Mon, 14 May 2012 13:18:43 +0300")
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-13-git-send-email-t-kristo@ti.com>
Message-ID: <87zk974s1o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Carlos Leija <cileija@ti.com>
>
> At wakeup from OFF/OSWR CPU1 will call secure HAL service through a local
> secure dispatcher with MMU off, 

Reviewers who are uninitaited in this level of detail need some more
help here  (even those who are deeply familiar will need more help in a
few months when they forget the details.)

So, some more detail about where this is in the code would be helpful
here.

> thus ROM will save a PA return address.
> Later in the wakeup, when SMC driver calls an RPC through
> omap4_secure_dispatcher (MMU is on now), 

Again, pointer to where is this in the code would be helpful.

Also, it's not obvious why RPC use used here. Is that referring to the
fact that the secure calls on CPU1 are dispatched to CPU0?  Whatever it
means, it should be summarized in the changelog.

> ROM code won't log the new return
> address as RPCs are handled different. Thus ROM will attempt to return to
> a PA address when the MMU is on and the system will hang.
>
> We need to do this for OSWR state and OFF state of mpu power domain,
> not just for device off(mpu pd OFF).

The code suggests that affects *all* OMAP4 revisions?  Is that correct?

And once again, can this be implmented using cluster PM notifiers, where
the notifier is registered only on affected revisions?

(Sheesh, the number of ROM code workaounds in this series is rather
disconcerting.)

Kevin
