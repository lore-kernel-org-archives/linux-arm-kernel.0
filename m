From: nm@ti.com (Nishanth Menon)
Date: Sat, 14 Jun 2014 17:28:51 -0500
Subject: [PATCH V2 2/2] power: twl4030_charger: attempt to power off in
 case of critical events
In-Reply-To: <20140614222122.GA1389@xo-6d-61-c0.localdomain>
References: <1401313610-14252-1-git-send-email-nm@ti.com>
 <1401313610-14252-3-git-send-email-nm@ti.com>
 <20140614222122.GA1389@xo-6d-61-c0.localdomain>
Message-ID: <CAGo_u6oLuf=tM-jtGrhm_31sAfLd9BfVoLyXC8O280WJ+LQqPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 14, 2014 at 5:21 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> Userland can make orderly_poweroff take long time, or even forever. (Think disconnected
> network with nfsroot).
>
> Should we do something more forceful here? Userland has to handle sudden poweroffs, anyway...
>
> (You could invent new function "give userland 5 seconds to shut system down" if you
> really wanted...)


Or how about:

 /* If we have Power OFF ability, use it, else try restarting */
 if (pm_power_off) {
         kernel_power_off();
 } else {
         WARN(1, "FIXME: NO pm_power_off!!! trying restart\n");
         kernel_restart("Charger triggered emergency restart");
 }


-- 
---
Regards,
Nishanth Menon
