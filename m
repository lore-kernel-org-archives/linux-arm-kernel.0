From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Oct 2014 15:19:58 +0100
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <20141027135129.292bd882@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024142044.GB3142@lunn.ch>
 <20141024162824.67f9ce3d@free-electrons.com>
 <20141024145119.GD3142@lunn.ch>
 <20141027135129.292bd882@free-electrons.com>
Message-ID: <20141027141958.GB12627@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas
 
> I had a closer look, but I'm sorry, I don't really see how
> drivers/power/reset can help here. In drivers/power/reset, there are
> only drivers that handle powering off a platform, or rebooting a
> platform. They hook up by setting a value to the pm_power_off and/or
> arm_pm_restart function pointers.

This has changed recently. I think pm_power_off and arm_pm_restart
have been replaced by a notifier chain.
 
> But in my case, what's needed is neither a power off nor a reboot, but
> an entry to suspend to RAM, which is a different state. I don't see how
> the drivers/power/reset driver would get "called" by the suspend/resume
> procedure.

I'm not sure it will work. It is just an idea.

I'm making some assumptions here, which could be wrong.

#1 This GPIO interface does more than suspend to RAM power off. I
assume it also does full power off? It might also support Wake on LAN?

#2 Any code can call a notifier chain and pass parameters to that
chain?

If #1 is true, you are going to write a drivers/power/reset driver at
some point, so you can power off the board. So once you have that
code, all you need to do is pass an additional parameter, saying this
is a suspend to RAM power off, not a full power off. It then puts the
DRAM controller into self refresh before bit banging the gpios.

If #2 is correct, you have a mechanism to do this. In your suspend
function, call the notifier chain passing the needed parameter.  If
the notifier chain is called for a normal power off, the parameters
will be missing, and you know it is a full power off.

Anyway, it is just an idea. Feel free it ignore it.

	Andrew
