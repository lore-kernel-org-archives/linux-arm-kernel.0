From: jasmin@beck.ac (Jasmin Beck)
Date: Tue, 13 Jun 2017 00:29:09 +0200
Subject: mvneta MDIO problems
In-Reply-To: <20170131030601.GD21740@lunn.ch>
References: <1485351412.5441.82.camel@beck.ac>
 <20170130103628.09178f50@free-electrons.com>
 <20170131030601.GD21740@lunn.ch>
Message-ID: <1497306549.28190.36.camel@beck.ac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi @all,

meanwhile I have managed to gather some tracing information
(mdio_access) using the following kernel:

4.10.0-rc6-armmp #1 SMP Debian 4.10~rc6-1~exp2 (2017-02-02) armv7l GNU/Linux

The system was running fine for months using kernel 4.8 with
mdio_access patch, then I upgraded to 4.9 (and rebooted, of course). It
started to fail a few hours later, so I decided to install 4.10 (from
debian experimental, including mdio_access patch) and it failed again
~4175 seconds after reboot.

Please see the combined text-file attached.

Possibly there is a problem on the mdio bus?

?????kworker/0:1-1569??[000] ....??4175.955834: mdio_access: d0072004.mdio-mi read??phy:0x00 reg:0x01 val:0xffff
?????kworker/0:1-1569??[000] ....??4175.955915: mdio_access: d0072004.mdio-mi read??phy:0x00 reg:0x01 val:0xffff
?????kworker/0:1-1569??[000] ....??4175.955994: mdio_access: d0072004.mdio-mi read??phy:0x00 reg:0x11 val:0xffff
?????kworker/0:1-1569??[000] ....??4175.956069: mdio_access: d0072004.mdio-mi read??phy:0x00 reg:0x05 val:0xffff
?????kworker/0:1-1569??[000] ....??4175.956144: mdio_access: d0072004.mdio-mi read??phy:0x00 reg:0x0a val:0xffff
?????kworker/0:1-1569??[000] ....??4175.956218: mdio_access: d0072004.mdio-mi read??phy:0x00 reg:0x04 val:0xffff

Kind Regards
Jasmin


