From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 19 Jan 2017 08:39:01 +0100
Subject: [PATCH v6 03/25] usb: ulpi: Support device discovery via DT
In-Reply-To: <20170119063349.GB10621@b29397-desktop>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-4-stephen.boyd@linaro.org>
 <20170119063349.GB10621@b29397-desktop>
Message-ID: <20170119073901.GF14493@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:33:49PM +0800, Peter Chen wrote:
> On Wed, Dec 28, 2016 at 02:56:49PM -0800, Stephen Boyd wrote:
> > The qcom HSIC ULPI phy doesn't have any bits set in the vendor or
> > product ID registers. This makes it impossible to make a ULPI
> > driver match against the ID registers. Add support to discover
> > the ULPI phys via DT help alleviate this problem. In the DT case,
> > we'll look for a ULPI bus node underneath the device registering
> > the ULPI viewport (or the parent of that device to support
> > chipidea's device layout) and then match up the phy node
> > underneath that with the ULPI device that's created.
> > 
> > The side benefit of this is that we can use standard properties
> > in the phy node like clks, regulators, gpios, etc. because we
> > don't have firmware like ACPI to turn these things on for us. And
> > we can use the DT phy binding to point our phy consumer to the
> > phy provider.
> > 
> > The ULPI bus code supports native enumeration by reading the
> > vendor ID and product ID registers at device creation time, but
> > we can't be certain that those register reads will succeed if the
> > phy is not powered up. To avoid any problems with reading the ID
> > registers before the phy is powered we fallback to DT matching
> > when the ID reads fail.
> > 
> > If the ULPI spec had some generic power sequencing for these
> > registers we could put that into the ULPI bus layer and power up
> > the device before reading the ID registers. Unfortunately this
> > doesn't exist and the power sequence is usually device specific.
> > By having the device matched up with DT we can avoid this
> > problem.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: <devicetree@vger.kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> 
> Greg, is it ok I pick up this patch, and send it with chipidea
> changes together for 4.11-rc1 later?

No objection from me.

thanks,

greg k-h
