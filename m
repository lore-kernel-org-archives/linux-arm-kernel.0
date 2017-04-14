From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 14 Apr 2017 22:32:16 +0200
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <1492091578.2383.39.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
 <20170404124732.GD3288@valkosipuli.retiisi.org.uk>
 <1492091578.2383.39.camel@pengutronix.de>
Message-ID: <20170414203216.GA10920@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > The MUX framework is already in linux-next. Could you use that instead of
> > adding new driver + bindings that are not compliant with the MUX framework?
> > I don't think it'd be much of a change in terms of code, using the MUX
> > framework appears quite simple.
> 
> It is not quite clear to me how to design the DT bindings for this. Just
> splitting the video-multiplexer driver from the mux-mmio / mux-gpio
> would make it necessary to keep the video-multiplexer node to describe
> the of-graph bindings. But then we have two different nodes in the DT
> that describe the same hardware:
> 
> 	mux: mux {
> 		compatible = "mux-gpio";
> 		mux-gpios = <&gpio 0>, <&gpio 1>;
> 		#mux-control-cells = <0>;
> 	}
> 
> 	video-multiplexer {
> 		compatible = "video-multiplexer"
> 		mux-controls = <&mux>;
> 
> 		ports {
> 			/* ... */
> 		}
> 	}
> 
> It would feel more natural to have the ports in the mux node, but then
> how would the video-multiplexer driver be instanciated, and how would it
> get to the of-graph nodes?

Device tree representation and code used to implement the muxing
driver should be pretty independend, no? Yes, one piece of hardware
should have one entry in the device tree, so it should be something
like:


 	video-multiplexer {
 		compatible = "video-multiplexer-gpio"	
 		mux-gpios = <&gpio 0>, <&gpio 1>;
 		#mux-control-cells = <0>;

 		mux-controls = <&mux>;
 
 		ports {
 			/* ... */
 		}
 	}

You should be able to use code in drivers/mux as a library...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170414/381bc993/attachment.sig>
