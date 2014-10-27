From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Oct 2014 15:40:49 +0100
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <20141027141958.GB12627@lunn.ch>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024142044.GB3142@lunn.ch>
 <20141024162824.67f9ce3d@free-electrons.com>
 <20141024145119.GD3142@lunn.ch>
 <20141027135129.292bd882@free-electrons.com>
 <20141027141958.GB12627@lunn.ch>
Message-ID: <20141027154049.583e4cd2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 27 Oct 2014 15:19:58 +0100, Andrew Lunn wrote:

> > But in my case, what's needed is neither a power off nor a reboot, but
> > an entry to suspend to RAM, which is a different state. I don't see how
> > the drivers/power/reset driver would get "called" by the suspend/resume
> > procedure.
> 
> I'm not sure it will work. It is just an idea.
> 
> I'm making some assumptions here, which could be wrong.
> 
> #1 This GPIO interface does more than suspend to RAM power off. I
> assume it also does full power off? It might also support Wake on LAN?

This I don't know, but we can probably assume it's the case.

> #2 Any code can call a notifier chain and pass parameters to that
> chain?

Right. But for existing notifier chains, the existence, semantic and
meaning of the parameters are already defined, and the gazillions users
of that notifier chain in the kernel rely on those parameters to not
change.

> If #1 is true, you are going to write a drivers/power/reset driver at
> some point, so you can power off the board. So once you have that
> code, all you need to do is pass an additional parameter, saying this
> is a suspend to RAM power off, not a full power off. It then puts the
> DRAM controller into self refresh before bit banging the gpios.
> 
> If #2 is correct, you have a mechanism to do this. In your suspend
> function, call the notifier chain passing the needed parameter.  If
> the notifier chain is called for a normal power off, the parameters
> will be missing, and you know it is a full power off.
> 
> Anyway, it is just an idea. Feel free it ignore it.

Are we talking about  the reboot_notifier_list, implemented by
kernel/reboot.c? It seems to me it's used to let drivers know that they
should quiesce all DMA transfers and things like that before doing a
shutdown. It's also tied to the system states that are defined in
<linux/kernel.h> :

/* Values used for system_state */
extern enum system_states {
        SYSTEM_BOOTING,
        SYSTEM_RUNNING,
        SYSTEM_HALT,
        SYSTEM_POWER_OFF,
        SYSTEM_RESTART,
} system_state;

Is it really reasonable to add one more state here? I can certainly
draft something, but it looks like a lot of core kernel changes which I
believe have a very small chance of getting accepted.

I'm really trying to understand better what you suggest, and see how it
can work for our situation, but for now, it's not very clear to me how
that would work.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
