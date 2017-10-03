From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Oct 2017 14:38:36 +0200
Subject: [PATCH 5/6] staging: fsl-dpaa2/ethsw: Add README
In-Reply-To: <AM3PR04MB0743030F8D97FFB37016F11AE6720@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
 <1505811698-7338-6-git-send-email-razvan.stefanescu@nxp.com>
 <20170919121755.GB4569@lunn.ch>
 <AM5PR0402MB26917E7523D582ABB0A3D0D2EC720@AM5PR0402MB2691.eurprd04.prod.outlook.com>
 <AM3PR04MB0743030F8D97FFB37016F11AE6720@AM3PR04MB0743.eurprd04.prod.outlook.com>
Message-ID: <20171003123836.GD13548@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 10:07:41AM +0000, Razvan Stefanescu wrote:
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> > On Behalf Of Andrew Lunn
> > Sent: Tuesday, September 19, 2017 3:18 PM
> > To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> > Cc: devel at driverdev.osuosl.org; Ruxandra Ioana Radulescu
> > <ruxandra.radulescu@nxp.com>; arnd at arndb.de; gregkh at linuxfoundation.org;
> > Alexandru Marginean <alexandru.marginean@nxp.com>; linux-
> > kernel at vger.kernel.org; agraf at suse.de; stuyoder at gmail.com; Bogdan
> > Purcareata <bogdan.purcareata@nxp.com>; linux-arm-
> > kernel at lists.infradead.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Subject: Re: [PATCH 5/6] staging: fsl-dpaa2/ethsw: Add README
> > 
> > On Tue, Sep 19, 2017 at 12:01:37PM +0300, Razvan Stefanescu wrote:
> > > +Driver uses the switch device driver model and exposes each switch port as
> > > +a network interface, which can be included in a bridge. Traffic switched
> > > +between ports is offloaded into the hardware. Exposed network interfaces
> > > +are not used for I/O, they are used just for configuration. This
> > > +limitation is going to be addressed in the future.
> > 
> > Hi Razvan
> > 
> > Could you briefly describe how Ethernet frames get from the CPU to the
> > switch. This is what decided if you should write a plain switchdev
> > driver, or a DSA driver.
> > 
> > 	Andrew
> > 
> Hello Andrew,
> 
> CPU frame handling will be added in a later. Each netdevice associated 
> to a switch port will have I/O capabilities like dpaa2-ethernet devices.
> The dpaa2-ethsw will use ACLs to redirect specific types of frames
> (i.e BPDUs) to CPU.

Hi Razvan

I looked at the architecture documentation after i posted this
email. It looks like each switch port will get its own DMA queues, etc
on the host. It is not sharing one host interface to get packets to
the switch, which is what DSA does. So a pure switchdev driver is the
correct solution here.

      Andrew