On Tue, 2017-01-31 at 04:06 +0100, Andrew Lunn wrote:
> > > After some days (1-20 ?) uptime, the kernel 4.8.11 logs:
> > > 
> > > [779752.514644] mvneta d0070000.ethernet eth0: Link is Up -
> > > 1Gbps/Full - flow control off
> > > [783518.193094] mvneta d0070000.ethernet eth0: Link is Down
> > > [783519.229922] mvneta d0070000.ethernet eth0: Link is Up -
> > > 1Gbps/Full - flow control off
> > > [789431.374474] mvneta d0070000.ethernet eth0: Link is Down
> > > [804522.151348] mvneta d0070000.ethernet eth0: Link is Up -
> > > 1Gbps/Full - flow control off
> > > [804530.474111] mvneta d0070000.ethernet eth0: Link is Down
> > > [804532.550916] mvneta d0070000.ethernet eth0: Link is Up -
> > > 1Gbps/Full - flow control off
> > > [806254.718708] mvneta d0070000.ethernet eth0: Link is Down
> > > 
> > > ... so sooner or later, the link stays down (let's call this
> > > "failed state")
> 
> I've not seen this, but i blew my mirabox up, wrong power supply :-(
> 
> I've also not heard of problems with other Marvell devices. So i
> would
> guess it is something specific to this SoC and PHY.
> 
> > > I have no idea on how to debug this... the system is currently in
> > > "failed state", kernel source and compiler are available on the
> > > box
> > > (e.g. for unloading, modifying, compiling and loading mvneta.ko
> > > again),
> > > which is currently "offline", but can be accessed through the
> > > serial
> > > console.
> 
> Does you kernel have:
> 
> commit e22e996b72d47c7bf5bb6b17071b2e9d3db462d4
> Author: Uwe Kleine-K??nig <uwe@kleine-koenig.org>
> Date:???Tue Nov 22 16:47:11 2016 +0100
> 
> ????net/phy: add trace events for mdio accesses
> ????
> ????Make it possible to generate trace events for mdio read and write
> accesses.
> 
> and are trace points compiled in? I've never used it, but it should
> be
> possible to log the mdio reads/writes. I would be interested to see
> the values. Reads of 0xffff indicate the PHY did not answer at all.
> Or
> are there bit flips?
> 
> ????Andrew
-------------- next part --------------
        mii-tool-1122  [000] ....  1492.718533: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x00 val:0x1000
        mii-tool-1122  [000] ....  1492.718636: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
        mii-tool-1122  [000] ....  1492.718721: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x00 val:0x1000
        mii-tool-1122  [000] ....  1492.718804: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
        mii-tool-1122  [000] ....  1492.718906: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x02 val:0x0141
        mii-tool-1122  [000] ....  1492.718991: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x03 val:0x0dd1
        mii-tool-1122  [000] ....  1492.719075: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
        mii-tool-1122  [000] ....  1492.719159: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
        mii-tool-1122  [000] ....  1492.719242: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x06 val:0x000d
        mii-tool-1122  [000] ....  1492.719324: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x07 val:0x2001
        mii-tool-1122  [000] ....  1492.719407: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x08 val:0x489c
        mii-tool-1122  [000] ....  1492.719489: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x09 val:0x0300
        mii-tool-1122  [000] ....  1492.719572: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:1-20    [000] ....  1493.210578: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:1-20    [000] ....  1493.210663: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:1-20    [000] ....  1493.210740: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac08
     kworker/0:1-20    [000] ....  1493.210818: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:1-20    [000] ....  1493.210894: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:1-20    [000] ....  1493.210969: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-20    [000] ....  1493.594562: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-20    [000] ....  1493.594645: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-20    [000] ....  1493.594723: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac48
     kworker/0:1-20    [000] ....  1493.594799: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-20    [000] ....  1493.594875: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-20    [000] ....  1493.594950: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
        mii-tool-1123  [000] ....  1494.102510: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x00 val:0x1000
        mii-tool-1123  [000] ....  1494.102615: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
        mii-tool-1123  [000] ....  1494.102700: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x00 val:0x1000
        mii-tool-1123  [000] ....  1494.102783: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
        mii-tool-1123  [000] ....  1494.102866: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x02 val:0x0141
        mii-tool-1123  [000] ....  1494.102948: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x03 val:0x0dd1
        mii-tool-1123  [000] ....  1494.103031: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
        mii-tool-1123  [000] ....  1494.103115: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
        mii-tool-1123  [000] ....  1494.103200: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x06 val:0x000d
        mii-tool-1123  [000] ....  1494.103282: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x07 val:0x2001
        mii-tool-1123  [000] ....  1494.103365: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x08 val:0x4cc7
        mii-tool-1123  [000] ....  1494.103448: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x09 val:0x0300
        mii-tool-1123  [000] ....  1494.103530: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800

     kworker/0:1-1569  [000] ....  4173.908033: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4173.908117: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4173.908194: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4173.908271: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4173.908348: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4173.908423: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4174.291995: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4174.292078: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4174.292155: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4174.292231: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4174.292305: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4174.292380: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:3-1170  [000] ....  4174.931949: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:3-1170  [000] ....  4174.932030: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:3-1170  [000] ....  4174.932105: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac08
     kworker/0:3-1170  [000] ....  4174.932179: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:3-1170  [000] ....  4174.932266: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:3-1170  [000] ....  4174.933303: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4175.315893: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4175.315974: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4175.316050: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4175.316126: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4175.316210: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4175.316287: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4175.955834: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0xffff
     kworker/0:1-1569  [000] ....  4175.955915: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0xffff
     kworker/0:1-1569  [000] ....  4175.955994: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xffff
     kworker/0:1-1569  [000] ....  4175.956069: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xffff
     kworker/0:1-1569  [000] ....  4175.956144: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0xffff
     kworker/0:1-1569  [000] ....  4175.956218: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0xffff
     kworker/0:1-1569  [000] ....  4176.339789: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4176.339876: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4176.339952: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4176.340028: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4176.340102: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4176.340177: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4176.979741: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0xffff
     kworker/0:1-1569  [000] ....  4176.979823: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0xffff
     kworker/0:1-1569  [000] ....  4176.979899: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xffff
     kworker/0:1-1569  [000] ....  4176.979974: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xffff
     kworker/0:1-1569  [000] ....  4176.980049: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0xffff
     kworker/0:1-1569  [000] ....  4176.980123: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0xffff
     kworker/0:3-1170  [000] ....  4177.363714: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:3-1170  [000] ....  4177.363798: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:3-1170  [000] ....  4177.363874: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:3-1170  [000] ....  4177.363950: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:3-1170  [000] ....  4177.364041: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:3-1170  [000] ....  4177.364117: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4178.003638: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0xffff
     kworker/0:1-1569  [000] ....  4178.003720: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0xffff
     kworker/0:1-1569  [000] ....  4178.003796: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xffff
     kworker/0:1-1569  [000] ....  4178.003871: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xffff
     kworker/0:1-1569  [000] ....  4178.003946: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0xffff
     kworker/0:1-1569  [000] ....  4178.004021: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0xffff
     kworker/0:1-1569  [000] ....  4178.387600: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4178.387684: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4178.387765: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4178.387841: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4178.387916: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4178.387990: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4179.027542: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4179.027624: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4179.027700: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:1-1569  [000] ....  4179.027776: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0000
     kworker/0:1-1569  [000] ....  4179.027851: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:1-1569  [000] ....  4179.027928: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4179.411498: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4179.411580: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4179.411655: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4179.411731: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4179.411809: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4179.411883: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4180.051444: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4180.051526: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4180.051604: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:1-1569  [000] ....  4180.051679: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0000
     kworker/0:1-1569  [000] ....  4180.051754: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:1-1569  [000] ....  4180.051828: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1

