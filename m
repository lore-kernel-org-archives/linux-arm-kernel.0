From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 16 Sep 2013 12:53:18 +1000
Subject: [PATCH v3 2/2] drivers: dma-contiguous: add initialization from
 device tree
In-Reply-To: <CACxGe6uzau+g0gd=hkNYw1zdkfq18zt_m9OEaiJKR6=q1U4rag@mail.gmail.com>
References: <1372254009-25307-1-git-send-email-m.szyprowski@samsung.com>
 <1372254009-25307-3-git-send-email-m.szyprowski@samsung.com>
 <CACxGe6uzau+g0gd=hkNYw1zdkfq18zt_m9OEaiJKR6=q1U4rag@mail.gmail.com>
Message-ID: <1379299998.4098.74.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-07-11 at 15:56 +0100, Grant Likely wrote:

> > +contiguous-memory {
> > +
> > +       (name): region@(base-address) {
> > +               reg = <(baseaddr) (size)>;
> > +               (linux,default-contiguous-region);
> > +               device = <&device_0 &device_1 ...>
> > +       };
> > +};
> 
> Okay, I've gone and read all of the backlog on the 3 versions of the
> patch series, and I think I understand the issues. I actually think it
> was better off to have the regions specified as children of the memory
> node. I understand the argument about how would firmware know what
> size the kernel wants and that it would be better to have a kernel
> parameter to override the default. However, it is also reasonable for
> the kernel to be provided with a default amount of CMA based on the
> usage profile of the device. In that regard it is absolutely
> appropriate to put the CMA region data into the memory node. I don't
> think /chosen is the right place for that.

Picking up on that old thread after the rant I just posted ... Grant,
your proposal is all wrong.

First we already had a proposal for reserved memory, which due to the
complete lack of comment, we actually merged support for in powerpc in
3.11, second, do NOT make that a child of "memory". See the email I just
posted today for more details about the breakage in that proposal.

I'm advocating a revert at this stage.

Ben.
