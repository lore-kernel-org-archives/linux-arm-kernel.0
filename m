From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Aug 2011 21:32:04 +0530
Subject: [RFC/PATCH 10/14] dt: Add pd_size to AUXDATA structure
In-Reply-To: <CACxGe6tq43M6x-pQS4CHTsjiNORLgMzWXL7Hn0GzTFMNCrRzAA@mail.gmail.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-11-git-send-email-manjugk@ti.com>
	<4E42723D.1010501@ti.com>
	<CACxGe6tq43M6x-pQS4CHTsjiNORLgMzWXL7Hn0GzTFMNCrRzAA@mail.gmail.com>
Message-ID: <20110810160204.GA2091@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 07:16:30AM -0600, Grant Likely wrote:
> On Wed, Aug 10, 2011 at 5:57 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
> >>
> >> Add pd_size in the AUXDATA structure so that device drivers which require
> >> platform_data size can pass along with AUXDATA.
> >
> > It is really needed by device driver? Or is it because omap_device_build is
> > using platform_device_add_data that is doing a copy of the pdata and thus
> > require the size?
> 
> Yes, I have the same question.  What is the reason for needing the
> platform data size?

Yes. It is required by "omap_device_build" which in turn calls 
"platform_device_add_data" and copies using "kmemdup" and original
pdata pointer memory will get freed.

It is required by hwmod and not device driver. I can change description.

> 
> g.
> 
> >
> >> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >> ---
> >> ?drivers/of/platform.c ? ? ? | ? ?2 ++
> >> ?include/linux/of_platform.h | ? ?5 +++++
> >> ?2 files changed, 7 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >> index ebbbf42..4b27286 100644
> >> --- a/drivers/of/platform.c
> >> +++ b/drivers/of/platform.c
> >> @@ -565,6 +565,7 @@ static int of_platform_bus_create(struct device_node
> >> *bus,
> >> ? ? ? ?struct platform_device *dev;
> >> ? ? ? ?const char *bus_id = NULL;
> >> ? ? ? ?void *platform_data = NULL;
> >> + ? ? ? int pd_size;
> >
> > Maybe platform_data_size will be a little bit more consistent?

Thought shorter name is better and still it should be readable.

-M
