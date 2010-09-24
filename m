From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 24 Sep 2010 12:52:38 +0100
Subject: [PATCH 6/8] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
In-Reply-To: <4C9BC620.3@riesch.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231348150.2962@router.home>
	<20100923214359.3f287b11@lxorguk.ukuu.org.uk>
	<4C9BC620.3@riesch.at>
Message-ID: <20100924125238.4c30f3a4@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However, if the clock selected by the BMC is switched off, loses its 
> network connection..., the second best clock is selected by the BMC and 
> becomes master. This clock may be less accurate and thus our slave clock 
> has to switch from one notion of time to another. Is that the conflict 
> you mentioned?

No you get situations where you have policy reasons for trusting
particular clocks for particular things.

So you may have a PTP or NTP clock providing basic system time but also
have other PTP clocks that are actually being used for synchronization
work.

With NTP it's not so far been a big issue - NTP isn't used for industrial
high precision control and the cases we end up with multiple NTP clocks
it's on a virtualised systems where it is isolated.

With high precision clocks you sometimes want to honour a specific PTP
time source and use it rather than try and merge it with your other time
sources (which may differ from the equipment elsewhere). What matters is
things like all the parts of a several mile long conveyor belt of hot
steel slab stopping at the same moment [1].

In lots of control applications you've got assorted different time planes
which wish to talk their own time and you have to accept it, so we need
to support that kind of use.

I agree entirely the normal boring 'I installed my distro and..' case for
PTP or for NTP is merging all the sources, running the algorithm and using
the system time for it. Likewise almost all "normal" application code
will be watching system time.

Alan
[1] Which was my first encounter with writing Vax/VMS assembly language
