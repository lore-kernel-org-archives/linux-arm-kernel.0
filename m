From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 16:55:13 +0200
Subject: [PATCH] VFIO: platform: AMD xgbe reset module
In-Reply-To: <561FBC31.3020900@linaro.org>
References: <1444836792-2405-1-git-send-email-eric.auger@linaro.org>
 <5270338.MbsQ1bGczu@wuerfel> <561FBC31.3020900@linaro.org>
Message-ID: <37917545.AP0MxbQBzK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 16:46:09 Eric Auger wrote:
> > 
> > This is where we'd need a little more changes for this approach. Instead
> > of unbinding the device from its driver, the idea would be that the
> > driver remains bound as far as the driver model is concerned, but
> > it would be in a quiescent state where no other subsystem interacts with
> > it (i.e. it gets unregistered from networking core or whichever it uses).
> 
> Currently we use the same mechanism as for PCI, ie. unbind the native
> driver and then bind VFIO platform driver in its place. Don't you think
> changing this may be a pain for user-space tools that are designed to
> work that way for PCI?
>
> My personal preference would be to start with your first proposal since
> it looks (to me) less complex and "unknown" that the 2d approach.

We certainly can't easily change from one approach to the other without
breaking user expectations, so the decision needs to be made carefully.

The main observation here is that platform devices are unlike PCI in this
regard because they need extra per-device code. I have argued in the
past that we should not reuse the "VFIO" name here because it's actually
something else.  On the other hand, there are a lot of commonalities,
we just have to make sure we don't try to force the code into one model
that doesn't really work just to make it look more like PCI VFIO.

	Arnd
