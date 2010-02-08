From: Steve.Glendinning@smsc.com (Steve.Glendinning at smsc.com)
Date: Mon, 8 Feb 2010 11:46:39 +0000
Subject: smsc911x suspend/resume
In-Reply-To: <4B6FF5E2.6060304@compulab.co.il>
Message-ID: <OFE2B2FE18.A8D1D506-ON802576C4.003FCA39-802576C4.0040B683@smsc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> >> I'm trying to make suspend/resume work on OMAP3-based system and I'm
> >> encountering issues with resume of SMSC 9220 chip.
> >> After resume the interface is unusable unless I do 'ifconfig eth0 
down'
> >> and 'ifconfig eth0 up'.
> >> I would expect that 'ping <some host>' would work right after resume
> >> without need to bring the interface down and up, but probably I miss
> >> something.
> >> Any help would be appreciated.
> > 
> > What happens to your supply voltages when going to suspend? When I
> > implemented the code for the smsc driver, I could only test scenarios
> > where AVDD remains stable during suspend. So the driver might need 
some
> > tweaks if that assumption is not true in your case. The SMSC datasheet
> > is quite comprehensive about this topic IIRC.
> 
> By AVDD you mean VDD33A?
> Anyway, I have all the supplies except VDDVARIO shut down...
> And the datasheet is indeed comprehensively describes chip power states
> but I haven't found there anything about supplies required to stay on
> during suspend...

I don't have the code in front of me (I'm travelling today) but IIRC
the driver doesn't place the LAN9220 in a specific power saving state,
so as far as the LAN9220 is concerned it's not actually suspended.

It's hard to do this in a "generic" way: some people expect their link
to stay up during suspend, some want suspend to completely power down
the ethernet chip, and some want to use one of several WoL modes. 

David: What's the "done thing" here for similar non-pci drivers?
Obviously "doesn't work after suspend" isn't the intended behaviour, so
there's definitely room for improvement!

> > Also have a look at the Raumfeld device patches which use exactly this
> > chip and which can suspend and resume just fine. You'll need to check
> > out Eric's devel branch for that.

Daniel: I haven't seen this, do you have a location for the git tree?

Thanks,
Steve