[ 4180.055059] mvneta d0070000.ethernet eth0: Link is Down

     kworker/0:1-1569  [000] ....  4180.435412: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4180.435492: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4180.435566: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4180.435637: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4180.435707: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4180.435780: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:3-1170  [000] ....  4181.075308: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1170  [000] ....  4181.075386: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1170  [000] ....  4181.075461: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x4800
     kworker/0:3-1170  [000] ....  4181.075533: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:3-1170  [000] ....  4181.075603: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:3-1170  [000] ....  4181.075673: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4181.459299: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4181.459379: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4181.459451: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4181.459521: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4181.459591: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4181.459661: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4182.099227: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4182.099307: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4182.099379: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:1-1569  [000] ....  4182.099449: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:1-1569  [000] ....  4182.099518: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:1-1569  [000] ....  4182.099587: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4182.483176: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4182.483254: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4182.483326: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4182.483397: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4182.483467: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4182.483537: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4183.123125: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4183.123204: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4183.123275: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:1-1569  [000] ....  4183.123345: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:1-1569  [000] ....  4183.123417: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:1-1569  [000] ....  4183.123487: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:3-1170  [000] ....  4183.507087: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:3-1170  [000] ....  4183.507167: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:3-1170  [000] ....  4183.507238: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:3-1170  [000] ....  4183.507310: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:3-1170  [000] ....  4183.507380: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:3-1170  [000] ....  4183.507451: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4184.147026: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4184.147105: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4184.147179: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x4800
     kworker/0:1-1569  [000] ....  4184.147249: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:1-1569  [000] ....  4184.147319: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:1-1569  [000] ....  4184.147389: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4184.531003: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4184.531084: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4184.531155: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4184.531225: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4184.531295: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4184.531365: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4185.170952: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4185.171030: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:1-1569  [000] ....  4185.171103: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:1-1569  [000] ....  4185.171173: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:1-1569  [000] ....  4185.171243: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:1-1569  [000] ....  4185.171313: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1569  [000] ....  4185.554904: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4185.554982: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:1-1569  [000] ....  4185.555054: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:1-1569  [000] ....  4185.555125: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:1-1569  [000] ....  4185.555195: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:1-1569  [000] ....  4185.555264: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1

     kworker/0:3-1871  [000] ....  6334.414086: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6334.414169: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6334.414244: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:3-1871  [000] ....  6334.414317: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:3-1871  [000] ....  6334.414389: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6334.414463: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6334.798087: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6334.798167: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6334.798239: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0xac08
     kworker/0:2-1824  [000] ....  6334.798310: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6334.798382: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x3800
     kworker/0:2-1824  [000] ....  6334.798452: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:3-1871  [000] ....  6335.438067: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6335.438149: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6335.438225: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x4800
     kworker/0:3-1871  [000] ....  6335.438297: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:3-1871  [000] ....  6335.438370: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6335.438444: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:3-1871  [000] ....  6335.822111: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6335.822193: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6335.822279: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:3-1871  [000] ....  6335.822360: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0000
     kworker/0:3-1871  [000] ....  6335.822449: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6335.822545: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:3-1871  [000] ....  6336.462035: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6336.462117: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6336.462193: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:3-1871  [000] ....  6336.462284: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:3-1871  [000] ....  6336.462363: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6336.462439: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:3-1871  [000] ....  6336.846031: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6336.846112: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6336.846188: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:3-1871  [000] ....  6336.846263: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0000
     kworker/0:3-1871  [000] ....  6336.846342: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6336.846428: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1

