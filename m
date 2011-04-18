From: george@znau.edu.ua (George Kashperko)
Date: Mon, 18 Apr 2011 18:35:40 +0300
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <BANLkTinB-9h=bZg9zg219i2wi3zUCA6mcw@mail.gmail.com>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<201104171938.12834.arnd@arndb.de>
	<BANLkTim6iCAsViJQS4XrY-XObs8pp-BiQQ@mail.gmail.com>
	<201104181619.35115.arnd@arndb.de>
	<BANLkTinB-9h=bZg9zg219i2wi3zUCA6mcw@mail.gmail.com>
Message-ID: <1303140940.31595.45.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >
> > You mean the hardware has two sets of registers containing the same
> > information, one of them the standard registers, and one with broadcom
> > specific ones?
> >
> > Why don't you just use the standard ones then?
> 
> No. Did you read my first mail in this thread?
> 
> There is pair of cores for every device. First is AMBA-specific called
> agent/wrapper and second one is Broadcom-specific.
> 
> AMBA specific core called agent/wrapper has AMBA specific registers:
> CID and PID. However we do not ever read that in Broadcom driver,
> because that are useless for us. On AMBA specific core we use only
> some Broadcom specific registers to manage (enable/disable) *second*
> (Broadcom-specific) core.
> 
Actually there could be two wrappers per agent (wrappers and agents
ain't the same, wrapper could be part of agent or core, for broadcom
ssb/axi buses seems we have wrappers in agents only).

Earlier at ssb-times we had wrappers built into agent, separate agent
per core connection for each broadcom core. Connections are implied with
bus usage by core - core can act as bus initiator (starting transfers to
bus regions, those SBTMxxx registers used for control/state), bus target
(accepting transfers from external bus regions, those SBIMxxx registers)
or both.
Currently for broadcom on axi bus we have the same (might implied by
cores circuitry designed to be OCP-compliant) - cores being able to act
both as initiators and targets have two wrappers built into agent, all
other have either slave or master wrapper.

Unlike ssb, where we used wrappers differently, for axi we use them just
for reset and control/state queries and we never reset/query chipcommon
therefore can silently ignore its agent wrappers. For pcie in device
mode we might need to reset both wrappers for clean initialization (at
least I see both master and slave wrappers' reset during 4716 pci device
mode startup in number of GPL'ed sourcecodes) but here I dont know for
sure. For all other single-role cores we have either target or initiator
wrapper for agent control and as those seems to feature same dmp
register's layout therefore we see no difference in wether we reset
agent master or slave.

Unfortunately still have just one axi-based box to play with. Will be
much appreciated if you could share EROM dumps from your boards to get
better understanding of agents/wrappers coupling and relations.

As for amba bus usage I think we could get back to this idea later at
some point if/when broadcom implement some different agents and/or erom
core with other layout or if we spot broadcom-on-axi bus with some
useful native axi peripherals without DMP wrappers (they are actually
already there on the bus but we have no clue how to control them and
actualy have no need to do that anyways) which won't fit into our
coure->agent model but for now I think there is no benefit in doing
that.

Have nice day,
George
