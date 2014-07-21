From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Jul 2014 15:33:50 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <2273675.A51UonkrgF@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143321.5bda6ea9@bbrezillon> <20140721125624.GF15238@ulmo>
 <2273675.A51UonkrgF@avalon>
Message-ID: <20140721133348.GJ15238@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:26:12PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
> 
> On Monday 21 July 2014 14:56:26 Thierry Reding wrote:
> > On Mon, Jul 21, 2014 at 02:33:21PM +0200, Boris BREZILLON wrote:
> > > On Mon, 21 Jul 2014 14:15:16 +0200 Thierry Reding wrote:
> > >> On Fri, Jul 18, 2014 at 04:51:52PM +0200, Boris BREZILLON wrote:
> > >>> On Tue, 15 Jul 2014 12:31:37 +0200 Thierry Reding wrote:
> > >>>> On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> > >>>>> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > >>>>>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> 
> [snip]
> 
> > >>>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> > >>>>>>> +   The first cell is a phandle to a DRM panel device
> > >>>>>>> +   The second cell encodes the RGB mode, which can take the
> > >>>>>>> following values: +   * 0: RGB444
> > >>>>>>> +   * 1: RGB565
> > >>>>>>> +   * 2: RGB666
> > >>>>>>> +   * 3: RGB888
> > >>>>>> 
> > >>>>>> These are properties of the panel and should be obtained from
> > >>>>>> the panel directly rather than an additional cell in this
> > >>>>>> specifier.
> > >>>>> 
> > >>>>> Okay.
> > >>>>> What's the preferred way of doing this ?
> > >>>>> What about defining an rgb-mode property in the panel node.
> 
> [snip]
> 
> > >>>> Also, like Laurent said, this shouldn't go into the device tree,
> > >>>> since it's already implied by the panel's compatible value, so we'd
> > >>>> be duplicating information.
> > >>> 
> > >>> Again, this is not necessarily true (depending on your board design).
> > >>> One can decide to connect an RGB888 panel on an RGB666 bus and connect
> > >>> the missing pins to ground.
> > >> 
> > >> I think in that case the board design itself could be considered as an
> > >> RGB888 to RGB666 bridge, and I think that's what the device tree should
> > >> be describing rather than a panel with a variable number of input
> > >> formats.
> > > 
> > > So, you're suggesting to add an RGB to RGB drm_bridge driver (and
> > > the appropriate DT bindings) to handle this case, right ?
> > 
> > Yes, exactly.
> 
> Wouldn't it be possible to implement RGB666 -> RGB888 support in a less 
> complex way ? A standalone driver to describe signal routing seems like an 
> overly complex solution to me. I would prefer making the routing a properly of 
> the link instead of a separate device.

I don't think the above is overly complex. After all the panel expects
RGB888, so it makes no sense to make it "configurable" to anything else.
Similarly if the encoder or bridge provides RGB666 then that's a fixed
function, too. So to represent this combination accurately you'll need
some form of translation entity inbetween, and it may just as well be a
bridge than something custom for that particular link.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/59b85ab0/attachment.sig>
