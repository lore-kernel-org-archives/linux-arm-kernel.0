From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Jul 2016 16:24:27 +0200
Subject: [PATCH 2/2] dt-bindings: add simple-panel-dsi and simple-panel
In-Reply-To: <CAL_JsqL8D3OK_JQcY+dLTcqcvmgB2Vuc0Tknf1zsR=8Pa3F4jw@mail.gmail.com>
References: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
 <1468984730-23186-2-git-send-email-mark.yao@rock-chips.com>
 <20160725152125.GS21170@ulmo.ba.sec>
 <5796C47C.5040208@rock-chips.com>
 <20160726090226.GB2433@ulmo.ba.sec>
 <CAL_JsqL8D3OK_JQcY+dLTcqcvmgB2Vuc0Tknf1zsR=8Pa3F4jw@mail.gmail.com>
Message-ID: <20160729142427.GB3864@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 02:00:21PM -0500, Rob Herring wrote:
> On Tue, Jul 26, 2016 at 4:02 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Jul 26, 2016 at 10:01:32AM +0800, Mark yao wrote:
> >> On 2016?07?25? 23:21, Thierry Reding wrote:
> >>
> >>     On Wed, Jul 20, 2016 at 11:18:50AM +0800, Mark Yao wrote:
> >>
> >>         Allow user add display timing on device tree with simple-panel-dsi
> >>         or simple-panel.
> >>
> >>         Cc: Thierry Reding <thierry.reding@gmail.com>
> >>         Cc: Rob Herring <robh+dt@kernel.org>
> >>         Cc: Mark Rutland <mark.rutland@arm.com>
> >>
> >>         Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> >>         ---
> >>          .../bindings/display/panel/simple-panel.txt        | 48 ++++++++++++++++++++++
> >>          1 file changed, 48 insertions(+)
> >>
> >>     Sorry, not going to happen. Read this for an explanation of why not:
> >>
> >>             https://sietch-tagr.blogspot.de/2016/04/display-panels-are-not-special.html
> >>
> >>     Thierry
> >>
> >>
> >> Hi Thierry
> >>
> >> The blog actually not persuade me why can't use display timing on
> >> device tree.
> >
> > Okay, perhaps read it again, it addresses most of your points below.
> >
> >> 1, Binding panel as a simple string on device tree seems simple on device tree,
> >> but it's complex on kernel code, and kernel code would became bigger and
> >> bigger.
> >
> > I don't think the video timings in the simple-panel driver are very
> > complex. They also don't use very much space. And if you're really
> > concerned about space you can always use conditional compilation and
> > Kconfig symbols to remove timings for panels that you don't use.
> >
> > Also, panels are characterized by much more than just video timings.
> > There were attempts, way back, to fully describe panels in device tree
> > and that failed. What you propose here is a partial solution to a much
> > more complex problem.
> >
> > This is all explained in the blog post.
> 
> While I agree with everything Thierry has said in this thread, there
> is an argument to be made for timing information in DT.
> 
> Maybe most vendors have now learned that flexible clock frequencies
> are needed to generate the correct timings, but I have worked on parts
> without fine resolution (i.e. a dedicated pll). Even HiKey with HDMI
> suffers from this. In that case you can be tuning the timings
> (increasing the h and/or v blanks) to get the desired refresh rates.
> So in that case, the panel compatible would not determine the display
> timings and you could have the same panel with different timings on
> different boards. That's maybe rare enough that putting timing info in
> DT still wouldn't make sense.

There's another mechanism, though not very popular (possibly because it
is indeed a very rare usecase), that we introduced a while ago. The idea
is that we don't specify the mode per panel, as we do now, but rather a
range of values that are valid for the various video timing parameters.
These set can usually be copied from some datasheet and are represented
by (minimum, typical, maximum) triplets. So drivers for display hardware
would query the timings in this way, try to establish a working mode
from the typical values and tweak as necessary by adjusting the values
within the limits given by (minimum, maximum).

One disadvantage of this is that it becomes somewhat more complicated to
write the display driver, but I think that's an easy problem to solve by
adding some common helpers (I'm thinking one that takes as input the
target clock frequency and the timing ranges and outputs a mode with the
porches adjusted to match the target clock frequency as closely as
possible).

The big advantage is, of course, that device trees become trivial to
write and people don't have to manually stitch together timings to get
to the desired result.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160729/fd6558a0/attachment-0001.sig>
