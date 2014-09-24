From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 14:23:38 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140924112902.GA23331@peterchendt>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <2923729.dtX0WmHSV0@wuerfel> <20140924112902.GA23331@peterchendt>
Message-ID: <2786668.t3YLqX5enD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 19:29:05 Peter Chen wrote:
> 
> So, it is IP CORE LIB (you suggest) vs IP CORE Platform Driver
> (dwc3, musb, chipidea) you are talking about, right? Except for
> creating another platform driver as well as related DT node (optional),
> are there any advantages compared to current IP core driver structure?

Having a library module usually requires less code, and is more consistent
with other drivers, which helps new developers understand what the
driver is doing.

The most important aspect though is the DT binding: once the structure
with separate kernel drivers leaks out into the DT format, you can't
easily change the driver any more, e.g. to make a property that was
introduced for one glue driver more general so it can get handled by
the common part. Having a single node lets us convert to the library
model later, so that would be a strong reason to keep the DT binding
simple, without child nodes.

Following that logic, it turns into another reason for using the library
model to start with, because otherwise the child device does not have
any DT properties itself and has to rely on the parent device properties,
which somewhat complicates the driver structure.

> In this thread, we are talking about creating common platform driver for glue
> layer, its design purpose (adapt it for as many as platforms) should be the
> same, no matter the IP core part is a LIB or platform driver, am I missing
> something?

No, you are absolutely right with that, introducing the generic glue
driver is orthogonal to the structure of the core driver in principle.

I mainly brought it up because I noticed how this patch could be done
in a simpler way by combining the new generic glue with the move to
a library driver model.

	Arnd
