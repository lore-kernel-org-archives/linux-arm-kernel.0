From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Jul 2016 11:02:26 +0200
Subject: [PATCH 2/2] dt-bindings: add simple-panel-dsi and simple-panel
In-Reply-To: <5796C47C.5040208@rock-chips.com>
References: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
 <1468984730-23186-2-git-send-email-mark.yao@rock-chips.com>
 <20160725152125.GS21170@ulmo.ba.sec>
 <5796C47C.5040208@rock-chips.com>
Message-ID: <20160726090226.GB2433@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 10:01:32AM +0800, Mark yao wrote:
> On 2016?07?25? 23:21, Thierry Reding wrote:
> 
>     On Wed, Jul 20, 2016 at 11:18:50AM +0800, Mark Yao wrote:
> 
>         Allow user add display timing on device tree with simple-panel-dsi
>         or simple-panel.
> 
>         Cc: Thierry Reding <thierry.reding@gmail.com>
>         Cc: Rob Herring <robh+dt@kernel.org>
>         Cc: Mark Rutland <mark.rutland@arm.com>
> 
>         Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>         ---
>          .../bindings/display/panel/simple-panel.txt        | 48 ++++++++++++++++++++++
>          1 file changed, 48 insertions(+)
> 
>     Sorry, not going to happen. Read this for an explanation of why not:
> 
>             https://sietch-tagr.blogspot.de/2016/04/display-panels-are-not-special.html
> 
>     Thierry
> 
> 
> Hi Thierry
> 
> The blog actually not persuade me why can't use display timing on
> device tree.

Okay, perhaps read it again, it addresses most of your points below.

> 1, Binding panel as a simple string on device tree seems simple on device tree,
> but it's complex on kernel code, and kernel code would became bigger and
> bigger.

I don't think the video timings in the simple-panel driver are very
complex. They also don't use very much space. And if you're really
concerned about space you can always use conditional compilation and
Kconfig symbols to remove timings for panels that you don't use.

Also, panels are characterized by much more than just video timings.
There were attempts, way back, to fully describe panels in device tree
and that failed. What you propose here is a partial solution to a much
more complex problem.

This is all explained in the blog post.

> 2, Our customer always ask me, where is the display timing? They only find a
> simple panel string on device tree,? need search the kernel code to find the
> actually timing. They are used to find all device info on device tree, but
> panel timing info is not, this would confuse them. They don't want to know how
> code work, just want a easier interface.

That's not a very good argument. There's plenty of data that's not in
device tree for other devices, why should panels be different? Also, I
would hope that any customer of yours knows their way around kernel
code and can therefore easily add video timings for new panels. It's
quite trivial to do, and there are many examples on how to do it.

> 3, I think device tree not only can use for kernel, other module also can use
> it. on our project, we use uboot + kernel, the uboot support fdt, that function
> can parsing device tree. So if describe the display timing on device tree, both
> uboot and kernel can share same display timing, not need to describe twice, it
> would save work and not easy to make mistake.

That's a bit of a stretch. Video timings is fairly straightforward data
and can be easily added to any other piece of code that you want to run.
Yes you will have to duplicate the data, but how is that different from
duplicating all the driver code?

> 4, For differentiation product, we face many different panel, every once in a
> while, need to add a new panel, we can't convert all the panel , code the panel
> on kernel seems too bad, and the kernel image became bigger and bigger.

Why can't you convert all the panels? We already support a bunch of them
and haven't yet run into any problems. If you do encounter any issues
trying to port panels to the DRM panel infrastructure, please let me
know and I can help sort them out.

The kernel image size isn't a problem either. In any modern kernel the
video timing data in the panel driver is tiny compared to the rest.

> Generally, Our customer don't want to do any modify on kernel, they just modify
> device tree to bring up their device. Describe the panel timing on device tree,
> would make customer easy to use and reuse it.

Yes, that would perhaps make it easier for them to bring up the device.
But soon after they'll notice that there are glitches when turning the
panel on and off, and then they'll realize that they can't fix that
using their simple device tree.

All of that said, if you do think this is valuable to your customers,
please feel free to ship these patches in your downstream tree.

Also, though this is a bit off topic, I'm sure that your customers'
customers would be very happy to get all the security and bug fixes that
would automatically be delivered with the frequent kernel updates that
bring in support for new panels.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/b075159b/attachment-0001.sig>
