From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Mar 2017 18:59:59 +0000
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <1f1b350a-5523-34bc-07b7-f3cd2d1fd4c1@gmail.com>
References: <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310120902.1daebc7b@vento.lan>
 <5e1183f4-774f-413a-628a-96e0df321faf@xs4all.nl>
 <20170311101408.272a9187@vento.lan>
 <20170311153229.yrdjmggb3p2suhdw@ihha.localdomain>
 <acfb5eca-ff00-6d57-339a-3322034cbdb3@gmail.com>
 <20170311184551.GD21222@n2100.armlinux.org.uk>
 <1f1b350a-5523-34bc-07b7-f3cd2d1fd4c1@gmail.com>
Message-ID: <20170311185959.GF21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 10:54:55AM -0800, Steve Longerbeam wrote:
> 
> 
> On 03/11/2017 10:45 AM, Russell King - ARM Linux wrote:
> >I really don't think expecting the user to understand and configure
> >the pipeline is a sane way forward.  Think about it - should the
> >user need to know that, because they have a bayer-only CSI data
> >source, that there is only one path possible, and if they try to
> >configure a different path, then things will just error out?
> >
> >For the case of imx219 connected to iMX6, it really is as simple as
> >"there is only one possible path" and all the complexity of the media
> >interfaces/subdevs is completely unnecessary.  Every other block in
> >the graph is just noise.
> >
> >The fact is that these dot graphs show a complex picture, but reality
> >is somewhat different - there's only relatively few paths available
> >depending on the connected source and the rest of the paths are
> >completely useless.
> >
> 
> I totally disagree there. Raw bayer requires passthrough yes, but for
> all other media bus formats on a mipi csi-2 bus, and all other media
> bus formats on 8-bit parallel buses, the conersion pipelines can be
> used for scaling, CSC, rotation, and motion-compensated de-interlacing.

... which only makes sense _if_ your source can produce those formats.
We don't actually disagree on that.

Let me re-state.  If the source can _only_ produce bayer, then there is
_only_ _one_ possible path, and all the overhead of the media controller
stuff is totally unnecessary.

Or, are you going to tell me that the user should have the right to
configure paths through the iMX6 hardware that are not permitted by the
iMX6 manuals for the data format being produced by the sensor?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