[ 6336.849659] mvneta d0074000.ethernet eth1: Link is Down

     kworker/0:3-1871  [000] ....  6337.486022: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6337.486114: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6337.486191: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:3-1871  [000] ....  6337.486267: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:3-1871  [000] ....  6337.486341: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6337.486416: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:3-1871  [000] ....  6337.870020: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6337.870101: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6337.870177: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x4800
     kworker/0:3-1871  [000] ....  6337.870252: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:3-1871  [000] ....  6337.870326: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6337.870404: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6338.509997: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6338.510079: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6338.510158: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x4800
     kworker/0:2-1824  [000] ....  6338.510233: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6338.510307: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6338.510381: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:3-1871  [000] ....  6338.894003: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6338.894088: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:3-1871  [000] ....  6338.894164: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:3-1871  [000] ....  6338.894238: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:3-1871  [000] ....  6338.894314: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:3-1871  [000] ....  6338.894388: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6559.687650: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6559.687732: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6559.687808: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6559.687882: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6559.687957: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6559.688032: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6560.071640: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6560.071721: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6560.071797: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6560.071873: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6560.071948: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6560.072025: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6560.711613: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6560.711694: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6560.711770: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6560.711848: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6560.711923: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6560.711999: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1980  [000] ....  6561.095591: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:1-1980  [000] ....  6561.095680: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:1-1980  [000] ....  6561.095759: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x4800
     kworker/0:1-1980  [000] ....  6561.095835: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:1-1980  [000] ....  6561.095911: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:1-1980  [000] ....  6561.095986: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6561.735586: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6561.735667: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6561.735747: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x4800
     kworker/0:2-1824  [000] ....  6561.735822: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6561.735896: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6561.735971: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0xffff
     kworker/0:2-1824  [000] ....  6562.119570: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6562.119653: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6562.119730: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6562.119805: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6562.119880: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6562.119955: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6562.759562: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6562.759644: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6562.759721: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6562.759796: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0x0000
     kworker/0:2-1824  [000] ....  6562.759881: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6562.759958: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6563.143537: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6563.143618: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6563.143695: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6563.143769: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6563.143845: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6563.143919: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6563.783516: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6563.783598: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6563.783673: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0x9040
     kworker/0:2-1824  [000] ....  6563.783748: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6563.783825: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x4000
     kworker/0:2-1824  [000] ....  6563.783900: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6564.167501: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6564.167584: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6564.167663: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x4800
     kworker/0:2-1824  [000] ....  6564.167739: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6564.167816: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6564.167891: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:1-1980  [000] ....  6564.807481: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x7969
     kworker/0:1-1980  [000] ....  6564.807565: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:1-1980  [000] ....  6564.807640: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xbc48
     kworker/0:1-1980  [000] ....  6564.807715: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:1-1980  [000] ....  6564.807790: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:1-1980  [000] ....  6564.807865: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1980  [000] ....  6564.807941: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d

