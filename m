From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Feb 2011 16:26:37 -0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <alpine.LFD.2.00.1102171203280.2701@localhost6.localdomain6>
References: <AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
	<146267380211262372@unknownmsgid>
	<AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>
	<alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>
	<20110217091741.GA24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171032580.2701@localhost6.localdomain6>
	<20110217101957.GC24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171136550.2701@localhost6.localdomain6>
	<20110217105611.GE24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171203280.2701@localhost6.localdomain6>
Message-ID: <001301cbcebf$76925cd0$63b71670$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You have to actually use your brain when implementing a chained
> handler. Looking through a bunch of implementations I found stuff,
> which is basically a poorly implemented flow handler. Worst example:
> fsl_msi_cascade().
> 
> ARM ones are mostly sane, but e.g. nmk_gpio_irq_handler() is not
> really one which fits your description. It's trying to deal with
> different underlying primary chips obviously, which is wrong in the
> first place.

Right, so to get back to the original discussion about how to handle
chained handlers if the high-level flow type of the IRQ chip is altered
it seems that there are two options:

1.) Update all of the chained handlers to use the new flow-control
2.) Retain backwards compatibility if a chained handler decides to
    use the old method of flow control (specifically, leave an ack
    implementation in the GIC code after moving to fasteoi).

Obviously, I'd rather go with option (2) and let platforms migrate
over time if they choose to. Now, given that the ack function is really
not something you want to do in a virtualised environment (because it
pokes the distributor), is it worth sticking a
WARN_ON_ONCE(cpu_has_virtualisation()); in the ack code?

Cheers,

Will
