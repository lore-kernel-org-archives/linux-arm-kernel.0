From: atull@opensource.altera.com (atull)
Date: Fri, 7 Oct 2016 13:21:15 -0500
Subject: [PATCH 1/3] fpga manager: Add cyclonespi driver for Altera fpgas
In-Reply-To: <CAAtXAHcWLpn3DFP6YLWqBxsMQ0O=HNNCmB+kHbHhyAHFHQUbwA@mail.gmail.com>
References: <cover.1475783742.git.stillcompiling@gmail.com>
 <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
 <CAAtXAHcWLpn3DFP6YLWqBxsMQ0O=HNNCmB+kHbHhyAHFHQUbwA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1610071248320.32627@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Oct 2016, Moritz Fischer wrote:

> > +static inline u32 revbit8x4(u32 n)
> > +{
> > +       n = ((n & 0xF0F0F0F0UL) >> 4) | ((n & 0x0F0F0F0FUL) << 4);
> > +       n = ((n & 0xCCCCCCCCUL) >> 2) | ((n & 0x33333333UL) << 2);
> > +       n = ((n & 0xAAAAAAAAUL) >> 1) | ((n & 0x55555555UL) << 1);
> > +       return n;
> > +}
> 
> During the Zynq FPGA manager reviews we decided that manipulating the bitstream
> to be consumable by the driver is userland's job.

Moritz, Can you remind me what that issue was there (or point me to
that email, I can't find it)?  I don't think I had a problem with that
in your case.  In general I think if these drivers can take the
bitstream that comes from the manufacturer's tools and stuff it into
the FPGA, then we are accomplishing what we want.  So I am OK with
this here.  The intent of the driver is to load a standard rbf, same
as the other Altera FPGA drivers.

There is a problem here though it will be easy to fix.  This call to
revbit8x4 should happen in cyclonespi_write(), not in
cyclonespi_write_init(). The reason for that is that write_init() may
just get the first chunk of the image (the header) and that write()
will be called multiple times for the remaining chunks.  The current
FPGA manager API won't show this problem since you have to give
fpga_mgr_buf_load the whole image buffer at once.  But it is easy to
imagine that some time in the future we may want to expand the FPGA
manager API to support streaming where we don't have the whole buffer.

Thanks for submitting, Joshua.  Will be looking at this over the
next several days.

Alan
