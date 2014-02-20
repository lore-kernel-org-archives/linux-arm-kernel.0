From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Feb 2014 11:58:54 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392892217.23342.18.camel@kazak.uk.xensource.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
Message-ID: <20140220105854.GL11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 10:30:17AM +0000, Ian Campbell wrote:
> On Fri, 2014-02-07 at 18:34 +0100, Sebastian Hesselbarth wrote:
> > On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> > > Now that all the device tree support is in mach-mvebu, remove it from
> > > mach-kirkwood.
> > >
> > > Regenerate kirkwood_defconfig, removing all DT support, and a couple
> 
> s/DT/board-file/?

We keep any system using -setup.c files, and remove the ability to
boot systems with a DT description. Thus mach-kirkwood becomes legacy,
and you should now be trying to only use mach-mvebu, compiled for v5
systems and a second compile for v7 systems.

There are four systems left in mach-kirkwood which don't have DT
equivalent. These are LaCie 2Big and 5Big, HP t5325 thin client and
Marvell OpenRD machines. I'm working on t5325 and Openrd. The sticking
point is audio support, which no other board has done with DT yet.
The two LeCie boards have a custom LED driver which needs a DT
binding. My gut feeling is that we won't get these four converted to
DT in time for 3.15.
 
> > > of other redundent options have been removed in the process.
> > >
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > 
> > Hmm, I wonder what Ian thinks of removing this so quickly again...
> 
> I don't want to stand in the way of progress. What version is this
> targeting so I can setup our tooling to DTRT and append a DTB under the
> correct circumstances.

My aim is 3.15. Most patches have been Acked now, so i think we are on
track for that.

 
> I still need to figure out how to distinguish the variations, but I
> think I have a plan there (via which PCI buses are present, which is a
> bit skanky but seems like the most workable solution).

Having the SoC ID available via lspci for systems using the new PCI
driver might be in 3.14. It was considered a regression so might get
merged into an rc. If not, it will be in 3.15.

We have also talked about putting the SOC version and revision into
/proc/cpuinfo, in the Revision field. However this has not happened
yet.

	Andrew