[ 6564.807974] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off

     kworker/0:2-1824  [000] ....  6565.191465: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6565.191547: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6565.191623: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6565.191698: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6565.191773: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6565.191847: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6565.831444: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6565.831526: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6565.831602: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:2-1824  [000] ....  6565.831676: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6565.831751: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:2-1824  [000] ....  6565.831825: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6566.215450: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6566.215532: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6566.215607: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6566.215683: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6566.215757: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6566.215832: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6566.855418: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6566.855499: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6566.855575: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:2-1824  [000] ....  6566.855650: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6566.855726: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:2-1824  [000] ....  6566.855800: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:1-1980  [000] ....  6567.239388: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:1-1980  [000] ....  6567.239470: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:1-1980  [000] ....  6567.239545: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x4800
     kworker/0:1-1980  [000] ....  6567.239620: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:1-1980  [000] ....  6567.239695: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:1-1980  [000] ....  6567.239772: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6567.879370: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6567.879449: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6567.879522: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:2-1824  [000] ....  6567.879593: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6567.879663: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:2-1824  [000] ....  6567.879734: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6568.263341: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6568.263420: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6568.263492: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6568.263563: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6568.263633: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6568.263703: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6568.903322: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6568.903401: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6568.903476: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:2-1824  [000] ....  6568.903548: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6568.903619: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:2-1824  [000] ....  6568.903689: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6569.287303: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6569.287383: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:2-1824  [000] ....  6569.287455: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:2-1824  [000] ....  6569.287526: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:2-1824  [000] ....  6569.287596: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:2-1824  [000] ....  6569.287666: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:2-1824  [000] ....  6569.927286: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6569.927365: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:2-1824  [000] ....  6569.927437: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:2-1824  [000] ....  6569.927512: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:2-1824  [000] ....  6569.927583: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:2-1824  [000] ....  6569.927653: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1

        mii-tool-2065  [000] ....  6940.800130: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x00 val:0x1140
        mii-tool-2065  [000] ....  6940.800219: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
        mii-tool-2065  [000] ....  6940.800297: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x00 val:0x1140
        mii-tool-2065  [000] ....  6940.800374: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
        mii-tool-2065  [000] ....  6940.800451: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x02 val:0x0141
        mii-tool-2065  [000] ....  6940.800528: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x03 val:0x0dd1
        mii-tool-2065  [000] ....  6940.800605: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
        mii-tool-2065  [000] ....  6940.800682: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
        mii-tool-2065  [000] ....  6940.800758: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x06 val:0x000d
        mii-tool-2065  [000] ....  6940.800836: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x07 val:0x2001
        mii-tool-2065  [000] ....  6940.800967: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x08 val:0x4d23
        mii-tool-2065  [000] ....  6940.801049: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x09 val:0x0300
        mii-tool-2065  [000] ....  6940.801127: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:0-1922  [000] ....  6940.985034: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:0-1922  [000] ....  6940.985112: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:0-1922  [000] ....  6940.985184: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:0-1922  [000] ....  6940.985254: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:0-1922  [000] ....  6940.985325: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:0-1922  [000] ....  6940.985395: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:0-1922  [000] ....  6941.625001: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:0-1922  [000] ....  6941.625080: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:0-1922  [000] ....  6941.625152: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:0-1922  [000] ....  6941.625222: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:0-1922  [000] ....  6941.625292: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:0-1922  [000] ....  6941.625363: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
     kworker/0:0-1922  [000] ....  6942.008975: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:0-1922  [000] ....  6942.009054: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
     kworker/0:0-1922  [000] ....  6942.009126: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x11 val:0x8000
     kworker/0:0-1922  [000] ....  6942.009196: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
     kworker/0:0-1922  [000] ....  6942.009267: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
     kworker/0:0-1922  [000] ....  6942.009337: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
     kworker/0:0-1922  [000] ....  6942.649008: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:0-1922  [000] ....  6942.649092: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x01 val:0x796d
     kworker/0:0-1922  [000] ....  6942.649171: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x11 val:0xac48
     kworker/0:0-1922  [000] ....  6942.649250: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x05 val:0xc001
     kworker/0:0-1922  [000] ....  6942.649327: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x0a val:0x3800
     kworker/0:0-1922  [000] ....  6942.649404: mdio_access: d0072004.mdio-mi read  phy:0x00 reg:0x04 val:0x01e1
        mii-tool-2066  [000] ....  6942.780185: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x00 val:0x1140
        mii-tool-2066  [000] ....  6942.780272: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
        mii-tool-2066  [000] ....  6942.780353: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x00 val:0x1140
        mii-tool-2066  [000] ....  6942.780434: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x01 val:0x7949
        mii-tool-2066  [000] ....  6942.780513: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x02 val:0x0141
        mii-tool-2066  [000] ....  6942.780591: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x03 val:0x0dd1
        mii-tool-2066  [000] ....  6942.780669: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x04 val:0x01e1
        mii-tool-2066  [000] ....  6942.780748: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x05 val:0x0081
        mii-tool-2066  [000] ....  6942.780884: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x06 val:0x0004
        mii-tool-2066  [000] ....  6942.780972: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x07 val:0x2001
        mii-tool-2066  [000] ....  6942.781052: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x08 val:0x0000
        mii-tool-2066  [000] ....  6942.781131: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x09 val:0x0300
        mii-tool-2066  [000] ....  6942.781210: mdio_access: d0072004.mdio-mi read  phy:0x01 reg:0x0a val:0x0000
